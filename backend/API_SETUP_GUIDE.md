# 🔑 API Keys Setup Guide

## 📁 **File Structure**
```
backend/
├── .env                              # ← Your API keys go here
├── main.py
├── credentials/
│   └── vision-service-account.json   # ← Your Google Cloud JSON file goes here
└── ...
```

## 🤖 **1. Google Gemini API Key Setup**

### Step 1: Get Your API Key
1. Visit: https://makersuite.google.com/app/apikey
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy the key (format: `AIzaSyA...`)

### Step 2: Add to .env File
Open `backend\.env` and replace the placeholder:
```env
GEMINI_API_KEY=AIzaSyA_your_actual_gemini_api_key_here
```

**Example:**
```env
GEMINI_API_KEY=AIzaSyB1234567890abcdefghijklmnopqrstuvwxyz
```

## 👁️ **2. Google Cloud Vision API Setup**

### Step 1: Create Google Cloud Project
1. Go to: https://console.cloud.google.com/
2. Create a new project or select existing one
3. Note your project ID

### Step 2: Enable Vision API
1. In Google Cloud Console, go to "APIs & Services" → "Library"
2. Search for "Cloud Vision API"
3. Click on it and press "Enable"

### Step 3: Create Service Account
1. Go to "APIs & Services" → "Credentials"
2. Click "Create Credentials" → "Service Account"
3. Fill in details:
   - Name: `vision-api-service`
   - Description: `Service account for OCR functionality`
4. Click "Create and Continue"
5. Skip role assignment for now, click "Done"

### Step 4: Download JSON Key
1. Click on the service account you just created
2. Go to "Keys" tab
3. Click "Add Key" → "Create New Key"
4. Select "JSON" format
5. Download the file

### Step 5: Place JSON File
1. Rename the downloaded file to `vision-service-account.json`
2. Place it in: `backend\credentials\vision-service-account.json`

### Step 6: Update .env File
The `.env` file should already be configured:
```env
GOOGLE_APPLICATION_CREDENTIALS=./credentials/vision-service-account.json
```

## 🔒 **Security Notes**

### ✅ **DO:**
- Keep your `.env` file secure and never commit it to version control
- Store JSON credentials in the `credentials/` folder
- Use environment variables for sensitive data

### ❌ **DON'T:**
- Share your API keys publicly
- Commit credential files to Git
- Hardcode keys in your source code

## 🧪 **Testing Your Setup**

### 1. Restart Your Backend Server
After adding keys, restart the server:
```bash
cd backend
python main.py
```

### 2. Check Health Endpoint
Visit: http://localhost:8001/health

You should see:
```json
{
  "status": "healthy",
  "gemini_configured": true,    # ← Should be true after adding Gemini key
  "vision_available": true      # ← Should be true after adding Vision credentials
}
```

### 3. Test in Your Frontend
- Go to: http://localhost:3000/tutor
- Try chatting (requires Gemini API key)
- Go to: http://localhost:3000/notebot  
- Try uploading an image (requires Vision API)

## 💰 **Pricing Information**

### Gemini API (Free Tier)
- 60 requests per minute
- 1,500 requests per day
- Free for personal/educational use

### Google Cloud Vision API
- First 1,000 units per month: Free
- After that: $1.50 per 1,000 units
- OCR text detection counts as 1 unit per image

## 🚨 **Troubleshooting**

### Common Issues:

1. **"API key not valid"**
   - Double-check your Gemini API key in `.env`
   - Make sure there are no extra spaces

2. **"Vision API not configured"**
   - Ensure JSON file is in correct location
   - Check that Vision API is enabled in Google Cloud
   - Verify service account has proper permissions

3. **"Module not found"**
   - Make sure you're running from the `backend` directory
   - Activate your virtual environment

### Quick Test Commands:
```bash
# Test if Python can load your .env file
cd backend
python -c "from dotenv import load_dotenv; import os; load_dotenv(); print(f'Gemini: {bool(os.getenv(\"GEMINI_API_KEY\"))}')"

# Test if Vision credentials are found
python -c "import os; from dotenv import load_dotenv; load_dotenv(); print(f'Vision: {os.path.exists(os.getenv(\"GOOGLE_APPLICATION_CREDENTIALS\", \"\"))}')"
```

## ✅ **Quick Start Checklist**

- [ ] Get Gemini API key from Google AI Studio
- [ ] Add Gemini key to `backend\.env`
- [ ] Create Google Cloud project
- [ ] Enable Vision API
- [ ] Create service account
- [ ] Download JSON credentials
- [ ] Place JSON file in `backend\credentials\`
- [ ] Restart backend server
- [ ] Check health endpoint shows both APIs as configured
- [ ] Test chat functionality
- [ ] Test image upload functionality

Once you complete these steps, your AI-powered application will be fully functional! 🎉
