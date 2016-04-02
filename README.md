# EMEmojiableBtn

[![CI Status](http://img.shields.io/travis/Eke/EMEmojiableBtn.svg?style=flat)](https://travis-ci.org/Erekle/EMEmojiableBtn)
[![Version](https://img.shields.io/cocoapods/v/EMEmojiableBtn.svg?style=flat)](http://cocoapods.org/pods/EMEmojiableBtn)
[![License](https://img.shields.io/cocoapods/l/EMEmojiableBtn.svg?style=flat)](http://cocoapods.org/pods/EMEmojiableBtn)
[![Platform](https://img.shields.io/cocoapods/p/EMEmojiableBtn.svg?style=flat)](http://cocoapods.org/pods/EMEmojiableBtn)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

There's also an [Swift implementation](https://github.com/lojals/JOEmojiableBtn) developed by [lojals](https://github.com/lojals).


## Installation

EMEmojiableBtn is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EMEmojiableBtn"
```

## Examples

### 1. Basic Instance

#### Example Code

```objc
EMEmojiableBtn *button = [[EMEmojiableBtn alloc] initWithFrame:CGRectMake(20, 150, 52.0, 52.0)];
button.delegate = self;
button.dataset = @[
    [[EMEmojiableOption alloc] initWithImage:@"img_1" withName:@"dislike"],
    [[EMEmojiableOption alloc] initWithImage:@"img_2" withName:@"broken"],
    [[EMEmojiableOption alloc] initWithImage:@"img_3" withName:@"he he"],
    [[EMEmojiableOption alloc] initWithImage:@"img_4" withName:@"ooh"],
    [[EMEmojiableOption alloc] initWithImage:@"img_5" withName:@"meh !"],
    [[EMEmojiableOption alloc] initWithImage:@"img_6" withName:@"ahh !"]
];
[button setImage:[UIImage imageNamed:@"img_1"] forState:UIControlStateNormal];
[self.view addSubview:button];
```

![image](http://i.imgur.com/A6Z1oTI.gif)

## Author

Erekle, ereklemesxi@gmail.com

## License

EMEmojiableBtn is available under the MIT license. See the LICENSE file for more info.
