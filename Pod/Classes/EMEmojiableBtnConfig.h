//
//  EMEmojiableBtnConfig.h
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import <Foundation/Foundation.h>

@interface EMEmojiableBtnConfig : NSObject
/**
 Size of each option
 */
@property (assign,nonatomic) CGFloat size;

/**
 Size of option when it is hilighted
 */
@property (assign,nonatomic) CGFloat maxSize;

/**
 Size of options when one option is hilighted.
 When option is hilighted other options are smaller.
 */
@property (assign,nonatomic) CGFloat minSize;

/**
 Spacing between options
 */
@property (assign,nonatomic) CGFloat spacing;

/**
 Bottom space of option selector view to button and information view
 */
@property (assign,nonatomic) CGFloat s_options_selector;

/**
 Background color of screen when options selector is active after UILongPressGestureRecognizer
 */
@property (strong,nonatomic) UIColor* backgroundColor;

/**
 Initial opacity of options listing view
 */
@property (assign,nonatomic) CGFloat optionsViewInitialAlpha;

/**
 Background color of options listing view
 */
@property (strong,nonatomic) UIColor* optionsViewBackgroundColor;

/**
 Shadow color of options listing view
 */
@property (strong,nonatomic) UIColor* optionsViewShadowColor;

/**
 Opacity of options listing shadow
 */
@property (assign,nonatomic) CGFloat optionsViewShadowOpacity;

/**
 Offset of options listing shadow
 */
@property (assign,nonatomic) CGSize optionsViewShadowOffset;

/**
 Background color of information view
 */
@property (strong,nonatomic) UIColor* informationViewBackgroundColor;

/**
 Dots color of information view
 */
@property (strong,nonatomic) UIColor* informationViewDotsColor;

/**
 Border color of information view
 */
@property (strong,nonatomic) UIColor* informationViewBorderColor;

/**
 Font of information view
 */
@property (strong,nonatomic) UIFont* informationViewFont;

/**
 Text color of information view
 */
@property (strong,nonatomic) UIColor* informationViewTextColor;

/**
 Text for information view. Default : Release to cancel
 */
@property (strong,nonatomic) NSString* informationViewText;
@end
