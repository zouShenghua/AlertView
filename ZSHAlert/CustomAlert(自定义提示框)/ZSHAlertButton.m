
//
//  ZSHAlertButton.m
//  qiankuang
//
//  Created by 维奕 on 2017/8/21.
//  Copyright © 2017年 维奕. All rights reserved.
//

#import "ZSHAlertButton.h"
#import "ZSHAlertV.h"

@interface ZSHAlertButton ()
@property (strong, nonatomic) ZSHAlertButtonClickAction action;
@end


@implementation ZSHAlertButton

+ (instancetype)initWithTitle:(NSString*)title clickAction:(ZSHAlertButtonClickAction)action {
    ZSHAlertButton *button = [ZSHAlertButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setAction:action];
    [button addTarget:button action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick {
    if (self.action) {
        self.action();
    }else{
        [ZSHAlertV hide];
    }
}

@end
