//
//  EMEmojiableOption.h
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import <Foundation/Foundation.h>

@interface EMEmojiableOption : NSObject
@property (strong,nonatomic) NSString *imageName;
@property (strong,nonatomic) NSString *name;

-(instancetype)initWithImage:(NSString*)imageName withName:(NSString*)name;
@end
