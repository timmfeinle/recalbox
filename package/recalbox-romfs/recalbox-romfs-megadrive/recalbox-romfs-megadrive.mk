################################################################################
#
# recalbox-romfs-megadrive
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --force --system megadrive --extension '.md .MD .bin .BIN .zip .ZIP .gen .GEN .smd .SMD .7z .7Z' --fullname 'Sega Megadrive' --platform megadrive --theme megadrive 2:libretro:genesisplusgx:BR2_PACKAGE_LIBRETRO_GENESISPLUSGX 1:libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE 3:libretro:fbneo:BR2_PACKAGE_LIBRETRO_FBNEO

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MEGADRIVE_SOURCE = 
RECALBOX_ROMFS_MEGADRIVE_SITE = 
RECALBOX_ROMFS_MEGADRIVE_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MEGADRIVE = megadrive
SYSTEM_XML_MEGADRIVE = $(@D)/$(SYSTEM_NAME_MEGADRIVE).xml
# System rom path
SOURCE_ROMDIR_MEGADRIVE = $(RECALBOX_ROMFS_MEGADRIVE_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE)$(BR2_PACKAGE_LIBRETRO_FBNEO),)
define CONFIGURE_MAIN_MEGADRIVE_START
	$(call RECALBOX_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_MEGADRIVE),Sega Megadrive,$(SYSTEM_NAME_MEGADRIVE),.md .MD .bin .BIN .zip .ZIP .gen .GEN .smd .SMD .7z .7Z,megadrive,megadrive)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE)$(BR2_PACKAGE_LIBRETRO_FBNEO),)
define CONFIGURE_MEGADRIVE_LIBRETRO_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_MEGADRIVE),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),y)
define CONFIGURE_MEGADRIVE_LIBRETRO_GENESISPLUSGX_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MEGADRIVE),genesisplusgx,2)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_MEGADRIVE_LIBRETRO_PICODRIVE_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MEGADRIVE),picodrive,1)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_FBNEO),y)
define CONFIGURE_MEGADRIVE_LIBRETRO_FBNEO_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_MEGADRIVE),fbneo,3)
endef
endif

define CONFIGURE_MEGADRIVE_LIBRETRO_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_MEGADRIVE))
endef
endif



define CONFIGURE_MAIN_MEGADRIVE_END
	$(call RECALBOX_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_MEGADRIVE),$(SOURCE_ROMDIR_MEGADRIVE),$(@D))
endef
endif

define RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_MEGADRIVE_START)
	$(CONFIGURE_MEGADRIVE_LIBRETRO_START)
	$(CONFIGURE_MEGADRIVE_LIBRETRO_GENESISPLUSGX_DEF)
	$(CONFIGURE_MEGADRIVE_LIBRETRO_PICODRIVE_DEF)
	$(CONFIGURE_MEGADRIVE_LIBRETRO_FBNEO_DEF)
	$(CONFIGURE_MEGADRIVE_LIBRETRO_END)
	$(CONFIGURE_MAIN_MEGADRIVE_END)
endef

$(eval $(generic-package))
