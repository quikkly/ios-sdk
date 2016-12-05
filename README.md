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
  - [CocoaPods] (#cocoapods)
  - [Manual] (#manual)
- [Usage](#usage)
  - [Setup] (#setup)
  - [Scanning](#scanning)
  - [Processing Actions](#processing-actions)
  - [Generating Scannables](#generating-scannables)
  - [Displaying Scannables](#displaying-scannables)

## Features

- Scannable detector
- Generating scannables with Quikkly actions
- Generating offline scannables
- Custom actions
- Written in Swift 3 with Objective-C support

## Requirements

- iOS 8.0+
- Swift 3.0+ or Objective-C

## Installation

In order to use this SDK, a Quikkly app key is required. Visit [here](https://developers.quikkly.io) for more information.

### CocoaPods

To use the SDK with CocoaPods add the following lines to your podfile's target:

```
use_frameworks!

pod 'Quikkly', :git => 'https://github.com/quikkly/ios-sdk.git'
```

Currently there bitcode isn't supported, so these lines have to be added at the end of your podfile:

```
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

1. Download and add `Quikkly.framework` to your project.

2. Link the project with `libc++.dylib`, `CoreLocation.framework`, `CoreMedia.framework`, `AudioToolbox.framework`, `AVFoundation.framework` and `QuartzCore.framework`

## Usage

### Setup

In order to use our SDK there are a few pre-requisite steps required when setting up your project.

1. Set the Quikkly API key in your AppDelegate. The Value for the key will be your App key obtained from Quikkly ([here](http://www.quikklytags.info/developers/)).

```
func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Quikkly framework setup
        Quikkly.apiKey = "XXXXXXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        
        return true
}
```

2. Some of our Quikkly actions use custom URIs to support deep linking and API calls to 3rd party services, through the `[UIApplication canOpenURL:]` mechanisms. Due to some changes in iOS 9, your `Info.plist` file should contain an `LSApplicationQueriesSchemes` key with `spotify`, `twitter`, `gplus` and `youtube` items.

3. Make sure bitcode is turned off in your target's build settings. Unfortunately we're currently unable to offer bitcode support. However we're working hard to make it available in the future.

### Scanning

#### Scanner with default UI

For a simple and hassle free integration a view controller handling the detection of Quikkly back-end based Scannables is provided.
It's as simple as this.

```
let scanViewController = ScanViewController()
self.present(scanViewController, animated: true, completion: {})
```

The ScanViewController also handles the action processing.

#### Scanner with Scan View camera feed

For a more flexible implementation there is a ScanView class.
It will notify it's ScanViewDelegate object about detected scannables.

```
func scanView(_ scanView: ScanView, didDetectScannables scannables: [Scannable]) {   
    // Handle detected scannable
    if let scannable = scannables.first {
        self.statusLabel.text = "Scannable found: \(scannable.value)"
    }
}
```

Note that this does not automatically handle the action as well. The detected Scannable object needs to be passed to an ActionProcessor instance (explained below).

#### Detection without UI

The Scannable class has some static methods to detect scannables in a CGImage.

```
Scannable.detect(inImage: cgImage) { (scannables) in
    if let scannable = scannable.first {
        //do something with this object
    }
}
```

### Processing Actions

Since Scannables do not know about their linked action they have to be processed by an ActionProcessor.
The action processor will then retrieve the action data from the Quikkly back-end.

Simply add:
```
let actionProcessor = ActionProcessor()

self.actionProcessor.process(scannable: scannable)
self.showActivityIndicatorView()
```

The ActionProcessorDelegate provides the option to respond to its lifecycle (for instance, to display/hide activity indicator views, or to handle the result of a performed action).

```
func actionProcessor(_ actionProcessor: ActionProcessor, didProcessAction action: Action?, withResult result: ActionResult) {
    self.hideActivityIndicatorView()
}
```

### Generating Scannables

#### With actions via Quikkly back-end

To create a scannable on the Quikkly back-end, an Action object has to be instantiated first.
For instance:

```
let action = WebsiteAction(withUrl: URL(string: "https://quikkly.io"))
```

Then it can be passed as a parameter of the initializer. The skin can be nil as it will then use the default skin provided by the Quikkly platform, or you can instantiate a Skin object. Please see [here](http://docs.quikkly.io/ios/0.1.0/Classes/Scannable/Skin.html) for more details

```
Scannable(withAction: action, skin: nil) { (success, scannable) in
    if success {
        //use scannable object
    }
}
```

#### Without Quikkly back-end

Scannables can be generated for use on your own back-end. Instantiating them requires a value and a [Skin](http://docs.quikkly.io/ios/0.1.0/Classes/Scannable/Skin.html) for visual representation with a ScannableView (explained below).

```
let skin = Scannable.Skin()
//set the skin object's properties (colour hex codes, image url, etc)
...
let scannable = Scannable(withValue: NSNumber(value: 42587309), skin: skin)
```

### Displaying Scannables

Simply set the scannable property of a ScannableView instance.

```
self.scannableView = ScannableView()
self.scannableView.scannable = s //s... some previously instantiated Scannable object
```
