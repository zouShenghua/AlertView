//
//  ZSHControlView.h
//  qiankuang
//
//  Created by 维奕 on 2017/8/21.
//  Copyright © 2017年 维奕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSHAlertButton.h"

@interface ZSHControlView : UIView

@property (strong, nonatomic) UIColor *contentTextColor UI_APPEARANCE_SELECTOR;              // default is black
@property (strong, nonatomic) UIFont *contentFont UI_APPEARANCE_SELECTOR;                    // default is 15
@property (assign, nonatomic) CGFloat lineSpace UI_APPEARANCE_SELECTOR;                      // default is 4
@property (strong, nonatomic) UIColor *lineColor UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) NSTextAlignment contentTextAlignment UI_APPEARANCE_SELECTOR;    // default is NSTextAlignmentLeft


- (void)setupContent:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton;

- (void)setupImage:(UIImage*)image content:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton;

- (void)setupCustomView:(UIView*)view confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton;


@end
