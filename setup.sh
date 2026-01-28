#!/bin/bash

# Cinemana Home Pro - Setup Script
# هذا السكريبت يساعد في تثبيت المتطلبات

set -e

echo "=========================================="
echo "Cinemana Home Pro - Setup Script"
echo "=========================================="
echo ""

# التحقق من نظام التشغيل
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✓ نظام التشغيل: Linux"
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "✓ نظام التشغيل: macOS"
    OS="macos"
else
    echo "✗ نظام التشغيل غير مدعوم: $OSTYPE"
    exit 1
fi

echo ""
echo "=========================================="
echo "تثبيت المتطلبات..."
echo "=========================================="
echo ""

# تثبيت المتطلبات على Linux
if [ "$OS" = "linux" ]; then
    echo "تثبيت المتطلبات على Ubuntu/Debian..."
    
    if ! command -v sudo &> /dev/null; then
        echo "✗ sudo غير مثبت"
        exit 1
    fi
    
    echo "تحديث قائمة الحزم..."
    sudo apt-get update
    
    echo "تثبيت الأدوات المطلوبة..."
    sudo apt-get install -y \
        build-essential \
        clang \
        lld \
        git \
        curl \
        wget \
        python3 \
        python3-pip \
        make
    
    echo "✓ تم تثبيت جميع المتطلبات على Linux"

# تثبيت المتطلبات على macOS
elif [ "$OS" = "macos" ]; then
    echo "تثبيت المتطلبات على macOS..."
    
    # التحقق من Homebrew
    if ! command -v brew &> /dev/null; then
        echo "تثبيت Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    echo "تثبيت الأدوات المطلوبة..."
    brew install llvm clang lld git curl wget python3 make
    
    echo "✓ تم تثبيت جميع المتطلبات على macOS"
fi

echo ""
echo "=========================================="
echo "تحميل OO_PS4_Toolchain..."
echo "=========================================="
echo ""

# مسار التثبيت
TOOLCHAIN_PATH="$HOME/OpenOrbis-PS4-Toolchain"

# التحقق من وجود الـ Toolchain
if [ -d "$TOOLCHAIN_PATH" ]; then
    echo "✓ OO_PS4_Toolchain موجود بالفعل في: $TOOLCHAIN_PATH"
else
    echo "تحميل OO_PS4_Toolchain..."
    cd "$HOME"
    
    # تحميل الـ Toolchain
    TOOLCHAIN_URL="https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/releases/download/v1.0/OpenOrbis-PS4-Toolchain-v1.0.tar.gz"
    
    if curl -L "$TOOLCHAIN_URL" -o "OpenOrbis-PS4-Toolchain-v1.0.tar.gz"; then
        echo "فك ضغط الملف..."
        tar -xzf "OpenOrbis-PS4-Toolchain-v1.0.tar.gz"
        rm "OpenOrbis-PS4-Toolchain-v1.0.tar.gz"
        echo "✓ تم تحميل وفك ضغط OO_PS4_Toolchain"
    else
        echo "✗ فشل تحميل OO_PS4_Toolchain"
        echo "يرجى تحميله يدويًا من:"
        echo "https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/releases"
        exit 1
    fi
fi

echo ""
echo "=========================================="
echo "إعداد متغيرات البيئة..."
echo "=========================================="
echo ""

# إضافة متغير البيئة إلى .bashrc و .zshrc
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "OO_PS4_TOOLCHAIN" "$HOME/.bashrc"; then
        echo "export OO_PS4_TOOLCHAIN=$TOOLCHAIN_PATH" >> "$HOME/.bashrc"
        echo "✓ تم إضافة OO_PS4_TOOLCHAIN إلى .bashrc"
    fi
fi

if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "OO_PS4_TOOLCHAIN" "$HOME/.zshrc"; then
        echo "export OO_PS4_TOOLCHAIN=$TOOLCHAIN_PATH" >> "$HOME/.zshrc"
        echo "✓ تم إضافة OO_PS4_TOOLCHAIN إلى .zshrc"
    fi
fi

# تعيين المتغير في الجلسة الحالية
export OO_PS4_TOOLCHAIN="$TOOLCHAIN_PATH"

echo ""
echo "=========================================="
echo "التحقق من التثبيت..."
echo "=========================================="
echo ""

# التحقق من Clang
if command -v clang &> /dev/null; then
    echo "✓ Clang: $(clang --version | head -n 1)"
else
    echo "✗ Clang غير مثبت"
    exit 1
fi

# التحقق من LLD
if command -v ld.lld &> /dev/null; then
    echo "✓ LLD: موجود"
else
    echo "✗ LLD غير مثبت"
    exit 1
fi

# التحقق من OO_PS4_TOOLCHAIN
if [ -d "$OO_PS4_TOOLCHAIN" ]; then
    echo "✓ OO_PS4_TOOLCHAIN: $OO_PS4_TOOLCHAIN"
else
    echo "✗ OO_PS4_TOOLCHAIN غير موجود"
    exit 1
fi

echo ""
echo "=========================================="
echo "✓ تم إعداد جميع المتطلبات بنجاح!"
echo "=========================================="
echo ""
echo "الخطوة التالية:"
echo "  cd cinemana-ps4-home"
echo "  make all"
echo ""
echo "ملاحظة: قد تحتاج إلى إعادة فتح الـ Terminal لتطبيق متغيرات البيئة"
echo ""
