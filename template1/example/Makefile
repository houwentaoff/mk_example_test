NAME1=test_gpio
default:all

all:tips $(NAME1)

tips:
	-@echo  "\033[32m Building example ... \033[0m"

ifndef TOP_DIR
TOP_DIR = $(shell pwd)/../../
endif

include ../env.mk

#CFLAGS+=-I./
LDFLAGS+=-L../lib -lgpio

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

.PHONY:clean
