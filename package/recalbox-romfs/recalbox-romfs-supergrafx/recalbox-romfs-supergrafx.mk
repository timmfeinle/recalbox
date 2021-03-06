################################################################################
#
# recalbox-romfs-supergrafx
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --force --system supergrafx --extension '.pce .PCE .sgx .SGX .cue .CUE .ccd .CCD .chd .CHD .zip .ZIP .7z .7Z' --fullname 'Supergrafx' --platform supergrafx --theme supergrafx 1:libretro:mednafen_supergrafx:BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX 2:libretro:fbneo:BR2_PACKAGE_LIBRETRO_FBNEO

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SUPERGRAFX_SOURCE = 
RECALBOX_ROMFS_SUPERGRAFX_SITE = 
RECALBOX_ROMFS_SUPERGRAFX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SUPERGRAFX = supergrafx
SYSTEM_XML_SUPERGRAFX = $(@D)/$(SYSTEM_NAME_SUPERGRAFX).xml
# System rom path
SOURCE_ROMDIR_SUPERGRAFX = $(RECALBOX_ROMFS_SUPERGRAFX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_FBNEO),)
define CONFIGURE_MAIN_SUPERGRAFX_START
	$(call RECALBOX_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_SUPERGRAFX),Supergrafx,$(SYSTEM_NAME_SUPERGRAFX),.pce .PCE .sgx .SGX .cue .CUE .ccd .CCD .chd .CHD .zip .ZIP .7z .7Z,supergrafx,supergrafx)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_FBNEO),)
define CONFIGURE_SUPERGRAFX_LIBRETRO_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_SUPERGRAFX),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX),y)
define CONFIGURE_SUPERGRAFX_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_SUPERGRAFX),mednafen_supergrafx,1)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_FBNEO),y)
define CONFIGURE_SUPERGRAFX_LIBRETRO_FBNEO_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_SUPERGRAFX),fbneo,2)
endef
endif

define CONFIGURE_SUPERGRAFX_LIBRETRO_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_SUPERGRAFX))
endef
endif



define CONFIGURE_MAIN_SUPERGRAFX_END
	$(call RECALBOX_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_SUPERGRAFX),$(SOURCE_ROMDIR_SUPERGRAFX),$(@D))
endef
endif

define RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_SUPERGRAFX_START)
	$(CONFIGURE_SUPERGRAFX_LIBRETRO_START)
	$(CONFIGURE_SUPERGRAFX_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF)
	$(CONFIGURE_SUPERGRAFX_LIBRETRO_FBNEO_DEF)
	$(CONFIGURE_SUPERGRAFX_LIBRETRO_END)
	$(CONFIGURE_MAIN_SUPERGRAFX_END)
endef

$(eval $(generic-package))
