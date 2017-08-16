LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_SRC_FILES := \
		src/ITtsService.cpp \
		src/callback/ITtsCallback.cpp \

LOCAL_SHARED_LIBRARIES := \
		libbinder \
		libutils

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include

ifeq ($(PLATFORM_SDK_VERSION), 22)
LOCAL_SHARED_LIBRARIES += libc++ libdl
LOCAL_C_INCLUDES += external/libcxx/include
endif

LOCAL_MODULE := libtts
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
		src/TtsOpus.cpp \
		src/TtsPlayer.cpp \
		src/TtsService.cpp \
		src/main.cpp

LOCAL_STATIC_LIBRARIES += libstlport_static

LOCAL_SHARED_LIBRARIES := \
		libbinder \
		libutils \
		libtts \
		libspeech \
		libropus \
		liblog

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/include \
		$(LOCAL_PATH)/../rokid-blacksiren/thirdparty/libjsonc/include
		falcon/external/libopus/include

ifeq ($(PLATFORM_SDK_VERSION), 22)
LOCAL_SHARED_LIBRARIES += libc++ libdl
LOCAL_C_INCLUDES += external/libcxx/include
endif

LOCAL_MODULE := tts_process
LOCAL_ARM_MODE := arm
LOCAL_CPPFLAGS := -DCURRENT_ANDROID_PLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION) -std=c++11
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_TARGET_ARCH := arm

#include $(BUILD_EXECUTABLE)