// Run only on a trusted machine with Application Default Credentials for this project.
// Install dependencies in firebase/functions first, then invoke: node grant-admin.mjs FIREBASE_UID
import {initializeApp,applicationDefault} from 'firebase-admin/app';
import {getAuth} from 'firebase-admin/auth';
const uid=process.argv[2];if(!uid)throw Error('Usage: node grant-admin.mjs FIREBASE_UID');
initializeApp({credential:applicationDefault()});
const user=await getAuth().getUser(uid);
if(!user.phoneNumber)throw Error('The administrator must have a verified phone number.');
await getAuth().setCustomUserClaims(uid,{...user.customClaims,role:'authenticated',vmart_admin:true});
console.log('Administrator role assigned. Sign out and sign in again to refresh the token.');
