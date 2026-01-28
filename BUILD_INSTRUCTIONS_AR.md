# تعليمات بناء تطبيق Cinemana Home Pro للـ PS4

## معلومات التطبيق

- **اسم التطبيق**: Cinemana Home Pro
- **الإصدار**: 1.0.0
- **معرّف العنوان**: CINE0001
- **معرّف المحتوى**: IV0000-CINE0001_00-CINEMAHOME000PS4
- **الموقع المعروض**: http://cinemana.shabakaty.com/page/home/index/en
- **التطوير**: أحمد 4GAMER

## المتطلبات

### 1. نظام التشغيل
- **Linux** (Ubuntu 18.04 أو أحدث) - **موصى به**
- **macOS** (10.14 أو أحدث)
- **Windows** (مع WSL2)

### 2. أدوات التطوير المطلوبة

#### على Linux (Ubuntu/Debian):
```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    clang \
    lld \
    git \
    curl \
    wget \
    python3 \
    python3-pip
```

#### على macOS:
```bash
# تثبيت Homebrew أولاً إذا لم يكن مثبتاً
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# تثبيت الأدوات المطلوبة
brew install llvm clang lld git curl wget python3
```

### 3. تثبيت OO_PS4_TOOLCHAIN

هذه هي أهم خطوة. تحتاج إلى تحميل أدوات تطوير PS4 من مستودع OpenOrbis:

#### الخطوة 1: تحميل الـ Toolchain
```bash
# انتقل إلى المجلد الذي تريد تثبيت الأدوات فيه
cd ~/

# تحميل أحدث إصدار من OpenOrbis PS4 Toolchain
wget https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/releases/download/v1.0/OpenOrbis-PS4-Toolchain-v1.0.tar.gz

# فك الضغط
tar -xzf OpenOrbis-PS4-Toolchain-v1.0.tar.gz

# سيتم إنشاء مجلد باسم "OpenOrbis-PS4-Toolchain"
```

#### الخطوة 2: تعيين متغير البيئة
```bash
# أضف هذا السطر إلى ملف ~/.bashrc أو ~/.zshrc
export OO_PS4_TOOLCHAIN=~/OpenOrbis-PS4-Toolchain

# تحديث الجلسة الحالية
source ~/.bashrc
# أو
source ~/.zshrc
```

#### التحقق من التثبيت:
```bash
echo $OO_PS4_TOOLCHAIN
# يجب أن يطبع: /home/username/OpenOrbis-PS4-Toolchain
```

## خطوات البناء

### 1. استنساخ أو تحميل المشروع
```bash
# إذا كان لديك المشروع كملف ZIP
unzip cinemana-ps4-home.zip
cd cinemana-ps4-home

# أو إذا كان مستودع Git
git clone <repository-url>
cd cinemana-ps4-home
```

### 2. التحقق من الملفات المطلوبة
تأكد من وجود هذه الملفات والمجلدات:
```
cinemana-ps4-home/
├── Makefile                    # ملف البناء الرئيسي
├── source/                     # ملفات الكود المصدري
│   ├── main.c
│   ├── menu_main.c
│   ├── draw.c
│   └── ... (ملفات أخرى)
├── include/                    # ملفات الرؤوس
├── sce_sys/                    # ملفات نظام PS4
│   ├── param.sfo
│   ├── icon0.png
│   └── ...
├── assets/                     # الموارد والصور
└── sce_module/                 # وحدات النظام
```

### 3. تنظيف البناء السابق (اختياري)
```bash
cd cinemana-ps4-home
make clean
```

### 4. بناء التطبيق
```bash
cd cinemana-ps4-home
make all
```

**ملاحظة**: قد يستغرق البناء من 5-15 دقيقة حسب سرعة جهازك.

### 5. التحقق من النجاح
بعد انتهاء البناء، يجب أن تجد ملف PKG:
```bash
ls -lh IV0000-CINE0001_00-CINEMAHOME000PS4.pkg
```

إذا رأيت الملف، فقد نجح البناء! ✅

## استكشاف الأخطاء

### خطأ: "OO_PS4_TOOLCHAIN not set"
**الحل**: تأكد من تعيين متغير البيئة:
```bash
export OO_PS4_TOOLCHAIN=~/OpenOrbis-PS4-Toolchain
```

### خطأ: "clang: command not found"
**الحل**: تثبيت Clang:
```bash
# على Ubuntu
sudo apt-get install clang

# على macOS
brew install llvm
```

### خطأ: "PkgTool.Core not found"
**الحل**: تأكد من أن OO_PS4_TOOLCHAIN مثبت بشكل صحيح وأن المسار صحيح.

## تثبيت التطبيق على PS4

بعد إنشاء ملف PKG بنجاح:

1. انسخ ملف `IV0000-CINE0001_00-CINEMAHOME000PS4.pkg` إلى جهاز USB
2. أدرج جهاز USB في PS4
3. اذهب إلى **Settings > System Software > Update from USB Storage Device**
4. أو استخدم أداة مثل **FTP** لنقل الملف مباشرة

## الملفات المُنتجة

بعد البناء الناجح، ستجد:
- `IV0000-CINE0001_00-CINEMAHOME000PS4.pkg` - ملف التطبيق النهائي
- `eboot.bin` - الملف التنفيذي
- `pkg.gp4` - ملف وصف الحزمة

## الدعم والمساعدة

إذا واجهت مشاكل:
1. تحقق من أن جميع الملفات موجودة
2. تأكد من تثبيت جميع المتطلبات
3. جرب `make clean` ثم `make all` مرة أخرى

## معلومات إضافية

- **الموقع الرسمي**: http://cinemana.shabakaty.com
- **تطوير**: أحمد 4GAMER
- **الترخيص**: انظر ملف LICENSE

---

**ملاحظة مهمة**: هذا التطبيق مخصص للاستخدام على PS4 المعدلة (Jailbroken PS4) فقط.
