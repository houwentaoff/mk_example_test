
#CROSS_COMPILE=/opt/buildroot-master/output/host/usr/bin/arm-linux-
CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar
ARCH=arm
# 等价于config.h -->　#define MAX_NUM 12
# 等价于config.h -->　#define USE_A
CFLAGS += -D MAX_NUM=12 
CFLAGS += -D DEBUG 
CFLAGS += -D RTE_ARCH_64
CFLAGS += -D RTE_FORCE_INTRINSICS=y

CFLAGS += -g

CFLAGS += -I$(TOP_DIR)/include
#CFLAGS += --define-ABC   ABC=string #该句语法错误
V := 1
ifeq ($(V), 1)
	Q=
	E=true
else 
	Q=@
	E=echo
endif

export CC AR 

include $(TOP_DIR)/common.mk
