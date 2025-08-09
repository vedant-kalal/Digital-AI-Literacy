<div align="center">

# 🏆 	Navprabhat Digital AI Literacy — AI-Powered Learning Platform for Rural India

Winner of the “Maveric Effect” Hackathon

Bridging India’s digital divide with an accessible, multilingual, AI-first learning platform.

</div>

---

## Table of Contents

- What is Navprabhat Topic
- Why it matters (Maveric Effect Winner Story)
- Key Features
- Architecture Overview
- Project Structure
- One-Click Start (Recommended)
- Manual Setup and Configuration
- Environment Variables
- Backend API Reference
- Frontend Overview
- PDF & OCR Workflows
- Generating Roadmaps and PDFs
- Text-to-Speech and Audio
- Development, Testing, and Linting
- Troubleshooting and FAQs
- Security and Privacy
- Roadmap and Future Work
- Acknowledgments and Credits

---

## What is Navprabhat Topic

Navprabhat Topic is an AI-powered learning platform designed specifically for rural India. It provides personalized learning paths, an AI tutor, and an OCR-enabled NoteBot that turns images or PDFs into structured, study-ready notes, summaries, and question sets. The system is built to be simple to launch, resilient on Windows machines, friendly to intermittent connectivity, and secure with proper handling of API keys and credentials.

Built with a modern, pragmatic stack—Next.js on the frontend and FastAPI on the backend—it emphasizes usability, speed, and maintainability. You can start the entire stack with a single click and access all features via one link.

---

## Why it matters (Maveric Effect Winner Story)

Digital literacy is a foundational skill for participation in the modern economy, yet rural communities often face the steepest barriers: limited access to quality instruction, language diversity, and constraints in bandwidth and device capabilities. Navprabhat Topic directly tackles these challenges by:

- Offering personalized learning paths catered to different starting points and goals.
- Providing an AI tutor that can explain concepts in simple language, adapt to learner queries, and support multiple languages.
- Converting photos and PDFs of notes or learning materials into structured summaries and questions using OCR + LLMs.
- Delivering a one-link experience that reduces friction and onboarding time.

This approach, combined with robust engineering—clean Windows support, one-click start, clear health checks, and careful secret management—earned Navprabhat Topic top honors at the “Maveric Effect” hackathon. Judges highlighted the platform’s end-to-end polish, focus on inclusivity, and strong technical foundation.

---

## Key Features

- AI Tutor: A conversational assistant for concept explanations, examples, and step-by-step guidance.
- NoteBot (OCR + AI): Upload images or PDFs; extract text using OCR; generate structured summaries and questions.
- Learning Paths: Personalized, AI-generated roadmaps tailored to the learner’s goal.
- PDF Generation: Create clean PDF reports using fpdf2 and ReportLab backends.
- Text-to-Speech: Turn summaries into audio for on-the-go learning.
- One-Link Access: Everything served from a single URL for simplicity.
- Windows-Friendly: Batch scripts and cross-platform Python orchestrator.
- Secure by Default: .env and credentials are ignored; keys never committed.

---

## Architecture Overview

High level:

- Frontend: Next.js 15, React 19, TypeScript, Tailwind CSS 4. Serves the UI (pages like /notebot, /tutor, /learning-path, /dashboard, /auth).
- Backend: FastAPI (Uvicorn) exposed on port 8001. Endpoints for OCR, chat with Gemini, PDF generation, roadmaps, TTS, and health.
- AI Providers: Google Gemini for generation and reasoning; Google Cloud Vision for OCR (when available). Fallback to Gemini Vision for images.
- Orchestration: app.py launches backend and frontend, runs health checks, opens the browser, and cleans up processes.
- Ports and CORS: Frontend: 3000/3001. Backend: 8001. CORS enabled for localhost.

Data flow example (NoteBot OCR):

1) User uploads an image or PDF
2) Backend detects file type (magic bytes and extension) and extracts text
3) If PDF: PyPDF2 extracts text pages; if image: Vision API or Gemini Vision used
4) The extracted text can be enhanced and summarized by Gemini
5) User can generate a shareable PDF or audio version

---

## Project Structure

Condensed tree of the most relevant files and directories:

```
.
├─ app/                      # Next.js (App Router) UI
│  ├─ page.tsx               # Landing page
│  ├─ auth/page.tsx          # Auth screen (stub)
│  ├─ dashboard/page.tsx     # Dashboard
│  ├─ learning-path/page.tsx # Learning paths
│  ├─ notebot/page.tsx       # NoteBot UI
│  └─ tutor/page.tsx         # AI Tutor UI
│
├─ components/               # Reusable UI components (shadcn-style)
│  ├─ header.tsx
│  └─ ui/*                   # Buttons, cards, inputs, dialogs, etc.
│
├─ backend/                  # FastAPI backend
│  ├─ main.py                # API routes (OCR, chat, PDF, roadmap, TTS, health)
│  ├─ requirements.txt       # Backend dependencies
│  ├─ pdf_generator_fpdf.py  # fpdf2-based PDF generator
│  ├─ pdf_generator_weasy.py # Alternative HTML-to-PDF (optional)
│  ├─ roadmap_generator.py   # Gemini-based roadmap generator
│  ├─ roadmap_pdf.py         # ReportLab-based roadmap PDF builder
│  ├─ setup_backend.bat      # Windows setup (venv + pip install)
│  ├─ start_backend.bat      # Windows dev start (optional)
│  ├─ utils.py               # Utility helpers
│  └─ test_*.py              # Example backend tests
│
├─ app.py                    # Python orchestrator (start backend + frontend, health check, open browser)
├─ START_HERE.bat            # One-click start for Windows
├─ package.json              # Next.js scripts and dependencies
├─ next.config.mjs           # Next.js config (build, TS, headers)
├─ styles/                   # Global styles
├─ public/                   # Static assets
├─ .env / backend/.env       # Local-only environment configs (ignored)
└─ .gitignore                # Ignores env files & credentials
```

---

## One-Click Start (Recommended)

Use the Windows launcher for the smoothest experience:

1) Double-click START_HERE.bat
2) The script cleans up old processes, starts the backend and frontend, runs basic health checks, and opens the main app.
3) Access everything at:

http://localhost:3001

The launcher provides status feedback and quick links (NoteBot, Tutor, Learning Paths, Dashboard). Keep the window open while working; close it to stop servers.

---

## Manual Setup and Configuration

Prerequisites:

- Python 3.8+
- Node.js 18+
- Google Gemini API key
- Optional: Google Cloud Vision credentials (JSON service account key)

Backend (Windows):

- In a terminal at the repo root:
	- Run backend/setup_backend.bat (creates venv, upgrades pip, installs requirements)
	- Then run backend/start_backend.bat or: python -m uvicorn backend.main:app --reload --host localhost --port 8001

Frontend:

- From the project root: npm run dev
- Open http://localhost:3000 (the one-click launcher maps to 3001 for convenience)

Cross-platform orchestrator (optional):

- python app.py
- app.py starts the backend with your current Python, runs a /health check, installs missing deps if necessary, starts the frontend via npm, opens the browser, and tears down child processes on exit.

---

## Environment Variables

Create a .env file at the project root and/or backend/.env with these keys:

- GEMINI_API_KEY: Your Google Gemini API key. Required for AI chat, summaries, and OCR fallback.
- GOOGLE_APPLICATION_CREDENTIALS: Path to a Google Cloud JSON credentials file if using Vision API. Example: backend/credentials/vision-key.json
- HOST (optional): Backend host (default: localhost)
- PORT (optional): Backend port (default: 8001)

Important:

- .env files and credential JSON files are ignored by git; do not commit secrets.
- The backend automatically reads the environment via python-dotenv.
- If Vision credentials are set and the file exists, Vision client is initialized; otherwise, the system can still function with Gemini Vision for image OCR.

---

## Backend API Reference

Base URL (default): http://localhost:8001

- GET /health
	- Returns: status=healthy, gemini_configured, vision_available

- GET /
	- Returns: simple status message

- POST /ocr/extract
	- Multipart form-data: file (image or PDF)
	- Logic: Detects file type. If PDF: PyPDF2 text extraction. If image: Vision API first (if available), fallback to Gemini Vision.
	- Returns: { extracted_text, success, error }

- POST /ocr/pdf-report
	- Multipart form-data: file (PDF), summary (optional text)
	- Generates a new PDF report (ReportLab) embedding the extracted text and optional summary.
	- Returns: application/pdf stream

- POST /generate-pdf
	- Body params: title, extracted_text, summary, questions (strings)
	- Generates a compact, clean PDF (fpdf2) containing summary artifacts.
	- Returns: application/pdf stream

- POST /generate-roadmap
	- JSON: { topic: string }
	- Uses Gemini to compose a learning roadmap. Returns JSON with roadmap content.

- POST /download-roadmap-pdf
	- JSON: { topic: string, roadmap?: object|string }
	- Converts the roadmap to a nicely formatted PDF (ReportLab). If roadmap omitted, it will be generated.
	- Returns: application/pdf stream

- POST /notebot/chat
	- JSON: { question: string, notes_context: string }
	- Answers strictly from the provided notes context.

- POST /chat
	- JSON: { message: string, context?: string }
	- General Gemini-based chat (can include a context prefix).

- POST /chat/with-image
	- Multipart: message (string), file (image)
	- Gemini Vision-style multimodal Q&A.

- POST /enhance-summary
	- JSON: { text: string }
	- Pipeline: OCR correction → structured Markdown summary.

- POST /text-to-speech
	- JSON: { text: string }
	- Converts text to an MP3 stream (gTTS) with pre-processing for natural speech.

Note on models: The backend uses gemini-2.0-flash-thinking-exp across multiple endpoints for reasoning and consistency.

---

## Frontend Overview

Built with Next.js App Router, TypeScript, and a modern component library (shadcn-style primitives) for fast, accessible UI.

Key screens:

- Landing: Overview, value proposition, partners, and calls to action.
- AI Tutor (/tutor): Chat interface that integrates with backend /chat endpoints.
- NoteBot (/notebot): Upload images or PDFs, extract and enhance notes, generate summaries, questions, and PDFs.
- Learning Paths (/learning-path): Request and visualize AI-generated roadmaps; download PDF versions.
- Dashboard (/dashboard): Space for progress tracking and analytics.
- Auth (/auth): Placeholder for future authentication provider integration.

Styling and DX:

- Tailwind CSS 4 defaults with sensible design tokens.
- lucide-react icons for consistent visuals.
- React Markdown support for rendering AI-generated summaries.

---

## PDF & OCR Workflows

Image/PDF ingestion:

- The backend first identifies the file type (magic bytes + extension).
- For PDFs: PyPDF2 iterates pages and extracts text. If no text is found, a helpful error is surfaced.
- For images: If Vision credentials are present, Google Vision performs text detection. If Vision isn’t available, Gemini Vision handles text extraction from the PIL Image.

Enhancement and Summaries:

- Correct OCR Text: A Gemini prompt cleans common OCR errors, removes institution boilerplate, and preserves instructional content.
- Structured Summary: A separate Gemini prompt produces a Markdown study guide with headings and bullet points.

PDF Generation:

- fpdf2-based generator consolidates extracted text, summary, and questions into a compact, readable report.
- ReportLab-based generator is used for OCR report from a PDF upload and for Roadmap PDFs, providing fine typography and layout control.

Audio:

- The text-to-speech endpoint uses gTTS, with pre-processing that removes Markdown syntax and makes phrasing more natural for listening.

---

## Generating Roadmaps and PDFs

Roadmap generation and export:

- POST /generate-roadmap returns a JSON roadmap structure for a given topic using Gemini.
- POST /download-roadmap-pdf creates a high-quality PDF from either a provided roadmap object or a freshly generated one.

NoteBot summary PDF:

- POST /generate-pdf accepts title, extracted_text, summary, and questions, returning a PDF suitable for printing or sharing.

OCR → Summary PDF from a PDF file:

- POST /ocr/pdf-report accepts a PDF upload, extracts its text, and returns an OCR report PDF (with optional summary section).

---

## Development, Testing, and Linting

Frontend:

- npm run dev — local development server
- npm run build — production build
- npm run start — run the production server
- ESLint/TypeScript build errors are ignored in next.config.mjs for developer convenience during early iterations. Tighten these settings for production hardening.

Backend:

- backend/setup_backend.bat — creates venv and installs requirements
- python -m uvicorn backend.main:app --reload --host localhost --port 8001 — run backend
- test_ocr.py — quick helper script for OCR experiments (optional)
- Example tests exist in backend/test_*.py; you can add pytest to requirements for broader coverage.

Orchestrator:

- python app.py — starts backend and frontend, runs health checks, opens the browser, and handles clean shutdown.

---

## Troubleshooting and FAQs

Backend health check fails:

- Ensure Python 3.8+ is installed and accessible as python.
- Run backend/setup_backend.bat to create venv and install requirements.
- Verify http://localhost:8001/health returns status 200. If not, inspect console logs.
- Confirm GEMINI_API_KEY is set in .env and not the placeholder value.

Image OCR returns empty or garbled text:

- Check that your Vision credentials path is correct and the service account has access.
- Try higher-quality images with better contrast and resolution.
- The system falls back to Gemini Vision when Vision is unavailable.

PDF text extraction returns nothing:

- Some PDFs are image-only scans without embedded text. Use OCR on the images or run the PDF through an OCR tool first.
- The backend surfaces a clear error when no text can be extracted.

Ports already in use:

- The START_HERE.bat launcher proactively kills stale processes on 3001 and 8001.
- If you’re running other services on these ports, stop them or edit the scripts.

Secrets in git history:

- This repo’s .gitignore excludes .env and credentials. If you ever committed secrets, rotate them and scrub history using GitHub docs or git filter-repo.

Windows: npm not found or path issues:

- Install Node.js from the official website and reopen your terminal so PATH is refreshed.

---

## Security and Privacy

- .env files and credential JSONs are never committed; ensure keys are stored locally and securely.
- Only the minimal services are exposed on localhost by default. For deployment, put the API behind HTTPS and add authentication/authorization.
- OCR correction and summaries may include sensitive data in development samples; purge data after testing in shared environments.

---

## Roadmap and Future Work

- Offline-first improvements and PWA support for low-connectivity environments.
- Multi-language content generation and TTS voices for regional languages.
- Deeper analytics on learning progress and adaptive content difficulty.
- Educator dashboards for cohort management and assignments.
- Integrations with SMS/WhatsApp for nudges and reminders.
- Expand PDF rendering templates (visual diagrams, math typesetting).

---

## Acknowledgments and Credits

- Maveric Effect Hackathon — for the platform and recognition.
- Google Gemini — text, reasoning, and multimodal capabilities used in this project.
- Google Cloud Vision — high-quality OCR when available.
- Next.js, React, TypeScript, Tailwind CSS — for a great developer and user experience.
- FastAPI & Uvicorn — for fast, reliable Python APIs.

---

## License

This project currently has no open-source license specified. All rights reserved unless a LICENSE file is added. If you plan to open-source it, consider MIT, Apache-2.0, or GPL-3.0 and update this section accordingly.

---

## Quick Links

- One-link app (launcher default): http://localhost:3001
- Backend health: http://localhost:8001/health
- API docs (if enabled): http://localhost:8001/docs

Made with care for learners across rural India.
