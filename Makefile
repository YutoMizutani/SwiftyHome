# Paths
PROJECT_PATH=./

# Names
PROJECT_NAME=SwiftyHome

# File extensions
PROJECT_EXTENSION=.xcodeproj
WORKSPACE_EXTENSION=.xcworkspace

# Commands
BUILD_COMMAND=xcodebuild
COCOAPODS_COMMAND=pod

# Schemes
SCHEME=SwiftyHome

# Definition
WORKSPACE=$(PROJECT_PATH)$(PROJECT_NAME)$(WORKSPACE_EXTENSION)


# Open
open:
	open $(WORKSPACE)


# Install
install:
	make install-pods
install-pods:
	$(COCOAPODS_COMMAND) install


# Update
update:
	make update-pods
update-pods:
	$(COCOAPODS_COMMAND) update
