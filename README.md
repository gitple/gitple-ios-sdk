# Gitple iOS sdk Examples

## Installation

- iOS 8 or above 
- Swift 3.1 or above

### CocoaPods
Add the Gitple pod into your Podfile and run `pod install`

```
target 'Target Name' do
  pod 'Gitple'
end  
```

### Update Info.plist
When installing Gitple, you'll need to make sure that you have a `NSPhotoLibraryUsageDescription`, `NSCameraUsageDescription`, `NSMicrophoneUsageDescription` entry in your Info.plist


## Examples

### Swift

- Go to ./samples/SwiftExample
- Run `pod install` in terminal
- open `SwiftExample.xcworkspace`
- Set your `GITPLE_APPCODE` at the `ViewController.swift`
- Build and Run
- [Swift sdk docs](http://guide.gitple.io/#/swift-sdk)

## Objective-C
- Go to ./samples/ObjeCExample
- Run `pod install` in terminal
- open `ObjCExample.xcworkspace`
- Set your `GITPLE_APPCODE` at the `ViewController.m`
- Build and Run
- [Objective-C sdk docs](http://guide.gitple.io/#/ios-sdk)
