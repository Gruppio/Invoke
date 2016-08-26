#!/bin/sh

# Stop and fail if any one of the steps fail
set -e

echo "Launching build and test on iOS"
time xcodebuild build -project Invoke.xcodeproj -scheme Invoke -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6s,OS=10.0' | xcpretty

echo "Launching build and test on tvOS"
time xcodebuild build -project Invoke.xcodeproj -scheme Invoke -sdk iphonesimulator -destination 'platform=tvOS Simulator,name=Apple TV 1080p,OS=10.0' | xcpretty

echo "Launching build and test on macOS"
time xcodebuild build -project Invoke.xcodeproj -scheme Invoke -sdk iphonesimulator -destination 'platform=OS X,arch=x86_64' | xcpretty
