import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { fileURLToPath } from 'node:url';
export default defineConfig({
 base: './',
 plugins: [react()],
 resolve: { alias: { '@': fileURLToPath(new URL('.', import.meta.url)) } },
 build: { rollupOptions: { input: {
  store: fileURLToPath(new URL('./index.html', import.meta.url)),
  admin: fileURLToPath(new URL('./admin.html', import.meta.url))
 } } }
});
