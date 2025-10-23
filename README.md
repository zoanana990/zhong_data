# DAQ970A 資料處理工具

完整的自動化腳本，用於處理 DAQ970A 資料採集器的 Excel 檔案。

## 📋 目錄

- [快速開始](#快速開始)
- [安裝](#安裝)
- [使用方法](#使用方法)
- [功能說明](#功能說明)
- [檔案結構](#檔案結構)
- [常見問題](#常見問題)
- [技術細節](#技術細節)

---

## 🚀 快速開始

### macOS / Linux

```bash
# 第一次使用（安裝）
./install.sh

# 之後每次執行
./run.sh
```

### Windows

```cmd
# 第一次使用（安裝）
install.bat

# 之後每次執行
run.bat
```

---

## 📦 安裝

### 系統需求

- **Python 3.7 或更新版本**
- **macOS / Linux / Windows**
- **至少 100MB 磁碟空間**（用於虛擬環境和套件）

### 安裝步驟

#### macOS / Linux

```bash
# 1. 進入專案目錄
cd /path/to/zhong

# 2. 執行安裝腳本
./install.sh

# 3. 等待安裝完成
```

#### Windows

```cmd
# 1. 進入專案目錄
cd C:\path\to\zhong

# 2. 執行安裝腳本
install.bat

# 3. 等待安裝完成
```

### 安裝腳本做什麼？

1. ✓ 檢查 Python 版本
2. ✓ 建立虛擬環境（`venv` 資料夾）
3. ✓ 升級 pip
4. ✓ 安裝依賴套件：
   - `openpyxl` - 讀取 Excel 檔案
   - `pandas` - 資料處理

---

## 💻 使用方法

### 基本使用

#### 使用執行腳本（推薦）

```bash
# macOS / Linux
./run.sh

# Windows
run.bat
```

#### 手動執行

```bash
# macOS / Linux
source venv/bin/activate
python3 process_data.py -p /path/to/data

# Windows
venv\Scripts\activate.bat
python process_data.py -p C:\path\to\data
```

### 命令行參數

```bash
python3 process_data.py -p /path/to/data
```

**參數說明：**

| 參數 | 說明 | 必需 |
|------|------|------|
| `-p, --path` | 資料夾路徑 | ✓ 是 |

**範例：**

```bash
# 使用絕對路徑
python3 process_data.py -p /Users/harry.chen/code/sstr/zhong/20230618

# 使用相對路徑
python3 process_data.py -p ./data

# 查看幫助
python3 process_data.py --help
```

---

## 🎯 功能說明

### 主要功能

1. **自動掃描資料夾** - 掃描指定路徑中的所有子資料夾
2. **提取通道資料** - 從每個 Excel 檔案中提取通道 101 到 322 的數值
3. **忽略時間欄位** - 自動排除所有包含「时间」的欄位
4. **計算平均值** - 計算每個通道的平均值
5. **按功率排序** - 結果按功率大小排序（18W → 36W → ... → 376W）
6. **輸出結果** - 在終端顯示結果，並保存到 CSV 檔案

### 資料驗證

腳本會自動：
- ✓ 排除異常值（絕對值 > 1e10）
- ✓ 排除時間戳和日期時間物件
- ✓ 排除所有包含「时间」的欄位
- ✓ 自動檢測標題行位置

### 輸出說明

#### 終端輸出

顯示兩部分結果：

1. **詳細結果**（按資料夾）
   - 每個資料夾中各通道的平均值
   - 資料點數

2. **總結表格**
   - 所有資料夾的平均值對比
   - 按功率大小排序

#### CSV 檔案

結果自動保存到 `results.csv`，可用 Excel 或其他試算表軟體開啟。

---

## 📁 檔案結構

```
zhong/
├── 安裝和執行腳本
│   ├── install.sh              # Unix/Linux/macOS 安裝腳本
│   ├── install.bat             # Windows 安裝腳本
│   ├── run.sh                  # Unix/Linux/macOS 執行腳本
│   └── run.bat                 # Windows 執行腳本
├── 配置
│   └── requirements.txt        # Python 依賴套件列表
├── 主程式
│   └── process_data.py         # 資料處理腳本
├── 文件
│   └── README.md               # 本檔案
├── 虛擬環境
│   └── venv/                   # Python 虛擬環境（自動建立）
└── 輸出
    └── results.csv             # 資料處理結果
```

---

## ❓ 常見問題

### Q: 為什麼要使用虛擬環境？

A: 虛擬環境可以隔離專案的依賴套件，避免與系統其他 Python 專案衝突。

### Q: 如何重新安裝？

A: 刪除 `venv` 資料夾，然後重新執行安裝腳本：

```bash
# Unix/Linux/macOS
rm -rf venv
./install.sh

# Windows
rmdir /s venv
install.bat
```

### Q: 如何更新依賴套件？

A: 編輯 `requirements.txt`，然後在虛擬環境中執行：

```bash
source venv/bin/activate  # Unix/Linux/macOS
# 或
venv\Scripts\activate.bat  # Windows

pip install -r requirements.txt
```

### Q: 在 macOS 上執行腳本時出現「Permission denied」？

A: 執行以下命令給予執行權限：

```bash
chmod +x install.sh run.sh
```

### Q: 找不到 python3？

A: 安裝 Python 3：
- **macOS**: `brew install python3`
- **Ubuntu/Debian**: `sudo apt-get install python3`
- **Windows**: 從 https://www.python.org/downloads/ 下載安裝

### Q: 虛擬環境啟動失敗？

A: 刪除 venv 資料夾重新安裝：

```bash
rm -rf venv
./install.sh
```

### Q: 找不到 openpyxl？

A: 確認虛擬環境已啟動，然後手動安裝：

```bash
source venv/bin/activate  # Unix/Linux/macOS
pip install openpyxl
```

---

## 🔧 技術細節

### 虛擬環境位置

- **Unix/Linux/macOS**: `./venv/bin/python3`
- **Windows**: `.\venv\Scripts\python.exe`

### 依賴套件版本

- openpyxl >= 3.0.0
- pandas >= 1.0.0

### Python 版本要求

- **最低**: Python 3.7
- **推薦**: Python 3.9 或更新版本

### 支援的平台

- ✅ macOS (Intel 和 Apple Silicon)
- ✅ Linux (Ubuntu, Debian, CentOS 等)
- ✅ Windows 10/11

### 資料處理流程

1. 掃描指定路徑中的所有子資料夾
2. 對每個子資料夾中的 Excel 檔案進行處理
3. 自動檢測標題行位置
4. 提取通道 101-322 的數值
5. 過濾異常值和時間欄位
6. 計算每個通道的平均值
7. 按功率大小排序結果
8. 輸出到終端和 CSV 檔案

---

## 📝 修改腳本

### 修改通道範圍

編輯 `process_data.py` 第 68 行：

```python
if channel_num and 101 <= channel_num <= 322:  # 修改這裡
```

### 修改異常值閾值

編輯 `process_data.py` 第 32 行：

```python
if abs(value) > 1e10:  # 修改這裡
```

### 修改輸出檔案名稱

編輯 `process_data.py` 第 178 行：

```python
csv_path = base_path.parent / "results.csv"  # 修改這裡
```

---

## 🐛 故障排除

### 問題：找不到 python3

**解決方案：** 安裝 Python 3
- macOS: `brew install python3`
- Ubuntu/Debian: `sudo apt-get install python3`
- Windows: 從 https://www.python.org/downloads/ 下載安裝

### 問題：虛擬環境啟動失敗

**解決方案：** 刪除 venv 資料夾重新安裝

```bash
rm -rf venv
./install.sh
```

### 問題：找不到 openpyxl

**解決方案：** 確認虛擬環境已啟動，然後手動安裝

```bash
source venv/bin/activate
pip install openpyxl
```

### 問題：路徑不存在錯誤

**解決方案：** 確認路徑正確

```bash
# 檢查路徑是否存在
ls -la /path/to/data

# 使用絕對路徑
python3 process_data.py -p /absolute/path/to/data
```

---

## 📞 支援

如有問題，請檢查：

1. Python 版本是否 >= 3.7
2. 虛擬環境是否已正確安裝
3. 路徑是否正確
4. 檔案權限是否正確

---

## 📄 授權

本專案為內部使用工具。

---

**最後更新**: 2025-10-24

