#
# library name
#
NAME=libgpio
LIB := $(NAME).a #该句要放在all之前否则all中的:$(LIB) 解析不出来

default:all
all:tips $(LIB)

tips:
	-@echo  "\033[32m Building $(NAME) ... \033[0m"

ifndef TOP_DIR
TOP_DIR = $(abspath $(shell pwd)/../)
endif

include $(TOP_DIR)/env.mk
# build flags
CFLAGS += -D _GNU_SOURCE

CONFIG_RTE_LIBRTE_PMD_CAAM_JR=y
SRCS-$(CONFIG_RTE_LIBRTE_PMD_CAAM_JR) += gpio.c
#SRCS-$(CONFIG_RTE_LIBRTE_PMD_CAAM_JR) += a.c
OBJS:=$(patsubst %.c,%.o, $(SRCS-y))

$(LIB):$(OBJS)
	-@mkdir -p $(TOP_DIR)/lib
	$(Q)$(AR) cr $(TOP_DIR)/lib/$@ $^ 
	@$(E) "  AR " $^
	$(Q)$(CC) -shared -fPIC -o ../lib/libgpio.so $^
	@$(E) "  Shared " $^

%.o:%.c
	$(Q)$(CC) -c $(CFLAGS) $< -o $@
	@$(E) "  CC " $<

clean:
	-@$(RM) $(OBJS) *.a $(TOP_DIR)/lib/$(LIB) $(TOP_DIR)/lib/*.so

install:
	-@install -v $(TOP_DIR)/lib/$(LIB) $(DST_DIR)
	-@install -v $(TOP_DIR)/lib/*.so $(DST_DIR)

.PHONY:clean
