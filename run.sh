#!/bin/bash
# Unix/Linux/macOS 執行腳本
# 功能：啟動虛擬環境並執行資料處理腳本

set -e  # 如果任何命令失敗，立即退出

echo "=========================================="
echo "DAQ970A 資料處理 - Unix 執行腳本"
echo "=========================================="
echo ""

# 取得腳本所在目錄
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VENV_DIR="$SCRIPT_DIR/venv"
PROCESS_SCRIPT="$SCRIPT_DIR/process_data.py"

# 檢查虛擬環境是否存在
if [ ! -d "$VENV_DIR" ]; then
    echo "❌ 錯誤：虛擬環境不存在"
    echo "請先執行安裝腳本: ./install.sh"
    exit 1
fi

# 檢查 process_data.py 是否存在
if [ ! -f "$PROCESS_SCRIPT" ]; then
    echo "❌ 錯誤：找不到 process_data.py"
    exit 1
fi

echo "啟動虛擬環境..."
source "$VENV_DIR/bin/activate"
echo "✓ 虛擬環境已啟動"
echo ""

echo "執行資料處理腳本..."
echo "=========================================="
echo ""

# 如果沒有提供參數，使用預設路徑
if [ $# -eq 0 ]; then
    # 使用預設路徑
    DEFAULT_PATH="$SCRIPT_DIR/20230618"
    if [ -d "$DEFAULT_PATH" ]; then
        echo "使用預設路徑: $DEFAULT_PATH"
        python3 "$PROCESS_SCRIPT" -p "$DEFAULT_PATH"
    else
        echo "❌ 錯誤：未提供路徑，且預設路徑不存在"
        echo "使用方法: ./run.sh -p /path/to/data"
        exit 1
    fi
else
    # 傳遞所有參數給 process_data.py
    python3 "$PROCESS_SCRIPT" "$@"
fi

echo ""
echo "=========================================="
echo "✓ 執行完成"
echo "=========================================="
