bin_PROGRAMS = gpio-controller

gpio_controller_SOURCES = main.vala gpio.vala sysfs_gpio.vala
gpio_controller_CPPFLAGS = $(GPIO_CONTROLLER_CFLAGS)
gpio_controller_VALAFLAGS = --pkg gtk+-3.0

gpio_controller_LDADD = $(GPIO_CONTROLLER_LIBS)

-include $(top_srcdir)/git.mk
