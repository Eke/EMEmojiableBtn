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
@property (strong,nonatomic)  EMEmojiableInformationView *informationView;
@property (strong,nonatomic) UITapGestureRecognizer *singleTapGesture;
@property (strong,nonatomic) UILongPressGestureRecognizer *longPressGesture;
@property (assign,nonatomic) BOOL active;
@property (assign,nonatomic) MenuDirection menuDirection;
@property (assign,nonatomic) CGPoint origin;
@property (assign,nonatomic) CGRect optionsViewOriginalRect;
@property (assign,nonatomic) int selectedItem;
@end

@implementation EMEmojiableBtn{
    NSArray *_dataset;
}
@synthesize selectorBgView;
@synthesize optionsView;
@synthesize longPressGesture;
@synthesize singleTapGesture;
@synthesize active;
@synthesize menuDirection;
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
        return self.config = [[EMEmojiableBtnConfig alloc] init];
    }
    return _config;
}

#pragma mark - UI
- (void)activate{
    if(active){
        return;
    }
    if(_dataset == nil){
        [NSException raise:@"Invalid _dataset value" format:@"_dataset can't be nil"];
        return;
    }
    
    selectedItem = -1;
    active = YES;
    
    
    CGRect selectorViewFrame = [UIScreen mainScreen].bounds;
    origin = [self.superview convertPoint:self.frame.origin toView:nil];
    menuDirection = [self getMenuDirection];
    
    if (!CGPointEqualToPoint(origin,self.frame.origin)) {
        selectorViewFrame.origin.x -= origin.x;
        selectorViewFrame.origin.y -= origin.y;
    }
    
    selectorBgView = [[UIView alloc] initWithFrame:selectorViewFrame];
    selectorBgView.backgroundColor = self.config.backgroundColor;
    [self.superview addSubview:selectorBgView];
    
    CGFloat buttonWidth = ((CGFloat)(_dataset.count + 1) * self.config.spacing) +(self.config.size*(CGFloat)_dataset.count);
    CGFloat buttonHeight = self.config.size+(2*self.config.spacing);
    CGSize sizeBtn = CGSizeMake(buttonWidth,buttonHeight);
    
    
    CGRect optionsViewFrame = [self adjustFrameIfNeeded:CGRectMake(origin.x, origin.y - sizeBtn.height, sizeBtn.width, sizeBtn.height) leftMenuXOrigin:(origin.x + self.frame.size.width - sizeBtn.width) downMenuYOrigin:0.0];
    
    optionsView = [[UIView alloc] initWithFrame:optionsViewFrame];
    optionsView.alpha               = self.config.optionsViewInitialAlpha;
    optionsView.layer.cornerRadius  = optionsView.frame.size.height/2.0;
    optionsView.backgroundColor     = self.config.optionsViewBackgroundColor;
    optionsView.layer.shadowColor   = self.config.optionsViewShadowColor.CGColor;
    optionsView.layer.shadowOffset  = self.config.optionsViewShadowOffset;
    optionsView.layer.shadowOpacity = self.config.optionsViewShadowOpacity;
    
    [selectorBgView addSubview:optionsView];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.optionsView.frame;
        frame.origin.y = self.origin.y - (self.config.s_options_selector + sizeBtn.height);
        self.optionsView.frame = optionsViewOriginalRect = frame;
        self.optionsView.alpha = 1.0;
    }];
    
    for (int i = 0; i<_dataset.count;++i){
        EMEmojiableOption *option = [_dataset objectAtIndex:i];
        CGRect frame = CGRectMake(((CGFloat)(i+1)*self.config.spacing)+(self.config.size*(CGFloat)i),sizeBtn.height*1.2,10,10);
        CGPoint center = CGPointMake(((CGFloat)(i+1)*self.config.spacing)+(self.config.size*(CGFloat)i)+self.config.size/2.0,self.config.spacing+self.config.size/2.0);
        
        
        UIImageView *optionImageView = [[UIImageView alloc] initWithFrame: [self adjustFrameIfNeeded:frame leftMenuXOrigin:(optionsView.frame.size.width - frame.origin.x) downMenuYOrigin:0.0]];
        CGPoint centerPoint = [self adjustPointIfNeeded:center leftMenuX:(optionsView.frame.size.width - center.x) downMenuY:0.0];

        
        optionImageView.image = [UIImage imageNamed:option.imageName];
        optionImageView.alpha = 0.6;
        [optionsView addSubview:optionImageView];
        
        
        
        [UIView animateWithDuration:0.2 delay:0.05*(double)i options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect optionImageViewFrame     = optionImageView.frame;
            optionImageViewFrame.origin.y   = self.config.spacing;
            optionImageViewFrame.size       = CGSizeMake(self.config.size, self.config.size);
            optionImageView.frame           = optionImageViewFrame;
            optionImageView.center          = centerPoint;
            optionImageView.alpha           = 1.0;
        } completion:nil];
    }
    
    informationView = [[EMEmojiableInformationView alloc] initWithFrame:CGRectMake(0, origin.y, selectorViewFrame.size.width, self.frame.size.height) withConfig:self.config];
    informationView.backgroundColor = self.config.informationViewBackgroundColor;
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
            CGPoint center;
            CGRect optionFrame = option.frame;
            optionFrame.size = CGSizeMake(10.0,10.0);
            informationView.alpha = 0;
            option.alpha    = 0.3;
            option.frame    = optionFrame;
            if(optionIndex == idx){
                center = CGPointMake(((CGFloat)idx+1.0*self.config.spacing)+(self.config.size*idx)+self.config.size/2,-self.optionsView.frame.size.height+self.config.size/2.0);
                option.center = [self adjustPointIfNeeded:center leftMenuX:(optionsView.frame.size.width - center.x) downMenuY:0.0];
                
            }else{
                center = CGPointMake(((CGFloat)idx+1.0*self.config.spacing)+(self.config.size*(CGFloat)idx)+self.config.size/2.0, self.optionsView.frame.size.height+self.config.size/2.0);
                option.center = [self adjustPointIfNeeded:center leftMenuX:(optionsView.frame.size.width - center.x) downMenuY:0.0];
            }
            
        } completion:^(BOOL finished) {
            if (finished && idx == (_dataset.count/2)){
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
    if (index < 0 || index > _dataset.count){
        return;
    }
    
    selectedItem = index;
    [informationView activateInfo:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat buttonWidth = (((CGFloat)_dataset.count-1*self.config.spacing)+(self.config.minSize*(CGFloat)_dataset.count-1)+self.config.maxSize);
        CGFloat buttonHeight = self.config.minSize+(2*self.config.spacing);
        CGSize sizeBtn = CGSizeMake(buttonWidth,buttonHeight);
        
        optionsView.frame = [self adjustFrameIfNeeded:CGRectMake(self.origin.x, self.origin.y - (self.config.s_options_selector+sizeBtn.height), sizeBtn.width, sizeBtn.height) leftMenuXOrigin:(self.origin.x + self.frame.size.width - sizeBtn.width) downMenuYOrigin:0.0];
        optionsView.layer.cornerRadius = sizeBtn.height/2;
        
        __block CGFloat last = index != 0 ? self.config.spacing : 0;
        
        [optionsView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGRect frame;
            CGPoint center;            
            if(idx == index-1){
                frame           = CGRectMake(last,self.config.spacing,self.config.minSize,self.config.minSize);
                view.frame      = [self adjustFrameIfNeeded:frame leftMenuXOrigin:(optionsView.frame.size.width - self.config.minSize - last) downMenuYOrigin:0.0];
                center          = CGPointMake(view.center.x, (self.config.minSize/2) + self.config.spacing);
                view.center     = [self adjustPointIfNeeded:center leftMenuX:view.center.x downMenuY:0.0];
                last            += self.config.minSize;
                
            }else if(idx == index){
                frame           = CGRectMake(last, -(self.config.maxSize/2), self.config.maxSize, self.config.maxSize);
                view.frame      = [self adjustFrameIfNeeded:frame leftMenuXOrigin:(optionsView.frame.size.width - self.config.maxSize - last) downMenuYOrigin:0.0];
                last            += self.config.maxSize;
            }else {
                frame          = CGRectMake(last,self.config.spacing,self.config.minSize,self.config.minSize);
                view.frame     = [self adjustFrameIfNeeded:frame leftMenuXOrigin:(optionsView.frame.size.width - self.config.minSize - last) downMenuYOrigin:0.0];
                center         = CGPointMake(view.center.x, (self.config.minSize/2) + self.config.spacing);
                view.center    = [self adjustPointIfNeeded:center leftMenuX:view.center.x downMenuY:0.0];
                last            += self.config.minSize + self.config.spacing;
            }
            
        }];
    }];
}

- (CGRect)adjustFrameIfNeeded: (CGRect)frame leftMenuXOrigin:(CGFloat)x downMenuYOrigin:(CGFloat)y{
    CGRect adjustedFrame;
    if (menuDirection == MenuDirectionUpRight){
        adjustedFrame = frame;
    } else if (menuDirection == MenuDirectionUpLeft) {
        adjustedFrame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
    } else if (menuDirection == MenuDirectionDownRight) {
        adjustedFrame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } else if (menuDirection == MenuDirectionDownLeft) {
        adjustedFrame = CGRectMake(x, y, frame.size.width, frame.size.height);
    }
    
    return adjustedFrame;
}

- (CGPoint)adjustPointIfNeeded: (CGPoint)point leftMenuX:(CGFloat)x downMenuY:(CGFloat)y{
    CGPoint adjustedPoint;
    if (menuDirection == MenuDirectionUpRight){
        adjustedPoint = point;
    } else if (menuDirection == MenuDirectionUpLeft) {
        adjustedPoint = CGPointMake(x, point.y);
    } else if (menuDirection == MenuDirectionDownRight) {
        adjustedPoint = CGPointMake(point.x, y);
    } else if (menuDirection == MenuDirectionDownLeft) {
        adjustedPoint = CGPointMake(x, y);
    }
    
    return adjustedPoint;
}

- (MenuDirection)getMenuDirection{
    CGFloat center = self.superview.center.x;
    CGFloat top = 0;
    
    if (origin.x <= center && origin.y > top) {
        return MenuDirectionUpRight;
    }
    else if (origin.x > center && origin.y > top) {
        return MenuDirectionUpLeft;
    }
    else if (origin.x <= center && origin.y <= top) {
        return MenuDirectionDownRight;
    }
    else {
        return MenuDirectionDownLeft;
    }
}

- (void)looseFocus{
    selectedItem = -1;
    [informationView activateInfo:YES];
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat buttonWidth = (((CGFloat)_dataset.count+1*self.config.spacing)+(self.config.size*(CGFloat)_dataset.count));
        CGFloat buttonHeight = self.config.size+(2.0*self.config.spacing);
        CGSize sizeBtn = CGSizeMake(buttonWidth,buttonHeight);
        optionsView.frame = optionsViewOriginalRect;
        optionsView.layer.cornerRadius = sizeBtn.height/2.0;
        
        [optionsView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGRect frame = CGRectMake(((CGFloat)(idx+1)*self.config.spacing)+(self.config.size*(CGFloat)idx),self.config.spacing,self.config.size,self.config.size);
            view.frame = [self adjustFrameIfNeeded:frame leftMenuXOrigin:(optionsView.frame.size.width - self.config.size - frame.origin.x) downMenuYOrigin:0.0];
        }];
    }];
}

#pragma mark - Gestures
- (void)singleTap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(EMEmojiableBtnSingleTap:)]){
        [self.delegate EMEmojiableBtnSingleTap:self];
    }
}

- (void)longTap:(UIGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan){
        [self activate];
    } else if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint point = [gesture locationInView:selectorBgView];
        
        CGFloat t = optionsView.frame.size.width/(CGFloat)_dataset.count;
        if (point.y < (CGRectGetMinY(optionsView.frame) - 50) || point.y > (CGRectGetMaxY(informationView.frame) + 30)){
            [self looseFocus];
        }else{
            if ((menuDirection == MenuDirectionUpRight) && ((point.x-origin.x) > 0 && point.x < (CGRectGetMaxX(optionsView.frame)-30))) {
                int selected = round((point.x-origin.x)/t);
                [self selectIndex:selected];
            }else if ((menuDirection == MenuDirectionUpLeft) && ((origin.x + self.frame.size.width - point.x) > 0 && point.x > (CGRectGetMinX(optionsView.frame) + 30))) {
                int selected = round((origin.x + self.frame.size.width - point.x)/t);
                [self selectIndex:selected];
            }else{
                [self looseFocus];
            }
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded){
        CGPoint point = [gesture locationInView:selectorBgView];
        if (((menuDirection == MenuDirectionUpRight) && (point.x > 0 && point.x < CGRectGetMaxX(optionsView.frame))) ||
            ((menuDirection == MenuDirectionUpLeft) && (point.x < selectorBgView.frame.size.width && point.x > CGRectGetMinX(optionsView.frame)))) {
            [self deActivate:selectedItem];
        }else{
            [self deActivate:-1];
        }
    }
}

@end