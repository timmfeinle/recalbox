################################################################################
#
# YABASANSHIRO
#
################################################################################

# https://github.com/libretro/yabause/tree/yabasanshiro/yabause/src/libretro
LIBRETRO_YABASANSHIRO_VERSION = 8406a5c11d7b6186a44c7fe48f493e6de5f8cb18
LIBRETRO_YABASANSHIRO_SITE = $(call github,libretro,yabause,$(LIBRETRO_YABASANSHIRO_VERSION))

LIBRETRO_YABASANSHIRO_PLATFORM = $(RETROARCH_LIBRETRO_PLATFORM)
LIBRETRO_YABASANSHIRO_SUPP_OPT =

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_XU4),y)
LIBRETRO_YABASANSHIRO_PLATFORM = odroid
LIBRETRO_YABASANSHIRO_SUPP_OPT += BOARD=ODROID-XU4
endif

LIBRETRO_YABASANSHIRO_MAKE_ARGS = platform="$(LIBRETRO_YABASANSHIRO_PLATFORM)" $(LIBRETRO_YABASANSHIRO_SUPP_OPT)

define LIBRETRO_YABASANSHIRO_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/yabause/src/libretro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" AR="$(TARGET_AR)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" -C $(@D)/yabause/src/libretro -f Makefile $(LIBRETRO_YABASANSHIRO_MAKE_ARGS)
endef

define LIBRETRO_YABASANSHIRO_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/yabause/src/libretro/yabasanshiro_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/yabasanshiro_libretro.so
endef

$(eval $(generic-package))
