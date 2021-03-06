################################################################################
#
# kernelfirmwares
#
################################################################################

KERNELFIRMWARES_VERSION = 20200918
KERNELFIRMWARES_SITE = http://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
KERNELFIRMWARES_LICENSE = MULTIPLE
KERNELFIRMWARES_NON_COMMERCIAL = y

KERNELFIRMWARES_SITE_METHOD = git

define KERNELFIRMWARES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware
	cp -pr $(@D)/* $(TARGET_DIR)/lib/firmware/
	cd $(TARGET_DIR)/lib/firmware/ ; \
	sed -r -e '/^Link: (.+) -> (.+)$$/!d; s//\1 \2/' $(@D)/WHENCE | \
	while read f d; do \
		if test -f $$(readlink -m $$(dirname $$f)/$$d); then \
			mkdir -p $$(dirname $$f) || exit 1; \
			ln -sf $$d $$f || exit 1; \
		fi ; \
	done
	rm -rf $(TARGET_DIR)/lib/firmware/bnx2x
	rm -rf $(TARGET_DIR)/lib/firmware/liquidio
	rm -rf $(TARGET_DIR)/lib/firmware/netronome
endef

$(eval $(generic-package))
