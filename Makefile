export THEOS=/var/mobile/theos

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

DEBUG = 0
FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = App

# المكتبات الضرورية لمنع الكراش
App_FRAMEWORKS = IOKit UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController Metal MetalKit
App_EXTRA_FRAMEWORKS = JRMemory

App_CCFLAGS = -w -std=gnu++17 -fno-rtti -fno-exceptions -DNDEBUG -Wno-module-import-in-extern-c

# مسارات التضمين معدلة لتشمل مجلد SDK داخل mini
App_CFLAGS = -w -fobjc-arc \
    -I./mini/mini/ESP \
    -I./mini/mini/ESP/imgui \
    -I./mini/mini/ESP/KittyMemory \
    -I./mini/mini/ESP/JRMemory.framework/Headers \
    -I./mini/mini/SDK

# تجميع الملفات من المسارات الجديدة داخل المجلد المضغوط
App_FILES = $(wildcard mini/mini/ESP/*.mm) \
            $(wildcard mini/mini/ESP/*.cpp) \
            $(wildcard mini/mini/ESP/imgui/*.cpp) \
            $(wildcard mini/mini/SDK/*.cpp)

App_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
