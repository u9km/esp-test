export THEOS = $(HOME)/theos

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

DEBUG = 0
FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = App

# المكتبات الضرورية
App_FRAMEWORKS = IOKit UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController Metal MetalKit
App_EXTRA_FRAMEWORKS = JRMemory

# إعدادات مسارات البحث - أضفنا -I. لكي يجد "ESP/metalbiew.h"
App_CFLAGS = -w -fobjc-arc -I. -I./ESP -I./SDK -I./ESP/JRMemory.framework/Headers
App_CCFLAGS = -w -std=gnu++17 -fno-rtti -fno-exceptions -DNDEBUG

# الملفات المراد بناؤها
App_FILES = metalbiew.mm $(wildcard ESP/*.mm) $(wildcard SDK/*.cpp)

App_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
