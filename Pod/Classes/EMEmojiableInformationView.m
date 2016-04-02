//
//  EMEmojiableInformationView.m
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import "EMEmojiableInformationView.h"

@implementation EMEmojiableInformationView{
    UILabel *textInformation;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *dots = [UIBezierPath bezierPath];
    [dots moveToPoint:CGPointMake(18.5, (rect.size.height/2.0))];
    [dots addLineToPoint:CGPointMake(rect.size.width, (rect.size.height/2.0))];
    dots.lineCapStyle = kCGLineCapRound;
    dots.lineWidth = 3.0;
    CGFloat dashes [] = {dots.lineWidth * 0, 37};
    NSInteger count = sizeof(dashes)/sizeof(dashes[0]);
    [dots setLineDash:dashes count:count phase:0];
    [[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1.0] setStroke];
    [dots stroke];
    
    UIBezierPath *lineSuperior = [UIBezierPath bezierPath];
    [lineSuperior moveToPoint:CGPointMake(0,0)];
    [lineSuperior addLineToPoint:CGPointMake(rect.size.width,0)];
    lineSuperior.lineWidth = 1.0;
    [[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1.0] setStroke];
    [lineSuperior stroke];
    
    UIBezierPath *lineInferior = [UIBezierPath bezierPath];
    [lineInferior moveToPoint:CGPointMake(0,rect.size.height)];
    [lineInferior addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
    lineInferior.lineWidth = 1.0;
    [[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1.0] setStroke];
    [lineInferior stroke];
    
    textInformation = [[UILabel alloc] initWithFrame:CGRectMake(0,1,rect.size.width,rect.size.height-2)];
    textInformation.backgroundColor = [UIColor whiteColor];
    textInformation.textColor = [UIColor colorWithRed:0.57 green:0.59 blue:0.64 alpha:1];
    textInformation.text      = @"Release to Cancel";
    textInformation.textAlignment = NSTextAlignmentCenter;
    textInformation.font = [UIFont boldSystemFontOfSize:12.0];
    textInformation.alpha = 0;
    
    [self addSubview:textInformation];
    
}

- (void)activateInfo:(BOOL)active{
    textInformation.alpha = active ? 1 : 0;
}

@end
