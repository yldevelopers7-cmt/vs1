import { initializeApp, getApps } from 'firebase/app';
import { getAuth, type Auth } from 'firebase/auth';
import { getFunctions, httpsCallable } from 'firebase/functions';
import { createClient, type SupabaseClient } from '@supabase/supabase-js';
export type Config={firebase:{apiKey:string;authDomain:string;projectId:string;appId:string};functionsRegion:string;supabaseUrl:string;supabaseKey:string};
let pending:Promise<{config:Config;auth:Auth|null;db:SupabaseClient|null}>;
export function services(){return pending??=(async()=>{
 const r=await fetch(new URL('./config.json',document.baseURI),{cache:'no-store'});if(!r.ok)throw Error('The store is temporarily unavailable. Please try again.');
 const config:Config=await r.json();
 const ready=Object.values(config.firebase).every(Boolean);
 const app=ready?(getApps()[0]||initializeApp(config.firebase)):null;
 const auth=app?getAuth(app):null;
 const db=config.supabaseUrl&&config.supabaseKey?createClient(config.supabaseUrl,config.supabaseKey,{accessToken:async()=>auth?.currentUser?await auth.currentUser.getIdToken():null,auth:{persistSession:false,autoRefreshToken:false,detectSessionInUrl:false}}):null;
 return{config,auth,db};
})();}
export async function ensureRole(){const {auth,config}=await services();if(!auth?.currentUser)throw Error('Please sign in again.');const token=await auth.currentUser.getIdTokenResult();if(token.claims.role!=='authenticated'){await httpsCallable(getFunctions(auth.app,config.functionsRegion),'ensureSupabaseRole')({});await auth.currentUser.getIdToken(true);}}
export function readableError(e:unknown){const error=e as {code?:string;message?:string};const messages:Record<string,string>={'auth/invalid-phone-number':'Enter a valid 10-digit Indian mobile number.','auth/invalid-verification-code':'That code is incorrect. Please check the SMS and try again.','auth/code-expired':'Your code has expired. Request a new code.','auth/too-many-requests':'Too many attempts. Please wait a little before trying again.','auth/quota-exceeded':'SMS sign-in is temporarily unavailable. Please try later.','auth/captcha-check-failed':'The security check expired. Please try again.','auth/unauthorized-domain':'Phone sign-in is not available on this website yet.','auth/network-request-failed':'Check your internet connection and try again.'};return messages[error.code||'']||error.message||'Something went wrong. Please try again.';}
