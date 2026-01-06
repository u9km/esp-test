export THEOS=/var/mobile/theos

# المعماريات وإصدار النظام المستهدف لضمان الاستقرار
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

DEBUG = 0
FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = App

# المكتبات الضرورية لمنع انهيار الواجهة الرسومية (ImGui)
App_FRAMEWORKS = IOKit UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController Metal MetalKit
App_EXTRA_FRAMEWORKS = JRMemory

# إعدادات المترجم لدعم C++17
App_CCFLAGS = -w -std=gnu++17 -fno-rtti -fno-exceptions -DNDEBUG -Wno-module-import-in-extern-c

# مسارات التضمين للمجلدات داخل المشروع (المسارات المباشرة بعد فك الضغط)
App_CFLAGS = -w -fobjc-arc \
    -I./Project_ESP \
    -I./Project_ESP/imgui \
    -I./Project_ESP/KittyMemory \
    -I./Project_ESP/HOST7 \
    -I./Project_ESP/1 \
    -I./Project_ESP/防禁令 \
    -I./Project_ESP/JRMemory.framework/Headers \
    -I./Project_SDK

# تجميع الملفات البرمجية من المجلدات التي سيتم ترتيبها بواسطة YAML
App_FILES = $(wildcard Project_ESP/*.mm) \
            $(wildcard Project_ESP/*.m) \
            $(wildcard Project_ESP/*.cpp) \
            $(wildcard Project_ESP/imgui/*.cpp) \
            $(wildcard Project_ESP/imgui/*.mm) \
            $(wildcard Project_ESP/KittyMemory/*.cpp) \
            $(wildcard Project_ESP/HOST7/*.m) \
            $(wildcard Project_ESP/1/*.mm) \
            $(wildcard Project_ESP/防禁令/*.mm) \
            $(wildcard Project_SDK/*.cpp)

# أهم سطر لمنع الكراش في النسخ بدون جلبريك
App_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
