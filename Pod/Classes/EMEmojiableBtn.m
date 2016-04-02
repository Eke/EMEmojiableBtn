//
//  EMEmojiableBtn.m
//  Pods
//
//  Created by Erekle on 4/2/16.
//
//

#import "EMEmojiableBtn.h"
#import "EMEmojiableInformationView.h"

@interface EMEmojiableBtn()
@property (nonatomic,strong) EMEmojiableBtnConfig *config;
@property (strong,nonatomic) UIView *selectorBgView;
@property (strong,nonatomic) UIView *optionsView;
@property (strong,nonatomic) EMEmojiableInformationView *informationView;
@property (strong,nonatomic) UITapGestureRecognizer *singleTapGesture;
@property (strong,nonatomic) UILongPressGestureRecognizer *longPressGesture;
@property (assign,nonatomic) BOOL active;
@property (assign,nonatomic) CGPoint origin;
@property (assign,nonatomic) CGRect optionsViewOriginalRect;
@property (assign,nonatomic) int selectedItem;
@end

@implementation EMEmojiableBtn
@synthesize selectorBgView;
@synthesize optionsView;
@synthesize longPressGesture;
@synthesize singleTapGesture;
@synthesize active;
@synthesize origin;
@synthesize informationView;
@synthesize selectedItem;
@synthesize optionsViewOriginalRect;
#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self privateInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withConfig:(EMEmojiableBtnConfig*)conf{
    if(self = [super initWithFrame:frame]){
        self.config = conf;
        [self privateInit];
    }
    return self;
}

- (void)dealloc{
    self.delegate = nil;
    [self removeGestureRecognizer:singleTapGesture];
    [self removeGestureRecognizer:longPressGesture];
}

- (void)privateInit{
    active = NO;
    singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    //longPressGesture.cancelsTouchesInView = NO;
    singleTapGesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:singleTapGesture];
    [self addGestureRecognizer:longPressGesture];
    
    self.layer.masksToBounds = NO;
}


- (EMEmojiableBtnConfig*)config{
    if(_config == nil){
        NSLog(@"Init Config");
        return self.config = [[EMEmojiableBtnConfig alloc] init];
    }
    return _config;
}

#pragma mark - UI
- (void)activate{
    if(active){
        return;
    }
    if(self.dataset == nil){
        return;
    }
    selectedItem = -1;
    active = YES;
    
    
    CGRect selectorViewFrame = [UIScreen mainScreen].bounds;
    origin = [self.superview convertPoint:self.frame.origin toView:nil];
    
    if (!CGPointEqualToPoint(origin,self.frame.origin)) {
        selectorViewFrame.origin.x -= origin.x;
        selectorViewFrame.origin.y -= origin.y;
    }
    
    selectorBgView = [[UIView alloc] initWithFrame:selectorViewFrame];
    selectorBgView.backgroundColor = [UIColor clearColor];
    [self.superview addSubview:selectorBgView];
    
    CGFloat buttonWidth = ((CGFloat)(self.dataset.count + 1) * self.config.spacing) +(self.config.size*(CGFloat)self.dataset.count);
    CGFloat buttonHeight = self.config.size+(2*self.config.spacing);
    CGSize sizeBtn = CGSizeMake(buttonWidth,buttonHeight);
    
    CGRect optionsViewFrame = CGRectMake(origin.x, origin.y - sizeBtn.height, sizeBtn.width, sizeBtn.height);
    
    optionsView = [[UIView alloc] initWithFrame:optionsViewFrame];
    optionsView.layer.cornerRadius  = optionsView.frame.size.height/2.0;
    optionsView.backgroundColor     = [UIColor whiteColor];
    optionsView.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
    optionsView.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
    optionsView.layer.shadowOpacity = 0.5;
    optionsView.alpha               = 0.3;
    
    [selectorBgView addSubview:optionsView];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.optionsView.frame;
        frame.origin.y = self.origin.y - (self.config.s_options_selector + sizeBtn.height);
        self.optionsView.frame = optionsViewOriginalRect = frame;
        self.optionsView.alpha = 1.0;
    }];
    
    for (int i = 0; i<self.dataset.count;++i){
        EMEmojiableOption *option = [self.dataset objectAtIndex:i];
        UIImageView *optionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((CGFloat)(i+1)*self.config.spacing)+(self.config.size*(CGFloat)i),sizeBtn.height*1.2,10,10)];
        optionImageView.image = [UIImage imageNamed:option.imageName];
        optionImageView.alpha = 0.6;
        [optionsView addSubview:optionImageView];
        
        CGPoint centerPoint = CGPointMake(((CGFloat)(i+1)*self.config.spacing)+(self.config.size*(CGFloat)i)+self.config.size/2.0,self.config.spacing+self.config.size/2.0);
        
        [UIView animateWithDuration:0.2 delay:0.05*(double)i options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect optionImageViewFrame     = optionImageView.frame;
            optionImageViewFrame.origin.y   = self.config.spacing;
            optionImageViewFrame.size       = CGSizeMake(self.config.size, self.config.size);
            optionImageView.frame           = optionImageViewFrame;
            optionImageView.center          = centerPoint;
            optionImageView.alpha           = 1.0;
        } completion:nil];
    }
    
    informationView = [[EMEmojiableInformationView alloc] initWithFrame:CGRectMake(0, origin.y, selectorViewFrame.size.width, self.frame.size.height)];
    informationView.backgroundColor = [UIColor whiteColor];
    [selectorBgView addSubview:informationView];
}

- (void)deActivate:(int)optionIndex{
    if (optionIndex < 0){
        if(self.delegate && [self.delegate respondsToSelector:@selector(EMEmojiableBtnCanceledAction:)]){
            [self.delegate EMEmojiableBtnCanceledAction:self];
        }
    }else{
        if(self.delegate && [self.delegate respondsToSelector:@selector(EMEmojiableBtn:selectedOption:)]){
            [self.delegate EMEmojiableBtn:self selectedOption:selectedItem];
        }
    }
    
    [optionsView.subviews enumerateObjectsUsingBlock:^(UIView *option, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:0.2 delay:0.05*(double)idx options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect optionFrame = option.frame;
            optionFrame.size = CGSizeMake(10.0,10.0);
            informationView.alpha = 0;
            option.alpha    = 0.3;
            option.frame    = optionFrame;
            if(optionIndex == idx){
                option.center     = CGPointMake(((CGFloat)idx+1.0*self.config.spacing)+(self.config.size*idx)+self.config.size/2,-self.optionsView.frame.size.height+self.config.size/2.0);
            }else{
                option.center     = CGPointMake(((CGFloat)idx+1.0*self.config.spacing)+(self.config.size*(CGFloat)idx)+self.config.size/2.0, self.optionsView.frame.size.height+self.config.size/2.0);
            }
        } completion:^(BOOL finished) {
            if (finished && idx == (self.dataset.count/2)){
                [UIView animateWithDuration:0.1 animations:^{
                    CGRect optionsViewFrame = optionsView.frame;
                    optionsViewFrame.origin.y = origin.y - (self.config.size+(2*self.config.spacing));
                    optionsView.alpha   = 0;
                    optionsView.frame = optionsViewFrame;
                } completion:^(BOOL finished) {
                    active = false;
                    [selectorBgView removeFromSuperview];
                }];
            }
        }];
    }];
}

- (void)selectIndex:(int)index{
    if (index < 0 || index > self.dataset.count){
        return;
    }
    
    selectedItem = index;
    [informationView activateInfo:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat buttonWidth = (((CGFloat)self.dataset.count-1*self.config.spacing)+(self.config.minSize*(CGFloat)self.dataset.count-1)+self.config.maxSize);
        CGFloat buttonHeight = self.config.minSize+(2*self.config.spacing);
        CGSize sizeBtn = CGSizeMake(buttonWidth,buttonHeight);
        
        optionsView.frame = CGRectMake(self.origin.x, self.origin.y - (self.config.s_options_selector+sizeBtn.height), sizeBtn.width, sizeBtn.height);
        optionsView.layer.cornerRadius = sizeBtn.height/2;
        
        __block CGFloat last = index != 0 ? self.config.spacing : 0;
        
        [optionsView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            if(idx == index-1){
                view.frame      = CGRectMake(last,self.config.spacing,self.config.minSize,self.config.minSize);
                view.center     = CGPointMake(view.center.x, (self.config.minSize/2) + self.config.spacing);
                last            += self.config.minSize;
            }else if(idx == index){
                view.frame    = CGRectMake(last, -(self.config.maxSize/2), self.config.maxSize, self.config.maxSize);
                last          += self.config.maxSize;
            }else{
                view.frame      = CGRectMake(last,self.config.spacing,self.config.minSize,self.config.minSize);
                view.center     = CGPointMake(view.center.x, (self.config.minSize/2) + self.config.spacing);
                last            += self.config.minSize + self.config.spacing;
            }
            
        }];
    }];
}

- (void)looseFocus{
    selectedItem = -1;
    [informationView activateInfo:YES];
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat buttonWidth = (((CGFloat)self.dataset.count+1*self.config.spacing)+(self.config.size*(CGFloat)self.dataset.count));
        CGFloat buttonHeight = self.config.size+(2.0*self.config.spacing);
        CGSize sizeBtn = CGSizeMake(buttonWidth,buttonHeight);
        optionsView.frame = optionsViewOriginalRect;
        optionsView.layer.cornerRadius = sizeBtn.height/2.0;
        
        [optionsView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            view.frame = CGRectMake(((CGFloat)(idx+1)*self.config.spacing)+(self.config.size*(CGFloat)idx),self.config.spacing,self.config.size,self.config.size);
        }];
    }];
}

#pragma mark - Gestures
- (void)singleTap{
    [self activate];
}

- (void)longTap:(UIGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan){
        [self activate];
    } else if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint point = [gesture locationInView:selectorBgView];
        
        CGFloat t = optionsView.frame.size.width/(CGFloat)self.dataset.count;
        if (point.y < (CGRectGetMinY(optionsView.frame) - 50) || point.y > (CGRectGetMaxY(informationView.frame) + 30)){
            [self looseFocus];
        }else{
            if (point.x-origin.x > 0 && point.x < CGRectGetMaxX(optionsView.frame)){
                int selected = round((point.x-origin.x)/t);
                [self selectIndex:selected];
            }else{
                [self looseFocus];
            }
        }
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded){
        CGPoint point = [gesture locationInView:selectorBgView];
        if (point.x > 0 && point.x < CGRectGetMaxX(optionsView.frame)){
            [self deActivate:selectedItem];
        }else{
            [self deActivate:-1];
        }
    }
}

@end