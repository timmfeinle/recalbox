################################################################################
#
# mupen64plus video GLIDEN64
#
################################################################################

# commit of 02/12/2020
MUPEN64PLUS_GLIDEN64_VERSION = 93524b65f7ce68438f400abb6b4f0b5195984725
MUPEN64PLUS_GLIDEN64_SITE = $(call github,gonetz,GLideN64,$(MUPEN64PLUS_GLIDEN64_VERSION))
MUPEN64PLUS_GLIDEN64_LICENSE = MIT
MUPEN64PLUS_GLIDEN64_DEPENDENCIES = sdl2 alsa-lib mupen64plus-core
MUPEN64PLUS_GLIDEN64_CONF_OPTS = -DMUPENPLUSAPI=On -DVEC4_OPT=On -DUSE_SYSTEM_LIBS=On -DUNIX=On -DNOHQ=On
MUPEN64PLUS_GLIDEN64_SUBDIR = /src/

MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
MUPEN64PLUS_GLIDEN64_DEPENDENCIES += rpi-userland
MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_RPI_FIXUP
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DEGL=On
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI4),y)
MUPEN64PLUS_GLIDEN64_DEPENDENCIES += mesa3d
MUPEN64PLUS_GLIDEN64_COMPILER_COMMONS_CFLAGS += "-DEGL_NO_X11"
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DEGL=On -DMESA=On
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_ODROIDXU4),y)
MUPEN64PLUS_GLIDEN64_DEPENDENCIES += mali-t62x
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DEGL=On -DODROID=On -DGLES2=On -DNEON_OPT=On
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_ODROIDGO2),y)
MUPEN64PLUS_GLIDEN64_DEPENDENCIES += rockchip-mali
MUPEN64PLUS_GLIDEN64_COMPILER_COMMONS_CFLAGS += "-DEGL_NO_X11"
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DEGL=On
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_X86)$(BR2_PACKAGE_RECALBOX_TARGET_X86_64),y)
MUPEN64PLUS_GLIDEN64_DEPENDENCIES += mesa3d
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DMESA=On -DX86_OPT=On
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DNEON_OPT=ON
endif

ifeq ($(BR2_PACKAGE_SDL2_KMSDRM),y)
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DSDL=ON
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_C2),y)
MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DGLES2=On
endif

define MUPEN64PLUS_GLIDEN64_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/recalbox/share_init/system/configs/mupen64/hires_texture
	$(INSTALL) -D $(@D)/src/plugin/Release/mupen64plus-video-GLideN64.so \
		$(TARGET_DIR)/usr/lib/mupen64plus/mupen64plus-video-gliden64.so
	$(INSTALL) -D $(@D)/ini/* \
		$(TARGET_DIR)/recalbox/share_init/system/configs/mupen64/
endef

define MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_FIXUP
	chmod +x $(@D)/src/getRevision.sh
	sh $(@D)/src/getRevision.sh
endef

define MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_RPI_FIXUP
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/src/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/src/CMakeLists.txt
endef

MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_FIXUP

$(eval $(cmake-package))
