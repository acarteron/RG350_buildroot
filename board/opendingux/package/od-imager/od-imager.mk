#############################################################
#
# od-imager
#
#############################################################

OD_IMAGER_VERSION = b60c8374b
OD_IMAGER_SITE = $(call github,glebm,imager,$(OD_IMAGER_VERSION))

define HOST_OD_IMAGER_INSTALL_CMDS
	mkdir -p $(BINARIES_DIR)/od-imager
	cp $(@D)/*.* $(BINARIES_DIR)/od-imager
endef

$(eval $(host-generic-package))
