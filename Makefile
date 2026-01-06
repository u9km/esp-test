export THEOS = /var/mobile/theos
ARCHS = arm64
TARGET = iphone:clang:latest:14.0
TWEAK_NAME = App

# المكتبات الضرورية
App_FRAMEWORKS = IOKit UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController Metal MetalKit
App_EXTRA_FRAMEWORKS = JRMemory

# مسارات التضمين للمجلدات الجديدة
App_CFLAGS = -fobjc-arc -w -I./ESP -I./ESP/imgui -I./ESP/KittyMemory -I./ESP/JRMemory.framework/Headers -I./SDK
App_CCFLAGS = -std=gnu++17 -fno-rtti -fno-exceptions -DNDEBUG

# ملفات الكود بناءً على التسمية الإنجليزية الجديدة
App_FILES = $(wildcard ESP/*.mm) $(wildcard ESP/*.m) $(wildcard ESP/imgui/*.cpp) $(wildcard ESP/KittyMemory/*.cpp) $(wildcard SDK/*.cpp)

App_LDFLAGS += -Wl,-segalign,4000
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
