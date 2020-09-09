################################################################################
#
# VITAQUAKE2
#
################################################################################

LIBRETRO_VITAQUAKE2_VERSION = 75bbaea139c6a47ae1d0a0eaf919b433a20b2622
LIBRETRO_VITAQUAKE2_SITE = $(call github,libretro,vitaquake2,$(LIBRETRO_VITAQUAKE2_VERSION))

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI4),y)
LIBRETRO_VITAQUAKE2_SUPP_OPT=GLES1=1 GLES31=1
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI3),y)
LIBRETRO_VITAQUAKE2_SUPP_OPT=GLES=1
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI2),y)
LIBRETRO_VITAQUAKE2_SUPP_OPT=GLES=1
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_XU4),y)
LIBRETRO_VITAQUAKE2_SUPP_OPT=GLES=1
else
LIBRETRO_VITAQUAKE2_SUPP_OPT=
endif

define LIBRETRO_VITAQUAKE2_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)" $(LIBRETRO_VITAQUAKE2_SUPP_OPT)
endef

define LIBRETRO_VITAQUAKE2_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/vitaquake2_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/vitaquake2_libretro.so
endef

$(eval $(generic-package))
