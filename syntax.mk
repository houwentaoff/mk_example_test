#vim syntax=make
#CFLAGS := -D MAX_NUM=12
#CFLAGS += -D USE_A 
default:all #此处若为变量则需要在default之前定义否则此处解析时为空
## 在make 的时候执行的shell命令
$(shell mkdir -p /tmp/aa/bb/cc )

AAA:=1

DIRS := $(shell for d in `ls`; \
			do \
				[ -d $$d ] &&  \
				echo -n "$$d "; \
			done \
)	
all:
## mk function
define INFO
	-@echo  "\033[32m install $(1)  ... \033[0m"
endef

ifeq:
#make -f syntax.mk ifeq AAA=PLANTFORM_B 这样进行测试
# ifeq A 或者 B的用法, 用于多个平台
ifeq ($(AAA), $(filter PLANTFORM_A PLANTFORM_B, $(AAA)))
	echo "a b" $(AAA)
endif
ifeq ($(AAA), 1)
	echo $(AAA)	
else ifeq ($(AAA), 2)
	echo $(AAA)
else ifeq ($(AAA), 3)
	echo $(AAA)
endif

SUBDIRS=src example
# 用ifnef来判断变量是否定义
ifndef TOP_DIR
	# 用shell函数获取绝对路径
	TOP_DIR = $(dir $(shell pwd)/../)
	# abspath 获取绝对路径
	TOP1_DIR = $(abspath $(shell pwd)/../)
endif
# 用include来插入其它mk文件
-include env.mk
shell:
	echo $(DIRS)
	-@$(foreach d,$(DIRS),ls -l  $d) #foreach 返回 字符串， 此句运行 是有错误的
	echo "foreach"
	-@$(foreach d,`ls`, $(MAKE) -C   $d all) #foreach 返回 字符串， 此句 运行是错误的
#compile
#
#-Wl,-rpath选项则是指定运行编译时ld的搜索路径,指定后即可以用ldd a.out看见各个共享库的路径用readelf -d a.out可以看到多了一个（RPATH）的选项，即是共享动态库的路径
#-Wl,-Bdynamic -lpthread -Wl,-Bstatic -lomniORB4 -lomnithread -lomniDynamic4 -Wl,-Bdynamic  :一部分用动态库一部分用静态库，则使用上面的语句 -Bdynamic表动态，记得在最后加上-Wl,-Bdynamic以避免后面默认的链接如gcc_s等(gcc_s等没有静态库)，这种方法可以代替用依赖*.a的方法，-Wl表示后面跟的是链接参数。
#
#1. 编译.so时若要将其他.a编译进去不能使用-l进行链接，这是无效的，只有编译执行程序时才是有效的
install:
	echo "top dir " $(TOP_DIR)
	echo "top1 dir " $(TOP1_DIR)
	# $(call) 和 $()均可以直接调用函数
	$(call, INFO .vimrc)
	$(INFO .vimrc)
	# 如下是shell中的for语句 用$()和$$来区别shell变量和makefile变量
	for d in $(SUBDIRS); do [ -d $$d ] && $(MAKE) -C $$d; done
	[ -f ~/ccc ] && mv ~/aaa ~/vvv

main: main.o
	gcc $< -o $@ -L./ -ltest  #-L指定目录，-l指定库名字

libtest.a (a.o b.o) : a.o b.o #.so和后面的'('之间一定要有空格

	@echo '$$% = '$% #仅当目标是函数库文件中,表示规则中的目标成员名 扩展时只有一个文件

	@echo '$$@ = '$@ #规则中的目标文件集 扩展时只有一个文件 这个和'$^'我们常用

	@echo '$$? = '$? #所有比目标新的依赖目标的集合(哪些依赖文件发生改变则 $?会变成改变文件的集合)   扩展时一个文件名列表

	@echo '$$* = '$* #                        扩展时只有一个文件

	@echo '$$+ = '$+ #  也是所有依赖目标的集合。只是它不去除重复的依赖目标         扩展时一个文件名列表

	@echo '$$^ = '$^ #  所有的依赖目标的集合            扩展时一个文件名列表

	@echo '$$< = '$< #依赖目标中的第一个目标名字 扩展时只有一个文件

	ar cr $@ $? # ar cr 是打包为静态库，不是动态库

libtest.so:a.o b.o
	gcc -shared $? -o $@ #打包为动态库

%.o:%.c 
	gcc -c -fPIC $<  -o $@ # -fPIC 参数 便于生成动态库.so,否则会出现 can not be used when making a shared object; recompile with -fPIC 这种错误提示
# 打so.和.a参考libgpio的工程
.PHONY:clean
clean:
	-rm *.o  *.so *.a  -rf
#延迟变量 ?=和=赋值的都是延迟变量
HH  = 11 $(HH1)
HH1 = 22
HH2 := 44 $(HH)	
test_var:
	echo $(HH)
	#因为延迟变量在使用的适合才会展开。 会打印 11 22 33 
	echo $(HH2)
	#会打印 44 11 22 因为是立即变量，在定义的时候就已经展开 +=33在展开时还不存在
HH1 += 33	
