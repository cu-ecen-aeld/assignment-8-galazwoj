##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#DONE: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = eb347a599bfa240ac9aeee12af68e1e67db473be
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-galazwoj.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver 
AESD_ASSIGNMENTS_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket               $(TARGET_DIR)/usr/bin/
endef

# see https://buildroot.org/downloads/manual/manual.html#_infrastructure_for_packages_building_kernel_modules (18.20)

$(eval $(kernel-module))

define AESD_ASSIGNMENTS_INSTALL_TARGET_MODULES
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load           $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload         $(TARGET_DIR)/usr/bin/
endef

AESD_ASSIGNMENTS_POST_BUILD_HOOKS += AESD_ASSIGNMENTS_INSTALL_TARGET_MODULES

$(eval $(generic-package))
 
#
#	##############################################################
#	#
#	# LDD
#	#
#	# see https://buildroot.org/downloads/manual/manual.html#_infrastructure_for_packages_building_kernel_modules (18.20)
#	#
#	##############################################################
#	
#	#DONE: Fill up the contents below in order to reference your assignment 3 git contents
#	LDD_VERSION = 734901997bb9d00ecfa5d6854fb573c449d8f8b7
#	# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
#	# with ssh keys and the automated build/test system.
#	# Your site should start with git@github.com:
#	LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-galazwoj.git
#	LDD_SITE_METHOD = git
#	LDD_GIT_SUBMODULES = YES
#	LDD_MODULE_SUBDIRS = misc-modules
#	LDD_MODULE_SUBDIRS += scull
#	LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)
#
#	$(eval $(kernel-module))
#	
#	define LDD_INSTALL_TARGET_MODULES
#		$(INSTALL) -m 0755 $(@D)/scull/scull_load           $(TARGET_DIR)/usr/bin/
#		$(INSTALL) -m 0755 $(@D)/scull/scull_unload         $(TARGET_DIR)/usr/bin/
#		$(INSTALL) -m 0755 $(@D)/misc-modules/module_load   $(TARGET_DIR)/usr/bin/
#		$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin/
#	endef
#
#	LDD_POST_BUILD_HOOKS += LDD_INSTALL_TARGET_MODULES
#	
#	$(eval $(generic-package))
#
       
