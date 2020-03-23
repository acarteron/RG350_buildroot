# This file contains the definition of the toolchain wrapper build commands

# We use --hash-style=both to increase the compatibility of the generated
# binary with older platforms, except for MIPS, where the only acceptable
# hash style is 'sysv'
ifeq ($(findstring mips,$(HOSTARCH)),mips)
TOOLCHAIN_WRAPPER_HASH_STYLE = sysv
else
TOOLCHAIN_WRAPPER_HASH_STYLE = both
endif

TOOLCHAIN_WRAPPER_ARGS = $($(PKG)_TOOLCHAIN_WRAPPER_ARGS)
TOOLCHAIN_WRAPPER_ARGS += -DBR_SYSROOT='"$(STAGING_SUBDIR)"'

# We create a list like '"-mfoo", "-mbar", "-mbarfoo"' so that each flag is a
# separate argument when used in execv() by the toolchain wrapper.
TOOLCHAIN_WRAPPER_ARGS += -DBR_ADDITIONAL_CFLAGS='$(foreach f,$(call qstrip,$(BR2_TARGET_OPTIMIZATION)),"$(f)",)'

define TOOLCHAIN_WRAPPER_BUILD
	$(HOSTCC) $(HOST_CFLAGS) $(TOOLCHAIN_WRAPPER_ARGS) \
		-s -Wl,--hash-style=$(TOOLCHAIN_WRAPPER_HASH_STYLE) \
		toolchain/toolchain-wrapper.c \
		-o $(@D)/toolchain-wrapper
endef

define TOOLCHAIN_WRAPPER_INSTALL
	$(INSTALL) -D -m 0755 $(@D)/toolchain-wrapper \
		$(HOST_DIR)/usr/bin/toolchain-wrapper
endef