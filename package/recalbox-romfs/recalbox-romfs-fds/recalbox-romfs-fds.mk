################################################################################
#
# recalbox-romfs-fds
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --force --system fds --extension '.fds .zip .7z' --fullname 'Family Computer Disk System' --platform fds --theme fds 1:libretro:nestopia:BR2_PACKAGE_LIBRETRO_NESTOPIA 2:libretro:fceumm:BR2_PACKAGE_LIBRETRO_FCEUMM 3:libretro:mesen:BR2_PACKAGE_LIBRETRO_MESEN 4:libretro:fbneo:BR2_PACKAGE_LIBRETRO_FBNEO

# Name the 3 vars as the package requires
RECALBOX_ROMFS_FDS_SOURCE = 
RECALBOX_ROMFS_FDS_SITE = 
RECALBOX_ROMFS_FDS_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_FDS = fds
SYSTEM_XML_FDS = $(@D)/$(SYSTEM_NAME_FDS).xml
# System rom path
SOURCE_ROMDIR_FDS = $(RECALBOX_ROMFS_FDS_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_NESTOPIA)$(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_MESEN)$(BR2_PACKAGE_LIBRETRO_FBNEO),)
define CONFIGURE_MAIN_FDS_START
	$(call RECALBOX_ROMFS_CALL_ADD_SYSTEM,$(SYSTEM_XML_FDS),Family Computer Disk System,$(SYSTEM_NAME_FDS),.fds .zip .7z,fds,fds)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_NESTOPIA)$(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_MESEN)$(BR2_PACKAGE_LIBRETRO_FBNEO),)
define CONFIGURE_FDS_LIBRETRO_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_FDS),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_FCEUMM),y)
define CONFIGURE_FDS_LIBRETRO_FCEUMM_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_FDS),fceumm,2)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_FBNEO),y)
define CONFIGURE_FDS_LIBRETRO_FBNEO_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_FDS),fbneo,4)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_NESTOPIA),y)
define CONFIGURE_FDS_LIBRETRO_NESTOPIA_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_FDS),nestopia,1)
endef
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_MESEN),y)
define CONFIGURE_FDS_LIBRETRO_MESEN_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_FDS),mesen,3)
endef
endif

define CONFIGURE_FDS_LIBRETRO_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_FDS))
endef
endif



define CONFIGURE_MAIN_FDS_END
	$(call RECALBOX_ROMFS_CALL_END_SYSTEM,$(SYSTEM_XML_FDS),$(SOURCE_ROMDIR_FDS),$(@D))
endef
endif

define RECALBOX_ROMFS_FDS_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_FDS_START)
	$(CONFIGURE_FDS_LIBRETRO_START)
	$(CONFIGURE_FDS_LIBRETRO_FCEUMM_DEF)
	$(CONFIGURE_FDS_LIBRETRO_FBNEO_DEF)
	$(CONFIGURE_FDS_LIBRETRO_NESTOPIA_DEF)
	$(CONFIGURE_FDS_LIBRETRO_MESEN_DEF)
	$(CONFIGURE_FDS_LIBRETRO_END)
	$(CONFIGURE_MAIN_FDS_END)
endef

$(eval $(generic-package))
