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
    }
    return self;
}
@end
