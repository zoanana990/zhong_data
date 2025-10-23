@echo off
REM Windows 執行腳本
REM 功能：啟動虛擬環境並執行資料處理腳本

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo DAQ970A 資料處理 - Windows 執行腳本
echo ==========================================
echo.

REM 取得腳本所在目錄
set SCRIPT_DIR=%~dp0
set VENV_DIR=%SCRIPT_DIR%venv
set PROCESS_SCRIPT=%SCRIPT_DIR%process_data.py

REM 檢查虛擬環境是否存在
if not exist "%VENV_DIR%" (
    echo ❌ 錯誤：虛擬環境不存在
    echo 請先執行安裝腳本: install.bat
    pause
    exit /b 1
)

REM 檢查 process_data.py 是否存在
if not exist "%PROCESS_SCRIPT%" (
    echo ❌ 錯誤：找不到 process_data.py
    pause
    exit /b 1
)

echo 啟動虛擬環境...
call "%VENV_DIR%\Scripts\activate.bat"
echo ✓ 虛擬環境已啟動
echo.

echo 執行資料處理腳本...
echo ==========================================
echo.

REM 如果沒有提供參數，使用預設路徑
if "%1"=="" (
    set DEFAULT_PATH=%SCRIPT_DIR%20230618
    if exist "!DEFAULT_PATH!" (
        echo 使用預設路徑: !DEFAULT_PATH!
        python "%PROCESS_SCRIPT%" -p "!DEFAULT_PATH!"
    ) else (
        echo ❌ 錯誤：未提供路徑，且預設路徑不存在
        echo 使用方法: run.bat -p C:\path\to\data
        pause
        exit /b 1
    )
) else (
    REM 傳遞所有參數給 process_data.py
    python "%PROCESS_SCRIPT%" %*
)

echo.
echo ==========================================
echo ✓ 執行完成
echo ==========================================
echo.
pause
