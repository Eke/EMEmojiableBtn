//
//  EMEmojiableInformationView.h
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import <UIKit/UIKit.h>
#import "EMEmojiableBtnConfig.h"

@interface EMEmojiableInformationView : UIView
- (instancetype)initWithFrame:(CGRect)frame withConfig:(EMEmojiableBtnConfig*)config;
- (void)activateInfo:(BOOL)active;
@end
