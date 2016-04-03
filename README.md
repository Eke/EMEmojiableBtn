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

### 2. Custom styled instance
#### Example Code

With this instance you can fully custom your component. Following the **EMEmojiableBtnConfig** variables.

You can custom your selector with the following variables, used in the 

![image](http://i.imgur.com/e4zaaye.png?1)


![image](http://i.imgur.com/yNfyP3c.png?1)

```objc
EMEmojiableBtnConfig *config = [[EMEmojiableBtnConfig alloc] init];
config.spacing  = 6.0;
config.size     = 30.0;
config.minSize  = 34.0;
config.maxSize  = 45.0;
config.s_options_selector = 30.0;

EMEmojiableBtn *button = [[EMEmojiableBtn alloc] initWithFrame:CGRectMake(20, 150, 52.0, 52.0) withConfig:config];
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

![image](http://i.imgur.com/G6PmoDE.gif)

#### Available customization options using **EMEmojiableBtnConfig**
* `size` - Size of each available option
* `maxSize` - Size of option when it is hilighted
* `minSize` - Size of options when one option is hilighted. When option is hilighted other options are smaller
* `spacing` - Spacing between options
* `s_options_selector` - Bottom space of option selector view to button and information view
* `backgroundColor` - Background color of screen when options selector is active after UILongPressGestureRecognizer
* `optionsViewInitialAlpha` - Initial opacity of options listing view
* `optionsViewBackgroundColor` - Background color of options listing view
* `optionsViewShadowColor` - Shadow color of options listing view
* `optionsViewShadowOpacity` - Opacity of options listing shadow
* `optionsViewShadowOffset` - Offset of options listing shadow
* `informationViewBackgroundColor` - Background color of information view
* `informationViewDotsColor` - Dots color of information view
* `informationViewBorderColor` - Border color of information view
* `informationViewFont` - Font of information view
* `informationViewTextColor` - Text color of information view
* `informationViewText` - Text for information view. Default : Release to cancel

## Author

Erekle, ereklemesxi@gmail.com

## License

EMEmojiableBtn is available under the MIT license. See the LICENSE file for more info.
