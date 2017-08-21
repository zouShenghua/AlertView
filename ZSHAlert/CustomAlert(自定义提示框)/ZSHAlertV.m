//
//  ZSHAlertV.m
//  qiankuang
//
//  Created by 维奕 on 2017/8/21.
//  Copyright © 2017年 维奕. All rights reserved.
//

#import "ZSHAlertV.h"
#import "ZSHControlView.h"

typedef void (^ShowaAtion)(void);

@interface ZSHAlertV ()

@property (nonatomic, strong) UIButton *backgroundView;

@property (nonatomic, readonly) UIWindow *frontWindow;

@property (nonatomic, strong) ZSHControlView *controlView;

@property (nonatomic, strong) ZSHAlertButtonClickAction hideCompletionBlock;

@property (nonatomic, strong) NSMutableArray<ShowaAtion>* showArray;

@property (nonatomic, strong) NSMutableArray<void (^)(void)>* completionArray;

@property (nonatomic, assign) BOOL isVisible;


@end

@implementation ZSHAlertV

+ (ZSHAlertV*)sharedView {
    static dispatch_once_t once;
    static ZSHAlertV *sharedView;
    dispatch_once(&once, ^{
        sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        sharedView.showArray = [NSMutableArray new];
        sharedView.completionArray = [NSMutableArray new];
    });
    return sharedView;
}

+ (void)showContent:(NSString*)content {
    [ZSHAlertV showContent:content confirmButton:nil];
}

+ (void)showContent:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton {
    [ZSHAlertV showContent:content confirmButton:confirmButton cancleButton:nil];
}

+ (void)showContent:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton {
    [[ZSHAlertV sharedView] showImage:nil content:content customView:nil confirmButton:confirmButton cancleButton:cancleButton];
}

+ (void)showImage:(UIImage*)image content:(NSString*)content {
    [ZSHAlertV showImage:image content:content confirmButton:nil];
}

+ (void)showImage:(UIImage*)image content:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton {
    [ZSHAlertV showImage:image content:content confirmButton:confirmButton cancleButton:nil];
}

+ (void)showImage:(UIImage*)image content:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton {
    [[ZSHAlertV sharedView] showImage:image content:content customView:nil confirmButton:confirmButton cancleButton:cancleButton];
}

+ (void)showCustomView:(UIView*)view {
    [ZSHAlertV showCustomView:view confirmButton:nil];
}

+ (void)showCustomView:(UIView*)view confirmButton:(ZSHAlertButton*)confirmButton {
    [ZSHAlertV showCustomView:view confirmButton:confirmButton cancleButton:nil];
}

+ (void)showCustomView:(UIView*)view confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton {
    [[ZSHAlertV sharedView] showImage:nil content:nil customView:view confirmButton:confirmButton cancleButton:cancleButton];
}

- (void)showImage:(UIImage*)image content:(NSString*)content customView:(UIView*)customView confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton {
    __weak ZSHAlertV *weakSelf = self;
    ShowaAtion action = ^{
        __strong ZSHAlertV *strongSelf = weakSelf;
        strongSelf.backgroundView = [UIButton new];
        strongSelf.backgroundView.frame = strongSelf.bounds;
        strongSelf.backgroundView.backgroundColor = [UIColor clearColor];
        [strongSelf addSubview:strongSelf.backgroundView];
        [strongSelf.frontWindow addSubview:strongSelf];
        
        if (![strongSelf.alertBackgroundColor isEqual:[UIColor clearColor]]) {
            [UIView animateWithDuration:strongSelf.fadeInAnimationDuration animations:^{
                strongSelf.backgroundView.backgroundColor = strongSelf.alertBackgroundColor;
            }];
        }
        if (!confirmButton || strongSelf.touchToHide) {
            //only content or allow touch to hide
            [strongSelf.backgroundView addTarget:strongSelf action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        }
        if (!confirmButton && cancleButton) {
            NSAssert(NO,@"如果只需要一个按钮，请使用confirmButton");
        }
        if (confirmButton) {
            [confirmButton setBackgroundColor:strongSelf.confirmBtBackgroundColor];
            [confirmButton setTitleColor:strongSelf.confirmBtTitleColor forState:UIControlStateNormal];
            [confirmButton.titleLabel setFont:strongSelf.btTitleFont];
        }
        if (cancleButton) {
            [cancleButton setBackgroundColor:strongSelf.cancleBtBackgroundColor];
            [cancleButton setTitleColor:strongSelf.cancleBtTitleColor forState:UIControlStateNormal];
            [cancleButton.titleLabel setFont:strongSelf.btTitleFont];
        }
        
        strongSelf.controlView = [ZSHControlView new];
        if (customView) {
            [strongSelf.controlView setupCustomView:customView confirmButton:confirmButton cancleButton:cancleButton];
        }else{
            strongSelf.controlView.contentTextColor = strongSelf.contentTextColor;
            strongSelf.controlView.contentFont = strongSelf.contentFont;
            strongSelf.controlView.lineSpace = strongSelf.contentLineSpace;
            strongSelf.controlView.contentTextAlignment = strongSelf.contentTextAlignment;
            [strongSelf.controlView setupImage:image content:content confirmButton:confirmButton cancleButton:cancleButton];
        }
        [strongSelf addSubview:strongSelf.controlView];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:strongSelf.controlView
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:self.frame.size.width/2];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:strongSelf.controlView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:self.frame.size.height/2];
        [self addConstraint:leftConstraint];
        [self addConstraint:topConstraint];
        
        CABasicAnimation *animaitonX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        animaitonX.removedOnCompletion = NO;
        animaitonX.fromValue = @1.1;
        animaitonX.toValue = @1;
        animaitonX.duration = strongSelf.fadeInAnimationDuration;
        [strongSelf.controlView.layer addAnimation:animaitonX forKey:nil];
        CABasicAnimation *animaitonY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        animaitonY.removedOnCompletion = NO;
        animaitonY.fromValue = @1.1;
        animaitonY.toValue = @1;
        animaitonY.duration = strongSelf.fadeInAnimationDuration;
        [strongSelf.controlView.layer addAnimation:animaitonY forKey:nil];
        CABasicAnimation *animaitonAlpha = [CABasicAnimation animationWithKeyPath:@"alpha"];
        animaitonAlpha.removedOnCompletion = NO;
        animaitonAlpha.fromValue = @0.5;
        animaitonAlpha.toValue = @1;
        animaitonAlpha.duration = strongSelf.fadeInAnimationDuration;
        [strongSelf.controlView.layer addAnimation:animaitonAlpha forKey:nil];
        
        self.isVisible = YES;
    };
    
    [self.showArray addObject:action];
    [self.completionArray addObject:^{}];
    
    if (!self.isVisible) {
        self.showArray.firstObject();
    }
}

+ (void)hide {
    [[ZSHAlertV sharedView] hide];
}

+ (void)hideCompletion:(void (^)(void))completion {
    if (completion) {
        [[ZSHAlertV sharedView].completionArray replaceObjectAtIndex:[ZSHAlertV sharedView].completionArray.count-1 withObject:completion];
    }
}

- (void)hide {
    if (self.isVisible == NO) {
        return;
    }
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    [self.controlView removeFromSuperview];
    self.controlView = nil;
    
    [self removeFromSuperview];
    
    self.completionArray.firstObject();
    
    self.isVisible = NO;
    
    [self.showArray removeObjectAtIndex:0];
    [self.completionArray removeObjectAtIndex:0];
    
    if (self.showArray.count != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.showArray.firstObject();
        });
    }
}

#pragma mark - initWithFrame
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.fadeInAnimationDuration = 0.1;
        self.fadeOutAnimationDuration = 0.1;
        self.alertBackgroundColor = [UIColor clearColor];
        self.confirmBtBackgroundColor = [UIColor whiteColor];
        self.cancleBtBackgroundColor = [UIColor whiteColor];
        self.confirmBtTitleColor = [UIColor redColor];
        self.cancleBtTitleColor = [UIColor blueColor];
        self.contentTextColor = [UIColor blackColor];
        self.contentLineSpace = 4.0;
        self.contentFont = [UIFont systemFontOfSize:15.0];
        self.btTitleFont = [UIFont systemFontOfSize:15.0];
        self.touchToHide = NO;
        self.contentTextAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (UIWindow *)frontWindow {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
            return window;
        }
    }
    return nil;
}
#pragma mark - UIAppearance Setters

+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration {
    if (duration==0) {
        return;
    }
    [ZSHAlertV sharedView].fadeInAnimationDuration = duration;
}

+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration {
    if (duration==0) {
        return;
    }
    [ZSHAlertV sharedView].fadeOutAnimationDuration = duration;
}

+ (void)setAlertBackgroundColor:(UIColor*)color {
    if (!color) {
        return;
    }
    [ZSHAlertV sharedView].alertBackgroundColor = color;
}

+ (void)setConfirmBtBackgroundColor:(UIColor*)color {
    if (!color) {
        return;
    }
    [ZSHAlertV sharedView].confirmBtBackgroundColor = color;
}

+ (void)setCancleBtBackgroundColor:(UIColor*)color {
    if (!color) {
        return;
    }
    [ZSHAlertV sharedView].cancleBtBackgroundColor = color;
}

+ (void)setConfirmBtTitleColor:(UIColor*)color {
    if (!color) {
        return;
    }
    [ZSHAlertV sharedView].confirmBtTitleColor = color;
}

+ (void)setCancleBtTitleColor:(UIColor*)color {
    if (!color) {
        return;
    }
    [ZSHAlertV sharedView].cancleBtTitleColor = color;
}

+ (void)setContentFont:(UIFont*)font {
    if (!font) {
        return;
    }
    [ZSHAlertV sharedView].contentFont = font;
}

+ (void)setContentTextColor:(UIColor*)color {
    if (!color) {
        return;
    }
    [ZSHAlertV sharedView].contentTextColor = color;
}

+ (void)setBtTitleFont:(UIFont*)font {
    if (!font) {
        return;
    }
    [ZSHAlertV sharedView].btTitleFont = font;
}

+ (void)setContentLineSpace:(CGFloat)lineSpace {
    [ZSHAlertV sharedView].contentLineSpace = lineSpace;
}

+ (void)setTouchToHide:(BOOL)touchToHide {
    [ZSHAlertV sharedView].touchToHide = touchToHide;
}

+ (void)setContentTextAlignment:(NSTextAlignment)textAlignment {
    [ZSHAlertV sharedView].contentTextAlignment = textAlignment;
}


@end
