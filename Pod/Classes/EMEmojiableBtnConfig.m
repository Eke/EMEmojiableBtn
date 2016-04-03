//
//  EMEmojiableBtnConfig.m
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import "EMEmojiableBtnConfig.h"

@implementation EMEmojiableBtnConfig
- (instancetype)init{
    self = [super init];
    if(self){
        self.spacing            = 6;
        self.size               = 40;
        self.minSize            = 34;
        self.maxSize            = 80;
        self.s_options_selector = 30;
        
        self.backgroundColor            = [UIColor clearColor];
        
        self.optionsViewBackgroundColor = [UIColor whiteColor];
        self.optionsViewShadowColor     = [UIColor lightGrayColor];
        self.optionsViewShadowOffset    = CGSizeMake(0.0, 0.0);
        self.optionsViewShadowOpacity   = .5;
        self.optionsViewInitialAlpha    = .3;
        
        self.informationViewBackgroundColor = [UIColor whiteColor];
        self.informationViewFont            = [UIFont boldSystemFontOfSize:12.0];
        self.informationViewTextColor       = [UIColor colorWithRed:0.57 green:0.59 blue:0.64 alpha:1];
        self.informationViewText            = @"Release to cancel";
        
        self.informationViewDotsColor       = [UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1.0];
        self.informationViewBorderColor     = [UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1.0];
    }
    return self;
}

@end
