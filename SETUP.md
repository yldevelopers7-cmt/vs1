# V Mart setup

This project rebuilds the supplied customer and admin HTML files as one responsive React app. Storefront: `index.html`. Store management: `admin.html`. This GitHub export uses a static React/Vite frontend.

## What works before configuration

The supplied catalogue is shown as a clearly labelled store preview. Search, categories, price sorting, product details, quantity controls, local guest basket drafts, delivery checks, offer cards and mobile navigation work. Authentication and checkout do not simulate successful SMS or placed orders. Admin preview is read-only. Once configured, the catalogue, stock, accounts, saved items, signed-in baskets and orders use Supabase.

## 1. Firebase phone authentication

1. Create/select your Firebase project and add a web app. Copy its web configuration (`apiKey`, `authDomain`, `projectId`, `appId`).
2. Enable Authentication → Sign-in method → Phone. Configure the allowed SMS regions (India), quotas and required billing. Check current Firebase console requirements.
3. Add the deployed website hostname to Authentication → Settings → Authorised domains. Configure Firebase test numbers for development. Do not disable reCAPTCHA in production.
4. From the `firebase/functions` directory, install its dependencies. Deploy with the Firebase CLI from `firebase/`: `firebase deploy --only functions --project YOUR_PROJECT_ID`.
5. The included `ensureSupabaseRole` callable grants only `role: authenticated` to its authenticated caller. The client forces an ID-token refresh after the call. It never grants administrator privileges.
6. After signing in with your own phone, use the trusted Firebase Admin SDK script in `firebase/functions/grant-admin.mjs` to grant your UID the `vmart_admin: true` custom claim. Run with Application Default Credentials in a trusted local environment. Never upload service-account credentials to the website or share them in chat. Sign out and back in after assignment.

## 2. Supabase

1. Create/select your Supabase project. Run `supabase/schema.sql` in the SQL editor once on a new database, then run `supabase/seed.sql`. The seed is optional demonstration catalogue content copied from the supplied HTML; verify pricing, stock, pack sizes and imagery before opening the store.
2. Authentication → Third-party Auth → Add Firebase. Use the exact Firebase project ID. Hosted Supabase verifies Firebase token signatures, audience and issuer against this integration.
3. Copy the project URL and **publishable** key (or legacy anon key). Never expose a service-role/secret key to the browser.
4. The schema has RLS on all application tables. Firebase UIDs are text, not UUIDs. Customers can access only their own profile, basket, favourites and orders. Signed administrator claims control catalogue changes, photo uploads, store settings and order transitions.
5. `place_order` is the only customer order-write path. It locks the customer and product rows, validates service area and quantities, calculates all amounts from database prices, checks/decrements inventory and records a verified phone number in one transaction. A per-user request UUID makes retries idempotent. `set_order_status` enforces transitions and restores stock on cancellation exactly once.
6. Optional product photos use the `product-images` Storage bucket. Reads are public; writes require the signed admin claim. Uploads are limited to PNG/JPEG/WebP and 5 MB.

## 3. Browser configuration and hosting

Edit `public/config.json` with your Firebase web configuration and Supabase URL/publishable key. The frontend fetches this static JSON file; there is no `/api/config` server route in this export. Rebuild after changing the source config. Built files use `dist/config.json`.

For GitHub Pages, leave the configuration empty and use the educational demo only. GitHub Pages does not allow running a live e-commerce business. For the live store, keep the source on GitHub and deploy the frontend to Firebase Hosting using the root `firebase.json`. See README.md for commands.

No service-role, service-account or private credentials belong in `config.json`. Those are not needed by the browser. Supabase RLS and the separately deployed Firebase function enforce authentication and authorisation.

## 4. Go-live verification

- Use a Firebase test phone to verify reCAPTCHA, OTP resend/expiry, sign-in and profile creation.
- Confirm user A cannot access user B's profile, basket, saved items or orders.
- Confirm ordinary customers cannot change prices, stock, store settings or order states.
- Place a delivery and pickup order. Check free-delivery threshold, stock decrements and order totals in Supabase.
- Retry the same checkout request UUID and confirm one order/stock deduction.
- Cancel an order as admin; stock is restored. Repeating the cancellation must not restore twice.
- Verify authorised admin photo uploads and product changes appear in the storefront.
- Verify every price, SKU, pack size, product image, service pincode and store contact before serving customers.

## Design and source notes

The layout adapts the user's DMart reference screenshots: compact search header, category tiles, product shelves, cart drawer, phone/OTP onboarding and delivery selection. The supplied navigation animation is adapted for shopping actions. The uploaded card-stack interaction is adapted as keyboard- and swipe-operated grocery banners. Reduced-motion preferences are respected. No automatic carousel movement.

The original files kept customer and admin datasets separately in localStorage and used a plaintext browser-only admin password. Those authentication and order-storage paths were removed. Guest baskets remain temporary device-local drafts; they are merged with the account basket on sign-in and persisted to Supabase thereafter. Remote errors are shown rather than reported as success.

`ASSET-SOURCES.json` records product photography provenance. The produce hero is from Pexels. Retailer pack shots have no verified open licence; replace them with your own or supplier-authorised product photos before public commercial use. All 32 sample products have retailer pack shots or produce photographs. Some pack photos differ in size or variant from the supplied sample catalogue; verify or replace them before opening ordering.

Official integration references:
- https://firebase.google.com/docs/auth/web/phone-auth
- https://supabase.com/docs/guides/auth/third-party/firebase-auth

## Validation scope

TypeScript and production build are checked. The database transaction and access rules have a local integration test. Real SMS delivery, live Supabase policies/storage and cross-device persistence require your configured projects and have not been end-to-end verified in the published preview. Browser visual testing was unavailable in this environment.
