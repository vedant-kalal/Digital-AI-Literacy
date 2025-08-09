# AI-Powered Notebot Application

This application combines a Next.js frontend with a Python FastAPI backend to provide AI-powered document analysis, OCR text extraction, and chatbot functionality using Google's Gemini AI and Cloud Vision APIs.

## Architecture

- **Frontend**: Next.js 15 with TypeScript, Tailwind CSS, and shadcn/ui components
- **Backend**: Python FastAPI with Google Gemini AI and Cloud Vision API
- **Communication**: REST API calls between frontend and backend

## Setup Instructions

### 1. Backend Setup (Python)

#### Prerequisites
- Python 3.8 or higher
- Google Cloud Vision API credentials
- Google Gemini API key

#### Steps

1. **Navigate to the backend directory:**
   ```bash
   cd backend
   ```

2. **Run the setup script:**
   ```bash
   setup_backend.bat
   ```
   This will:
   - Create a Python virtual environment
   - Install all required dependencies
   - Set up the basic configuration

3. **Configure API keys:**
   - Get your Gemini API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Set up Google Cloud Vision API credentials:
     - Go to [Google Cloud Console](https://console.cloud.google.com/)
     - Create a new project or select existing one
     - Enable the Cloud Vision API
     - Create service account credentials
     - Download the JSON key file
   
4. **Update the `.env` file in the backend directory:**
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   GOOGLE_APPLICATION_CREDENTIALS=path_to_your_service_account_key.json
   HOST=localhost
   PORT=8000
   DEBUG=True
   ```

5. **Start the backend server:**
   ```bash
   start_backend.bat
   ```
   The backend will be available at `http://localhost:8000`

#### Manual Setup (Alternative)

If the batch files don't work, you can set up manually:

```bash
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python -m uvicorn main:app --reload --host localhost --port 8000
```

### 2. Frontend Setup (Next.js)

The frontend should already be set up if you followed the initial installation.

#### Verify Frontend Dependencies
```bash
pnpm install
```

#### Start the Frontend Development Server
```bash
pnpm dev
```
The frontend will be available at `http://localhost:3000`

## API Endpoints

The Python backend provides the following endpoints:

### Health Check
- **GET** `/health` - Check backend status and API configuration

### Chat Endpoints
- **POST** `/chat` - Send a message to Gemini AI
  ```json
  {
    "message": "Your question here",
    "context": "Optional context"
  }
  ```

- **POST** `/chat/with-image` - Chat with both text and image
  - Form data with `message` and `file` fields

### OCR Endpoints
- **POST** `/ocr/extract` - Extract text from uploaded image
  - Form data with `file` field

## Usage Examples

### Frontend Integration

```typescript
import { useAIChat, useOCR } from '@/hooks/use-ai-backend'

// In your component
const { sendMessage, isLoading, error } = useAIChat()
const { extractText } = useOCR()

// Send a chat message
const response = await sendMessage({
  message: "Explain quantum physics",
  context: "Educational content for students"
})

// Extract text from image
const text = await extractText(imageFile)
```

### Direct API Calls

```typescript
import { backendAPI } from '@/lib/api/backend'

// Chat with AI
const chatResponse = await backendAPI.chat({
  message: "What is machine learning?",
  context: "Computer science education"
})

// OCR text extraction
const ocrResponse = await backendAPI.extractTextFromImage(imageFile)
```

## Features

### Current Features
- ✅ Image upload and OCR text extraction
- ✅ AI-powered text summarization
- ✅ Automatic question generation for revision
- ✅ Chat with Gemini AI
- ✅ Real-time backend health monitoring
- ✅ Error handling and user feedback

### Planned Features
- 📄 PDF text extraction support
- 🎥 Video content analysis
- 📊 Advanced analytics and insights
- 💾 Save and export functionality
- 🔐 User authentication and data persistence

## Troubleshooting

### Backend Issues

1. **"Import could not be resolved" errors**: 
   - Make sure you've activated the virtual environment
   - Run `pip install -r requirements.txt`

2. **"Backend Offline" message**:
   - Check if the backend server is running on port 8000
   - Verify the `.env` file has correct API keys
   - Check the terminal for error messages

3. **API key errors**:
   - Verify your Gemini API key is correct
   - Ensure Google Cloud Vision API is enabled
   - Check that the service account has proper permissions

### Frontend Issues

1. **"Module not found" errors**:
   - Run `pnpm install` to ensure all dependencies are installed
   - Check that the file paths in imports are correct

2. **API connection issues**:
   - Verify the backend is running on `http://localhost:8000`
   - Check the `.env.local` file has the correct API URL

## Development

### Project Structure

```
/
├── app/                    # Next.js app directory
│   ├── notebot/           # Notebot page
│   └── ...
├── components/            # React components
├── hooks/                 # Custom React hooks
├── lib/                   # Utility libraries
│   └── api/              # API client code
├── backend/              # Python FastAPI backend
│   ├── main.py          # Main FastAPI application
│   ├── requirements.txt # Python dependencies
│   └── .env            # Environment variables
└── ...
```

### Adding New Features

1. **Backend**: Add new endpoints in `backend/main.py`
2. **Frontend API**: Update `lib/api/backend.ts` with new API methods
3. **React Hooks**: Create hooks in `hooks/` for complex state management
4. **UI Components**: Use existing components from `components/ui/`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test both frontend and backend
5. Submit a pull request

## License

This project is for educational purposes. Please ensure you comply with Google's API terms of service when using Gemini AI and Cloud Vision APIs.
