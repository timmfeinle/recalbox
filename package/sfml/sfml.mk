################################################################################
#
# SFML - Simple and Fast Multimedia Library
#
################################################################################

SFML_VERSION = 2.5.1
SFML_SOURCE = SFML-$(SFML_VERSION)-sources.zip
SFML_SITE = http://www.sfml-dev.org/files
SFML_LICENSE = CUSTOM
SFML_LICENSE_FILES = license.md

SFML_DEPENDENCIES = xcb-util-image openal jpeg flac

SFML_INSTALL_STAGING = YES

define SFML_EXTRACT_CMDS
	mkdir -p $(SFML_DIR)
	$(UNZIP) -d $(SFML_DIR)/ $(DL_DIR)/sfml/$(SFML_SOURCE)
	mv $(SFML_DIR)/SFML-$(SFML_VERSION)/* $(SFML_DIR)
	mv $(SFML_DIR)/SFML-$(SFML_VERSION)/.editorconfig $(SFML_DIR)
	rm -rf $(SFML_DIR)/SFML-$(SFML_VERSION)
endef

$(eval $(cmake-package))
