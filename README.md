![Quikkly SDK for iOS](https://github.com/quikkly/ios-sdk/blob/master/banner.png?raw=true)

![Build Passing](https://img.shields.io/badge/build-passing-brightgreen.svg)
![Platforms iOS](https://img.shields.io/badge/platforms-ios%208%2B-blue.svg)
![Languages](https://img.shields.io/badge/languages-swift3%20%7C%20objc-blue.svg)
[![CocoaPods Compatible](https://img.shields.io/badge/cocoapods-compatible-green.svg)](https://github.com/CocoaPods/CocoaPods)
[![Website](https://img.shields.io/badge/quikkly.io-developers-5cb8a7.svg)](https://developers.quikkly.io)
<!--[![Carthage compatible](https://img.shields.io/badge/carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)-->

Quikkly is the easiest way to implement smart scannables.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
  - [CocoaPods](#cocoapods)
  - [Manual](#manual)
- [Usage](#usage)
  - [Objective-C Support](#objective-c-support)
  - [Setup](#setup)
  - [Scannable Templates](#scannable-templates)
  - [Scanning](#scanning)
  - [Generating Scannables](#generating-scannables)
  - [Displaying Scannables](#displaying-scannables)
  - [Mapped Data](#mapped-data)
- [Sample App](#sample-app)

## Features

- Scanning with camera
- Generating scannable codes
- Linking data to scannables
- Written in Swift 3 with Objective-C support

## Requirements

- iOS 8.0+
- Swift 3.0+ or Objective-C

## Installation

In order to use this SDK, a Quikkly app key is required. Visit [here](https://developers.quikkly.io) for more information.

### CocoaPods

To use the SDK with CocoaPods add the following lines to your podfile's target:

```ruby
use_frameworks!

pod 'Quikkly', :git => 'https://github.com/quikkly/ios-sdk.git'
```

Currently bitcode isn't supported, so these lines have to be added at the end of your podfile:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
```

<!--### Carthage

Add this to your Cartfile:
```
github "quikkly/ios-sdk" "master"
```

Note that bitcode has to be turned off for now. We're working on a solution to this problem.
-->
### Manual

Download and add `Quikkly.framework` as an embedded binary to your project.

## Usage

### Objective-C Support

Objective C classes are using the QK prefix. For instance, Scannable becomes QKScannable.

Add ```@import Quikkly;``` to the Objective C file.

### Setup

In order to use our SDK there are a few pre-requisite steps required when setting up your project.

1. Set the Quikkly API key in your AppDelegate. The Value for the key will be your App key obtained from Quikkly ([here](https://quikklycodes.com/developers/)). The api key has to be valid, otherwise certain features of the SDK will not work.

```Swift
func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Quikkly framework setup
        Quikkly.apiKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        
        return true
}
```

2. In iOS 10+ the NSCameraUsageDescription key in the `Info.plist` file has to be set, otherwise the app will crash when access to the camera is requested.

3. Make sure bitcode is turned off in your target's build settings. Unfortunately we're currently unable to offer bitcode support. However we're working hard to make it available in the future.

This is not a universal framework. Simulator won't work, so make sure a device is selected, otherwise Swift classes aren't even available


### Scannable Templates

There are lots of different formats for both scannable detection and creation.
By default the sdk provides a set of templates that will work without any further setup and a larger pool of available options can be found online on the [Developer Portal](https://developers.quikkly.io/).
A blueprint file containing these supported templates can be added to the app bundle's assets and the file name needs to be specified in the AppDelegate:

```Swift
func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Quikkly framework setup
        Quikkly.apiKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        Quikkly.blueprintFilename = "myBlueprintFilename"
        
        return true
}
```

### Scanning

#### Scanner with Scan View camera feed

The ScanView class displays a camera feed and provides a delegate pattern to notify its parent view controller about detected scannables.

```Swift
func scanView(_ scanView: ScanView, didDetectScannables scannables: [Scannable]) {   
    // Handle detected scannables
    if let scannable = scannables.first {
        //do something with the scannable
        self.statusLabel.text = "Scannable found: \(scannable.value)"
    }
}
```

The detected Scannable object can then be linked to and trigger any action based on its value.

The ScanView's detector should be paused when it's off screen and it should resume when it's visible by using these methods:
```Swift
self.scanView.start()
self.scanView.stop()
```
The camera feed won't be paused, only the detector.

##### Camera permissions

In order for the ScanView to function the user will have to accept the camera permission dialog.
If permission is denied a default hint with a button linking to the app settings page will be displayed.

The ScanViewDelegate has a method to notify its parent object about the result of a permission request.
By returning false the default hint for users won't be displayed and it can be handled otherwise.

```Swift
import AVFoundation
func scanViewDidRequestCamera(status: AVAuthorizationStatus) -> Bool {
    if status == .denied {
        // show user hint
    } else {
        // hide user hint
    }
    return false // hide default
}
```

#### Scanner with default UI

For a simple and integration a view controller with a camera feed and a neutral default UI is provided.
The ScanViewController class has to be subclassed and its ScanView's delegate method implemented. 

The way to handle scanning events is the same as with a ScanView camera feed. Here's an example:

```Swift
func scanView(_ scanView: ScanView, didDetectScannables scannables: [Scannable]) {   
    // Handle detected scannables
    if let scannable = scannables.first {
        //execute action linked to the scannable's value property
        self.performAction(forScannable: scannable)
        //display activity indicator
        self.showActivityIndicator()
    }
}
```

Note that it's meant to be used without NavigationController and shouldn't be pushed on the navigation stack but presented modally.

To show and hide the activity indicator simply call ```self.showActivityIndicator()``` and ```self.hideActivityIndicator()```
The status label can also be modified and its visibilty can be changed.

#### Detection without UI

The Scannable class also has some static methods to detect scannables in a CGImage.

```Swift
Scannable.detect(inImage: cgImage) { (scannables) in
    if let scannable = scannable.first {
        //do something with this object
    }
}
```

### Generating Scannables

Scannables can be generated locally without any back-end integration. Instantiating requires a value, a template identifier and a Skin object for visual representation with a ScannableView (explained below).

```Swift
let skin = ScannableSkin()
//set the skin object's properties (colour hex codes, image url, etc)
...
let scannable = Scannable(withValue: 42587309, template: "template0002style1" skin: skin)
```

If the template identifier is nil a default template will be used.
Please keep in mind that certain templates may not support the full 64-bit Int range.

### Displaying Scannables

Simply set the scannable property of a ScannableView instance.

```Swift
self.scannableView = ScannableView()
self.scannableView.scannable = scannable
```

### Mapped Data

The Quikkly back-end can be used to map scannables to data.

For instantiation the Scannable class provides an initialiser.

```Swift
let dict:[String:Any] = ["actionId":1,
                       "actionData":"This string could be displayed when the scannable gets detected"]
Scannable(withMappedData: dict, template: nil, skin: nil, completion: { (success, scannable) in
    if success {
        //handle successfully created scannable
    } else {
        //handle failure
    }
})
```

This is how mapped data is queried for a scannable object:

```Swift
scannable.getMappedData({ (data) in
    if let mappedData = data {
        //use data to perform action
    } else {
        //no mapped data available for this scannable
    }
})
```

## Sample App

For a sample application have a look at [this] (https://github.com/quikkly/ios-sdk/tree/master/samples).
