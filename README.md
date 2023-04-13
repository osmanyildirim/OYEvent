[![Cocoapods](https://img.shields.io/cocoapods/v/OYEvent.svg)](https://cocoapods.org/pods/OYEvent)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-red.svg?style=flat)](https://swift.org/package-manager/)
[![Platforms](https://img.shields.io/badge/platforms-iOS-yellow.svg)](https://github.com/osmanyildirim/OYEvent)
[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-14.2-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-lightgray.svg)](https://opensource.org/licenses/MIT)

<p align="left">
  <img src="Assets/Banner.png" title="OYEvent">
</p>

Swift SDK for Post and Observe events with using [NotificationCenter](https://developer.apple.com/documentation/foundation/notificationcenter)

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
    - [Observe](#observe)
    - [Post](#post)
    - [Dispose](#dispose)
- [License](#license)

## Requirements

* iOS 11.0+
* Swift 5.0+

## Installation

<details>
<summary>CocoaPods</summary>
<br/>
<p>Add the following line to your <code>Podfile</code></p>

```
pod 'OYEvent'
```
</details>

<details>
<summary>Swift Package Manager</summary>
<br/>
<p>Add OYEvent as a dependency to your <code>Package.swift</code> and specify OYEvent as a target dependency</p>

```swift
import PackageDescription
  
let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/osmanyildirim/OYEvent", .upToNextMinor(from: "1.0")),
    ],
    targets: [
        .target(
            name: "YOUR_PROJECT_NAME",
            dependencies: ["OYEvent"])
    ]
)
```
</details>

## Usage

### Observe
... Add an observer for a notification ...

```swift
 OYEvent.observe(target: self, name: "Method_Name", on: .main) { notification in
     // do stuff
 }
```

```swift
OYEvent.observe(target: self, name: Notification.Name(rawValue: UIResponder.keyboardWillShowNotification.rawValue), on: .main) { notification in
    // do stuff
}
```

### Post
... Post a notification ...

```swift
 OYEvent.post(name: "Method_Name", userInfo: ["Key": "Value"])
```

```swift
OYEvent.post(name: Notification.Name(rawValue: "Method_Name"), userInfo: ["Key": "Value"])
```

### Dispose
... Dispose NotificationCenter observer with notification method name ...

```swift
 OYEvent.dispose(name: "Method_Name")
```

```swift
 OYEvent.dispose(name: Notification.Name(rawValue: "Method_Name"))
```
&nbsp;
... Dispose NotificationCenter observer with target and notification method name ...

```swift
 OYEvent.dispose(target: self, name: "Method_Name")
```

```swift
 OYEvent.dispose(target: self, name: Notification.Name(rawValue: "Method_Name"))
```
<br/>
... Dispose all NotificationCenter observers with target...
<br/>
<br/>

> *`target`* parameter is `AnyObject` instance, e.g. `UIViewController`

```swift
 OYEvent.disposeAll(target: self)
```
<br/>
... Dispose of all NotificationCenter observers that are defined anywhere ...

```swift
 OYEvent.disposeAll()
```

## License
OYEvent is released under an MIT license. [See LICENSE](https://github.com/osmanyildirim/OYEvent/blob/main/LICENSE) for details.