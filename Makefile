# تصحيح مسار الثيوس للعمل على GitHub Actions
export THEOS = $(HOME)/theos

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

DEBUG = 0
FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = App

# المكتبات الضرورية (يجب أن تظل كما هي)
App_FRAMEWORKS = IOKit UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController Metal MetalKit
App_EXTRA_FRAMEWORKS = JRMemory

# إعدادات المترجم لربط ملفاتك
App_CCFLAGS = -w -std=gnu++17 -fno-rtti -fno-exceptions -DNDEBUG
App_CFLAGS = -w -fobjc-arc \
    -I./ESP \
    -I./ESP/imgui \
    -I./ESP/KittyMemory \
    -I./ESP/JRMemory.framework/Headers \
    -I./SDK

# جلب ملفات الكود من مجلداتك بعد فك الضغط
App_FILES = $(wildcard ESP/*.mm) \
            $(wildcard ESP/imgui/*.cpp) \
            $(wildcard ESP/KittyMemory/*.cpp) \
            $(wildcard SDK/*.cpp) \
            $(wildcard SDK/*.mm) \
            metalbiew.mm

App_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
