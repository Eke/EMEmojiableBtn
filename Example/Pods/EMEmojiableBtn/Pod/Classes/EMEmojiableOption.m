//
//  EMEmojiableOption.m
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import "EMEmojiableOption.h"

@implementation EMEmojiableOption
-(instancetype)initWithImage:(NSString*)imageName withName:(NSString*)name{
    if(self = [super init]){
        self.imageName  = imageName;
        self.name       = name;
    }
    return self;
}
@end
