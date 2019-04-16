#:set syntax=make
default:all
all:
## mk function
define INFO
	-@echo  "\033[32m install $(1)  ... \033[0m"
endef
#compile
#
#-Wl,-rpath选项则是指定运行编译时ld的搜索路径,指定后即可以用ldd a.out看见各个共享库的路径用readelf -d a.out可以看到多了一个（RPATH）的选项，即是共享动态库的路径
#-Wl,-Bdynamic -lpthread -Wl,-Bstatic -lomniORB4 -lomnithread -lomniDynamic4 -Wl,-Bdynamic  :一部分用动态库一部分用静态库，则使用上面的语句 -Bdynamic表动态，记得在最后加上-Wl,-Bdynamic以避免后面默认的链接如gcc_s等(gcc_s等没有静态库)，这种方法可以代替用依赖*.a的方法，-Wl表示后面跟的是链接参数。
#
#1. 编译.so时若要将其他.a编译进去不能使用-l进行链接，这是无效的，只有编译执行程序时才是有效的
install:
	$(call INFO, .vimrc)
	[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.back
