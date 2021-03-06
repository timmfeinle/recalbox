################################################################################
#
# LIBLCF
#
################################################################################

LIBLCF_VERSION = d0c52fc6b1babe49db89d1849e3dde79cdd04b6d
LIBLCF_SITE = git://github.com/EasyRPG/liblcf.git
LIBLCF_DEPENDENCIES = expat icu
LIBLCF_SITE_METHOD = git
LIBLCF_LICENSE = MIT
LIBLCF_INSTALL_STAGING = YES

LIBLCF_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release

LIBLCF_CONF_OPTS += -DCMAKE_C_ARCHIVE_CREATE="<CMAKE_AR> qcs <TARGET> <LINK_FLAGS> <OBJECTS>"
LIBLCF_CONF_OPTS += -DCMAKE_C_ARCHIVE_FINISH=true
LIBLCF_CONF_OPTS += -DCMAKE_CXX_ARCHIVE_CREATE="<CMAKE_AR> qcs <TARGET> <LINK_FLAGS> <OBJECTS>"
LIBLCF_CONF_OPTS += -DCMAKE_CXX_ARCHIVE_FINISH=true
LIBLCF_CONF_OPTS += -DCMAKE_AR="$(TARGET_CC)-ar"
LIBLCF_CONF_OPTS += -DCMAKE_C_COMPILER="$(TARGET_CC)"
LIBLCF_CONF_OPTS += -DCMAKE_CXX_COMPILER="$(TARGET_CXX)"
LIBLCF_CONF_OPTS += -DCMAKE_LINKER="$(TARGET_LD)"
LIBLCF_CONF_OPTS += -DCMAKE_C_FLAGS="$(COMPILER_COMMONS_CFLAGS_SO)"
LIBLCF_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(COMPILER_COMMONS_CXXFLAGS_SO)"
LIBLCF_CONF_OPTS += -DCMAKE_LINKER_EXE_FLAGS="$(COMPILER_COMMONS_LDFLAGS_SO)"

$(eval $(cmake-package))
