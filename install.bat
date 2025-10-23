@echo off
REM Windows 安裝腳本
REM 功能：建立虛擬環境並安裝所有依賴套件

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo DAQ970A 資料處理 - Windows 安裝腳本
echo ==========================================
echo.

REM 檢查 Python 是否已安裝
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 錯誤：找不到 python
    echo 請先安裝 Python 3.7 或更新版本
    echo 下載位置: https://www.python.org/downloads/
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo ✓ 找到 Python: %PYTHON_VERSION%
echo.

REM 取得腳本所在目錄
set SCRIPT_DIR=%~dp0
set VENV_DIR=%SCRIPT_DIR%venv

echo 安裝位置: %SCRIPT_DIR%
echo 虛擬環境: %VENV_DIR%
echo.

REM 檢查虛擬環境是否已存在
if exist "%VENV_DIR%" (
    echo ⚠ 虛擬環境已存在
    set /p REPLY="是否要重新建立虛擬環境？(y/n) "
    if /i "!REPLY!"=="y" (
        echo 刪除舊的虛擬環境...
        rmdir /s /q "%VENV_DIR%"
    ) else (
        echo 使用現有虛擬環境
    )
)

REM 建立虛擬環境
if not exist "%VENV_DIR%" (
    echo 建立虛擬環境...
    python -m venv "%VENV_DIR%"
    echo ✓ 虛擬環境建立完成
)

echo.
echo 啟動虛擬環境...
call "%VENV_DIR%\Scripts\activate.bat"
echo ✓ 虛擬環境已啟動

echo.
echo 升級 pip...
python -m pip install --upgrade pip setuptools wheel >nul 2>&1
echo ✓ pip 已升級

echo.
echo 安裝依賴套件...
pip install openpyxl pandas >nul 2>&1
echo ✓ 依賴套件安裝完成

echo.
echo ==========================================
echo ✓ 安裝完成！
echo ==========================================
echo.
echo 使用方法：
echo   執行腳本: run.bat
echo   或手動啟動虛擬環境: venv\Scripts\activate.bat
echo   然後執行: python process_data.py
echo.
pause

