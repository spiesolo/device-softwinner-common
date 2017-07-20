intermediates := $(local-intermediates-dir)

SRC := $(call my-dir)/include/$(addprefix vnd_, $(addsuffix .txt,$(basename $(TARGET_DEVICE))))
ifeq (,$(wildcard $(SRC)))
# configuration file does not exist. Use default one
SRC := $(call my-dir)/include/vnd_generic.txt
endif
GEN := $(intermediates)/vnd_buildcfg.h

ifneq ($(wildcard external/bluetooth/bluedroid/tools/gen-buildcfg.sh),)
TOOL := $(TOP_DIR)external/bluetooth/bluedroid/tools/gen-buildcfg.sh
else
TOOL := $(LOCAL_PATH)/../gen-buildcfg.sh
endif

$(GEN): PRIVATE_PATH := $(call my-dir)
$(GEN): PRIVATE_CUSTOM_TOOL = $(TOOL) $< $@
$(GEN): $(SRC)  $(TOOL)
	$(transform-generated-source)

LOCAL_GENERATED_SOURCES += $(GEN)
