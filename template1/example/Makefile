NAME1=test_gpio

default:all

all:tips $(NAME1)

tips:
	-@echo  "\033[32m Building $(NAME1) example ... \033[0m"

ifndef TOP_DIR
TOP_DIR=$(abspath $(shell pwd)/../)
endif

include $(TOP_DIR)/env.mk

#CFLAGS+=-I./
LDFLAGS += -Wl,--whole-archive #强制将符号加入最后的执行文件中否则会被编译器优化
LDFLAGS += -L$(TOP_DIR)/lib -Wl,-Bstatic -lgpio -Wl,-Bdynamic 
LDFLAGS += -Wl,--no-whole-archive
LDFLAGS += -lpthread -ldl

$(NAME1):test.o
	$(Q)$(CC) $^ -o $@ $(LDFLAGS)
	@$(E) "  Gen " $@

%.o:%.c
	$(Q)$(CC) -g -c $(CFLAGS) $< -o $@
	@$(E) "  CC " $<

clean:
	-@$(RM) *.o $(NAME1)


install:
	-@echo ""
	install -D -v $(NAME1) /opt/

.PHONY:clean $(NAME1)
