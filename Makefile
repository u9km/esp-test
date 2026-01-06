export THEOS=/var/mobile/theos

# المعماريات وإصدار النظام لضمان الاستقرار
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

# إعدادات المترجم لدعم C++17 ومسارات البحث عن الـ Headers
App_CCFLAGS = -w -std=gnu++17 -fno-rtti -fno-exceptions -DNDEBUG -Wno-module-import-in-extern-c

# مسارات التضمين لكافة مجلدات المشروع الجديد
App_CFLAGS = -w -fobjc-arc \
    -I./ESP \
    -I./ESP/imgui \
    -I./ESP/KittyMemory \
    -I./ESP/HOST7 \
    -I./ESP/1 \
    -I./ESP/防禁令 \
    -I./ESP/JRMemory.framework/Headers \
    -I./SDK

# [span_2](start_span)تجميع كافة ملفات الكود من المجلدات المتداخلة[span_2](end_span)
App_FILES = $(wildcard ESP/*.mm) \
            $(wildcard ESP/*.m) \
            $(wildcard ESP/*.cpp) \
            $(wildcard ESP/imgui/*.cpp) \
            $(wildcard ESP/imgui/*.mm) \
            $(wildcard ESP/KittyMemory/*.cpp) \
            $(wildcard ESP/HOST7/*.m) \
            $(wildcard ESP/1/*.mm) \
            $(wildcard ESP/防禁令/*.mm) \
            $(wildcard SDK/*.cpp)

# السطر السحري لمنع الكراش عند الحقن (بدون جلبريك)
App_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
