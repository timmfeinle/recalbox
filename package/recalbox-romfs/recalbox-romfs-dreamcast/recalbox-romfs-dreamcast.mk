################################################################################
#
# recalbox-romfs-dreamcast
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system dreamcast --extension '.gdi .GDI .cdi .CDI .chd .CHD' --fullname 'Sega Dreamcast' --platform dreamcast --theme dreamcast libretro:flycast:BR2_PACKAGE_LIBRETRO_FLYCAST reicast:reicast:BR2_PACKAGE_REICAST reicast:reicast:BR2_PACKAGE_REICAST_OLD

#
# DO NOT CALL empack.py to regenerate this file! It cannot handle both REICAST package!
#

# Name the 3 vars as the package requires
RECALBOX_ROMFS_DREAMCAST_SOURCE = 
RECALBOX_ROMFS_DREAMCAST_SITE = 
RECALBOX_ROMFS_DREAMCAST_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_DREAMCAST = dreamcast
SYSTEM_XML_DREAMCAST = $(@D)/$(SYSTEM_NAME_DREAMCAST).xml
# System rom path
SOURCE_ROMDIR_DREAMCAST = $(RECALBOX_ROMFS_DREAMCAST_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_FLYCAST)$(BR2_PACKAGE_REICAST)$(BR2_PACKAGE_REICAST_OLD),)
define CONFIGURE_MAIN_DREAMCAST_START
	$(call RECALBOX_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_DREAMCAST),Sega Dreamcast,$(SYSTEM_NAME_DREAMCAST),.gdi .GDI .cdi .CDI .chd .CHD,dreamcast,dreamcast)
endef

ifneq ($(BR2_PACKAGE_REICAST)$(BR2_PACKAGE_REICAST_OLD),)
define CONFIGURE_DREAMCAST_REICAST_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_DREAMCAST),reicast)
endef
ifneq ($(BR2_PACKAGE_REICAST)$(BR2_PACKAGE_REICAST_OLD),)
define CONFIGURE_DREAMCAST_REICAST_REICAST_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_DREAMCAST),reicast)
endef
endif

define CONFIGURE_DREAMCAST_REICAST_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_DREAMCAST))
endef
endif

ifneq ($(BR2_PACKAGE_LIBRETRO_FLYCAST),)
define CONFIGURE_DREAMCAST_LIBRETRO_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_DREAMCAST),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_FLYCAST),y)
define CONFIGURE_DREAMCAST_LIBRETRO_FLYCAST_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_DREAMCAST),flycast)
endef
endif

define CONFIGURE_DREAMCAST_LIBRETRO_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_DREAMCAST))
endef
endif



define CONFIGURE_MAIN_DREAMCAST_END
	$(call RECALBOX_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_DREAMCAST),$(SOURCE_ROMDIR_DREAMCAST),$(@D))
endef
endif

define RECALBOX_ROMFS_DREAMCAST_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_DREAMCAST_START)
	$(CONFIGURE_DREAMCAST_REICAST_START)
	$(CONFIGURE_DREAMCAST_REICAST_REICAST_DEF)
	$(CONFIGURE_DREAMCAST_REICAST_END)
	$(CONFIGURE_DREAMCAST_LIBRETRO_START)
	$(CONFIGURE_DREAMCAST_LIBRETRO_FLYCAST_DEF)
	$(CONFIGURE_DREAMCAST_LIBRETRO_END)
	$(CONFIGURE_MAIN_DREAMCAST_END)
endef

$(eval $(generic-package))