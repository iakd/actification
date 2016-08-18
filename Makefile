ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:9.2:8.0
DEBUG = 0

GO_EASY_ON_ME=1

include theos/makefiles/common.mk

TWEAK_NAME = Actification
Actification_FILES = Tweak.xm LAActificationListener.xm ActificationCreator.xm
Actification_FRAMEWORKS = UIKit
Actification_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"

after-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/var/mobile/Actification$(ECHO_END)
	$(ECHO_NOTHING)cp Resources/Example.plist $(THEOS_STAGING_DIR)/var/mobile/Actification$(ECHO_END)