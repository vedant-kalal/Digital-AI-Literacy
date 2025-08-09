@echo off
title Navprabhat Topic - Full Stack Application
color 0A

echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                    NAVPRABHAT TOPIC                          ║
echo  ║              AI-Powered Learning Platform                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.

:: Kill any existing processes on these ports
echo 🧹 Cleaning up existing processes...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :3001') do taskkill /f /pid %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :8001') do taskkill /f /pid %%a >nul 2>&1
timeout /t 2 /nobreak > nul

echo.
echo 🚀 Starting Backend Server...
cd backend
start /min "Backend" cmd /c "venv\Scripts\activate.bat && python -m uvicorn main:app --reload --host localhost --port 8001"
cd ..

echo ⏳ Waiting for backend to initialize...
timeout /t 5 /nobreak > nul

echo.
echo 🌐 Starting Frontend Server...
start /min "Frontend" cmd /c "npm run dev"

echo ⏳ Waiting for frontend to initialize...
timeout /t 10 /nobreak > nul

echo.
echo ✅ Checking server status...

:: Check if backend is running
curl -s http://localhost:8001/health >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Backend Server: RUNNING on http://localhost:8001
) else (
    echo ❌ Backend Server: NOT RESPONDING
)

:: Check if frontend is running  
curl -s http://localhost:3001 >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Frontend Server: RUNNING on http://localhost:3001
) else (
    echo ❌ Frontend Server: NOT RESPONDING
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🎉 APPLICATION READY!                     ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📱 ONE LINK FOR EVERYTHING:
echo    👉 http://localhost:3001
echo.
echo 🤖 Direct Access Links:
echo    📝 Notebot (AI + OCR):     http://localhost:3001/notebot
echo    💬 AI Tutor Chat:          http://localhost:3001/tutor  
echo    📚 Learning Paths:         http://localhost:3001/learning-path
echo    📊 Dashboard:              http://localhost:3001/dashboard
echo    🔐 Authentication:         http://localhost:3001/auth
echo.
echo 🔧 Developer Tools:
echo    🩺 Backend Health Check:   http://localhost:8001/health
echo    📋 API Documentation:     http://localhost:8001/docs
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║  🌟 MAIN APPLICATION LAUNCHING IN 3 SECONDS...               ║
echo ╚══════════════════════════════════════════════════════════════╝

timeout /t 3 /nobreak > nul

:: Open the main application
start http://localhost:3001

echo.
echo 🎯 Application is now running!
echo 📱 Use this ONE LINK: http://localhost:3001
echo.
echo 💡 TIP: Bookmark http://localhost:3001 to access everything!
echo.
echo ⚠️  IMPORTANT: Keep this window open to keep servers running.
echo    Close this window when you're done working.
echo.
pause
