# a Makefile for a flutter application with common tasks

# Prepare the project
clean:
	flutter clean
	rm -rf pubspec.lock
	rm -rf ios/Podfile.lock
	flutter pub get
	cd ios && pod install
	cd ..

# Run tests
test:
	flutter test

# Format the code
format:
	flutter format .

# Analyze code for issues
analyze:
	flutter analyze

# Run the app on an emulator or device
run:
	flutter run

# Build APK for Android
build-android:
	flutter build apk --release

# Build IPA for iOS
build-ios:
	flutter build ios --release

# Clean the project including build and tool directories
clean-all:
	flutter clean
	rm -rf .dart_tool
	rm -rf build
	rm -rf ios/Podfile.lock

# Upgrade Flutter and packages
upgrade:
	flutter upgrade
	flutter pub upgrade

# Check outdated packages
outdated:
	flutter pub outdated

# A combined development step
dev:
	make prep
	make run
