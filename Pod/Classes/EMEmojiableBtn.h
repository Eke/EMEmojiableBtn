//
//  EMEmojiableBtn.h
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import <UIKit/UIKit.h>
#import "EMEmojiableOption.h"

@protocol EMEmojiableBtnDelegate;
@interface EMEmojiableBtn : UIButton
@property (strong,nonatomic) NSArray<EMEmojiableOption *> *dataset;
@property (weak,readwrite) id <EMEmojiableBtnDelegate> delegate;
@end

@protocol EMEmojiableBtnDelegate <NSObject>
@optional
- (void)EMEmojiableBtn:(EMEmojiableBtn*)button selectedOption:(NSUInteger)index;
- (void)EMEmojiableBtnCanceledAction:(EMEmojiableBtn*)button;
@end
