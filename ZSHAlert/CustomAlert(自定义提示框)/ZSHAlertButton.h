//
//  ZSHAlertButton.h
//  qiankuang
//
//  Created by 维奕 on 2017/8/21.
//  Copyright © 2017年 维奕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZSHAlertButtonClickAction)(void);


@interface ZSHAlertButton : UIButton

+ (instancetype)initWithTitle:(NSString*)title clickAction:(ZSHAlertButtonClickAction)action;


@end
