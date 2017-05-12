LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
		$(call all-java-files-under, src)

LOCAL_JAVA_LIBRARIES := \
	framework \

LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
LOCAL_PACKAGE_NAME := demo

LOCAL_PROGUARD_ENABLED := disabled

include $(BUILD_PACKAGE)