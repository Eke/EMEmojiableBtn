//
//  EMEmojiableBtn.h
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import <UIKit/UIKit.h>
#import "EMEmojiableOption.h"
#import "EMEmojiableBtnConfig.h"

typedef NS_ENUM(NSInteger, MenuDirection) {
    MenuDirectionUpRight,
    MenuDirectionUpLeft,
    MenuDirectionDownRight,
    MenuDirectionDownLeft,
};

@protocol EMEmojiableBtnDelegate;
@interface EMEmojiableBtn : UIButton
@property (strong,nonatomic)  NSArray * _Nonnull dataset;
@property (weak,readwrite) id <EMEmojiableBtnDelegate> _Nullable  delegate;

- (instancetype _Nonnull)initWithFrame:(CGRect)frame withConfig:(EMEmojiableBtnConfig* _Nonnull)conf;
@end

@protocol EMEmojiableBtnDelegate <NSObject>
@optional
- (void)EMEmojiableBtn:( EMEmojiableBtn* _Nonnull)button selectedOption:(NSUInteger)index;
- (void)EMEmojiableBtnCanceledAction:(EMEmojiableBtn* _Nonnull)button;
- (void)EMEmojiableBtnSingleTap:(EMEmojiableBtn* _Nonnull)button;
@end
