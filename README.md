# V Mart — GitHub source and hosting

Responsive grocery storefront and admin dashboard. This export uses React + Vite so it can run on ordinary static hosting. Firebase provides phone authentication; Supabase provides database/storage access and trusted checkout transactions.

## What is included

- Storefront (`index.html`) and admin page (`admin.html`).
- All 32 sample product photos, search, category browsing, product details, cart, animated navigation and offer cards.
- Phone OTP screens, Firebase integration, Supabase schema, seed data and Firebase role-assignment function.
- Editable React/TypeScript/CSS source, dependency lockfile, a GitHub Pages demo workflow, and Firebase Hosting configuration.

The ZIP has no account credentials, node_modules, Git history, or private Sites hosting identity. The existing hosted V Mart preview is unchanged.

## Choose where to host

You can keep this source in a GitHub repository. **GitHub Pages cannot be used to run a live e-commerce business.** Use it only for an unconfigured educational/demo version without collecting customer data. Use Firebase Hosting for the live storefront, with Firebase Auth and Supabase configured separately.

GitHub policy: https://docs.github.com/en/pages/getting-started-with-github-pages/github-pages-limits

## Easiest demo upload (no installation)

Use the separate `vmart-github-pages-demo.zip`:
1. Extract the ZIP on your computer.
2. Create a GitHub repository, such as `vmart-demo`.
3. Upload the extracted files and folders into the repository root. Upload the contents, not the ZIP and not an extra enclosing folder. Keep `assets/`, `products/`, `config.json`, `index.html`, and `admin.html` together. Include `.nojekyll` if your file browser shows it.
4. In repository Settings → Pages, choose **Deploy from a branch**, then **main** and **/(root)**. Save.
5. Open the URL GitHub supplies. The admin preview is available at the same URL plus `admin.html`.

Leave `config.json` empty for this demo. For later design/code changes, rebuild the source project and upload the new `dist/` contents.

## Upload editable source to GitHub

1. Extract `vmart-source.zip`.
2. Upload the contents of `vmart-github/` to the repository root. Include `.github/` to use the included workflow. GitHub Desktop is convenient for uploading the entire folder.
3. For the unconfigured demo, choose Settings → Pages → **GitHub Actions**. The included workflow installs dependencies, builds the site and publishes `dist/` whenever `main` changes. It stops if you add live backend configuration; use Firebase Hosting for that version.
4. Your repository may be named anything: asset paths are relative and support GitHub project subdirectories.

GitHub workflow documentation: https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages

## Edit and run locally

Install Node.js 22.18 or later (Node 22 LTS).

```sh
npm install --global pnpm@11.25.0
pnpm install --frozen-lockfile
pnpm dev
```

Open the URL printed by Vite. The admin view is `/admin.html`. Do not double-click the HTML files; the source requires Vite or a web server.

```sh
pnpm build
pnpm preview
pnpm test:database
```

`pnpm build` generates the ready-to-host `dist/` folder. Type checking and production compilation were verified for this export. The local database suite has 31 assertions. Live SMS, a real Supabase deployment and browser interaction testing remain unverified.

## Configure the live store

Edit `public/config.json` using Firebase **web app configuration**, your Supabase project URL and its **publishable/anon key**. All fields in this file are browser-visible. Never insert a Firebase service-account key or Supabase service-role key.

Follow `SETUP.md` to enable phone authentication, deploy the role function, run the SQL and assign your own administrator UID. Backend setup is essential; filling in the JSON alone does not create tables or grant admin access.

## Deploy to Firebase Hosting

From this project root, after completing setup:

```sh
npm install --global firebase-tools
firebase login
pnpm build
firebase deploy --only hosting --project YOUR_FIREBASE_PROJECT_ID
```

The included root `firebase.json` publishes `dist/`. Add the resulting hostname to Firebase Authentication's authorised domains. The authentication Cloud Function is a separate deployment from the `firebase/` directory, explained in `SETUP.md`.

Firebase Hosting documentation: https://firebase.google.com/docs/hosting/quickstart

## Before accepting real orders

Verify product prices, stock, pack sizes, service pincodes, store details and product photo permissions. Sample data came from the supplied HTML. Some pack shots show a different variant/pack size; replace with supplier-authorised images that match your real inventory. `ASSET-SOURCES.json` records provenance. Keep live ordering disabled until the phone/database checks in `SETUP.md` pass.
