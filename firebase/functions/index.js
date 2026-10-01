import {initializeApp} from 'firebase-admin/app';
import {getAuth} from 'firebase-admin/auth';
import {onCall,HttpsError} from 'firebase-functions/v2/https';
initializeApp();
// This callable can only add the ordinary database role to the caller's own account.
// It never accepts a UID or admin role from the client.
export const ensureSupabaseRole=onCall({region:'us-central1',maxInstances:5},async request=>{
 if(!request.auth)throw new HttpsError('unauthenticated','Sign in first.');
 if(!request.auth.token.phone_number)throw new HttpsError('failed-precondition','A verified phone number is required.');
 const user=await getAuth().getUser(request.auth.uid);
 const claims=user.customClaims||{};
 if(claims.role!=='authenticated')await getAuth().setCustomUserClaims(user.uid,{...claims,role:'authenticated'});
 return{ready:true};
});
