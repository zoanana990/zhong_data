#!/bin/bash
# Unix/Linux/macOS 安裝腳本
# 功能：建立虛擬環境並安裝所有依賴套件

set -e  # 如果任何命令失敗，立即退出

echo "=========================================="
echo "DAQ970A 資料處理 - Unix 安裝腳本"
echo "=========================================="
echo ""

# 檢查 Python 是否已安裝
if ! command -v python3 &> /dev/null; then
    echo "❌ 錯誤：找不到 python3"
    echo "請先安裝 Python 3.7 或更新版本"
    exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
echo "✓ 找到 Python: $PYTHON_VERSION"
echo ""

# 取得腳本所在目錄
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VENV_DIR="$SCRIPT_DIR/venv"

echo "安裝位置: $SCRIPT_DIR"
echo "虛擬環境: $VENV_DIR"
echo ""

# 檢查虛擬環境是否已存在
if [ -d "$VENV_DIR" ]; then
    echo "⚠ 虛擬環境已存在"
    read -p "是否要重新建立虛擬環境？(y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "刪除舊的虛擬環境..."
        rm -rf "$VENV_DIR"
    else
        echo "使用現有虛擬環境"
    fi
fi

# 建立虛擬環境
if [ ! -d "$VENV_DIR" ]; then
    echo "建立虛擬環境..."
    python3 -m venv "$VENV_DIR"
    echo "✓ 虛擬環境建立完成"
fi

echo ""
echo "啟動虛擬環境..."
source "$VENV_DIR/bin/activate"
echo "✓ 虛擬環境已啟動"

echo ""
echo "升級 pip..."
pip install --upgrade pip setuptools wheel > /dev/null 2>&1
echo "✓ pip 已升級"

echo ""
echo "安裝依賴套件..."
pip install openpyxl pandas > /dev/null 2>&1
echo "✓ 依賴套件安裝完成"

echo ""
echo "=========================================="
echo "✓ 安裝完成！"
echo "=========================================="
echo ""
echo "使用方法："
echo "  執行腳本: ./run.sh"
echo "  或手動啟動虛擬環境: source venv/bin/activate"
echo "  然後執行: python3 process_data.py"
echo ""

