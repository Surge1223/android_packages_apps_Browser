LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
#Include res dir from libraries
appcompat_dir := ../../../$(SUPPORT_LIBRARY_ROOT)/v7/appcompat/res
cardview_dir := ../../../$(SUPPORT_LIBRARY_ROOT)/v7/cardview/res
recyclerview_dir := ../../../$(SUPPORT_LIBRARY_ROOT)/v7/recyclerview/res
design_dir := ../../../$(SUPPORT_LIBRARY_ROOT)/design/res

res_dirs := res $(appcompat_dir) $(cardview_dir) $(recyclerview_dir) $(design_dir)

LOCAL_STATIC_JAVA_LIBRARIES := \
        android-common \
        guava \
        android-support-v4 \
        android-support-v7-appcompat \
        android-support-v7-recyclerview \
        android-support-v7-cardview \
        android-support-v13  \
        android-support-design \
        libapache-http \
        libhttpcore \
        libapachelegacy

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res \
	    $(addprefix $(LOCAL_PATH)/, $(res_dirs))


LOCAL_SRC_FILES := \
        $(call all-java-files-under, src) \
        src/com/android/browser/EventLogTags.logtags

LOCAL_PACKAGE_NAME := Browser

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_AAPT_FLAGS := \
    --auto-add-overlay \
    --extra-packages android.support.v7.cardview \
    --extra-packages android.support.v7.appcompat

LOCAL_EMMA_COVERAGE_FILTER := *,-com.android.common.*

# We need the sound recorder for the Media Capture API.
LOCAL_REQUIRED_MODULES := SoundRecorder

include $(BUILD_PACKAGE)

# additionally, build tests in sub-folders in a separate .apk
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
   libapache-http:libs/apache-httpcomponents-httpcore.jar \
   libhttpcore:libs/httpcore-4.0.1.jar \
   libapachelegacy:libs/org.apache.http.legacy.jar
   
include $(BUILD_MULTI_PREBUILT)
