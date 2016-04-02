//
//  EMViewController.m
//  EMEmojiableBtn
//
//  Created by Erekle on 04/01/2016.
//  Copyright (c) 2016 Erekle. All rights reserved.
//

#import "EMViewController.h"
#import "EMEmojiableBtn.h"

@interface EMViewController () <EMEmojiableBtnDelegate>
@property (strong,nonatomic) NSArray *dataSetArray;
@property (strong,nonatomic) EMEmojiableBtn *theButton;
@end

@implementation EMViewController
@synthesize theButton;
@synthesize dataSetArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataSetArray = @[
                     [[EMEmojiableOption alloc] initWithImage:@"img_1" withName:@"dislike"],
                     [[EMEmojiableOption alloc] initWithImage:@"img_2" withName:@"dislike"],
                     [[EMEmojiableOption alloc] initWithImage:@"img_3" withName:@"dislike"],
                     [[EMEmojiableOption alloc] initWithImage:@"img_4" withName:@"dislike"],
                     [[EMEmojiableOption alloc] initWithImage:@"img_5" withName:@"dislike"],
                     [[EMEmojiableOption alloc] initWithImage:@"img_6" withName:@"dislike"]
                     ];
    
    theButton = [[EMEmojiableBtn alloc] initWithFrame:CGRectMake(20, 150, 52.0, 52.0)];
    theButton.delegate = self;
    theButton.dataset = dataSetArray;
    [theButton setImage:[UIImage imageNamed:@"img_1"] forState:UIControlStateNormal];
    [self.view addSubview:theButton];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    theButton.layer.cornerRadius = theButton.frame.size.width / 2.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EMEmojiableBtnDelegate
- (void)EMEmojiableBtnCanceledAction:(EMEmojiableBtn *)button{
    NSLog(@"Canceled");
}

- (void)EMEmojiableBtn:(EMEmojiableBtn *)button selectedOption:(NSUInteger)index{
    EMEmojiableOption *buttonOption = [dataSetArray objectAtIndex:index];
    [button setImage:[UIImage imageNamed:buttonOption.imageName] forState:UIControlStateNormal];
}

@end
