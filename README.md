# KeyboardListener
Prevent keyboard from covering UITextField/UITextView, includes Swift and Objective-C APIs.

## Requirements

- **iOS 9.0+**
- **Swift 4.2+**

## Usage

- **Swift**

```swift
// add
self.view.kl.addKeyboardListener()
```

- **Objective-C**

```objective-c
// add
[self.view lc_addKeyboardListener];
```

## Installation

### CocoaPods

To integrate KeyboardListener into your Xcode project using CocoaPods, specify it in your `Podfile`:

- **Swift**

```ruby
pod 'KeyboardListener'
```

- **Objective-C**

```ruby
pod 'LCKeyboardListener'
```

### Manual

- **Swift**

1. Download everything in the KeyboardListener folder;
2. Add (drag and drop) the source files in KeyboardListener to your project.

- **Objective-C**

1. Download everything in the KeyboardListener folder;
2. Add (drag and drop) the source files in LCKeyboardListener to your project;
3. Import ` UIView+LCKeyboardListener.h`.

## License

KeyboardListener is provided under the MIT license. See LICENSE file for details.
