# ✅ Full Stack To-Do App

A cloud-native, full stack task management app built with Next.js, Supabase, and NextAuth. Designed to showcase modular UI, secure multi-user access, and real-world cloud architecture.

---

## 📦 Project Metadata

- **Author**: malicious-virtue
- **License**: MIT
- **Status**: In development
- **Tech Focus**: Full stack, cloud-native, modular design
- **Live Demo**: [your-vercel-url.vercel.app](https://your-vercel-url.vercel.app)

---

## 🚀 Features

- 🔐 GitHub authentication via NextAuth
- 🧠 Supabase Row Level Security (RLS)
- ✏️ Full CRUD: create, edit, delete, complete tasks
- 📊 Personalized analytics dashboard
- 🎨 Responsive UI with Tailwind CSS and dark mode
- ☁️ Serverless API routes and Vercel deployment

---

## 🧱 Architecture Overview

Client (Next.js + Tailwind)
└── UI Components, Auth Pages, Dashboard
└── API Routes (/api/tasks, /api/auth)
└── Supabase DB + Vercel Functions
└── Deployment via Vercel


---

## 📁 File Structure

See [`/src`](./src) for modular components, API routes, and type definitions. See [`LICENSE`](./LICENSE) for usage terms.

---

## 🔐 Supabase RLS Policies

```sql
auth.uid() = user_id
