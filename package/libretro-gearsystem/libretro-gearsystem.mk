################################################################################
#
# GEARSYSTEM
#
################################################################################

LIBRETRO_GEARSYSTEM_VERSION = 5231acb6dbba8d1193327b3c5a3fff8ca9305e28
LIBRETRO_GEARSYSTEM_SITE = $(call github,drhelius,Gearsystem,$(LIBRETRO_GEARSYSTEM_VERSION))

define LIBRETRO_GEARSYSTEM_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/platforms/libretro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platforms/libretro -f Makefile platform="unix"
endef

define LIBRETRO_GEARSYSTEM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/platforms/libretro/gearsystem_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/gearsystem_libretro.so
endef

$(eval $(generic-package))