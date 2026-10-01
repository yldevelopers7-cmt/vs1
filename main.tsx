import React,{Suspense,lazy} from 'react';
import {createRoot} from 'react-dom/client';
import {StoreProvider} from './lib/store';
import {Toaster} from './components/ui/sonner';
import './app/globals.css';
const Shop=lazy(()=>import('./app/page'));
const Admin=lazy(()=>import('./app/admin/page'));
const root=document.getElementById('root')!;
createRoot(root).render(<StoreProvider><Suspense fallback={<p style={{padding:32}}>Opening V Mart…</p>}>{root.dataset.page==='admin'?<Admin/>:<Shop/>}</Suspense><Toaster position="top-center" richColors/></StoreProvider>);
