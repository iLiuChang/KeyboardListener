# KeyboardListener
Prevent keyboard from covering UITextField/UITextView, includes Swift and Objective-C APIs.

## Requirements

- **iOS 9.0+**
- **Swift 4.0+**

## Usage

- **Swift**

```swift
let textView = UITextView(frame: CGRect(x: 20, y: self.view.frame.height-100, width: 200, height: 45))

textView.backgroundColor = UIColor.red
self.view.addSubview(textView)

let textField = UITextField(frame: CGRect(x: 20, y: self.view.frame.height-160, width: 200, height: 45))
textField.backgroundColor = UIColor.yellow
self.view.addSubview(textField)

// add
self.view.addKeyboardListener()
```

- **Objective-C**

```objective-c
UITextField *t = [[UITextField alloc] init];
t.frame = CGRectMake(100, self.view.frame.size.height - 300, 100, 50);
t.backgroundColor = [UIColor redColor];
[self.view addSubview:t];

UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 50)];
contentView.backgroundColor = UIColor.yellowColor;
[self.view addSubview:contentView];
UITextView *t2 = [[UITextView alloc] init];
t2.frame = CGRectMake(100, 0, 100, 50);
t2.backgroundColor = [UIColor grayColor];
[contentView addSubview:t2];

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