#!/bin/sh

echo "Launching build and test on iOS"
xcodebuild test -project Invoke.xcodeproj -scheme Invoke -sdk iphonesimulator10.0 -destination 'platform=iOS Simulator,name=iPhone 6s,OS=10.0' | xcpretty

echo "Launching build and test on tvOS"
xcodebuild test -project Invoke.xcodeproj -scheme Invoke -sdk appletvsimulator10.0 -destination 'platform=tvOS Simulator,name=Apple TV 1080p,OS=10.0' | xcpretty

echo "Launching build and test on macOS"
xcodebuild test -project Invoke.xcodeproj -scheme Invoke -sdk macosx -destination 'platform=OS X,arch=x86_64' | xcpretty
