//
//  ZSHAlertV.h
//  qiankuang
//
//  Created by 维奕 on 2017/8/21.
//  Copyright © 2017年 维奕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSHAlertButton.h"

@interface ZSHAlertV : UIView

@property (assign, nonatomic) NSTimeInterval fadeInAnimationDuration;   // default is 0.15
@property (assign, nonatomic) NSTimeInterval fadeOutAnimationDuration;  // default is 0.15

@property (strong, nonatomic) UIColor *alertBackgroundColor UI_APPEARANCE_SELECTOR;            // default is clear clolr
@property (strong, nonatomic) UIColor *confirmBtBackgroundColor UI_APPEARANCE_SELECTOR;        // default is white
@property (strong, nonatomic) UIColor *cancleBtBackgroundColor UI_APPEARANCE_SELECTOR;         // default is white
@property (strong, nonatomic) UIColor *confirmBtTitleColor UI_APPEARANCE_SELECTOR;             // default is black
@property (strong, nonatomic) UIColor *cancleBtTitleColor UI_APPEARANCE_SELECTOR;              // default is black
@property (strong, nonatomic) UIColor *contentTextColor UI_APPEARANCE_SELECTOR;                // default is black
@property (strong, nonatomic) UIFont *contentFont UI_APPEARANCE_SELECTOR;                      // default is 15
@property (assign, nonatomic) CGFloat contentLineSpace UI_APPEARANCE_SELECTOR;                 // default is 4.0
@property (strong, nonatomic) UIFont *btTitleFont UI_APPEARANCE_SELECTOR;                      // default is 15
@property (assign, nonatomic) NSTextAlignment contentTextAlignment UI_APPEARANCE_SELECTOR;     // default is NSTextAlignmentLeft


@property (assign ,nonatomic) BOOL touchToHide ; // default is NO except [SMAlert showContent:content] && [ZMAlert showImage:image content:content]

+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;//显示延时
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;//小时延时

+ (void)setAlertBackgroundColor:(UIColor*)color;//提示背景颜色
+ (void)setConfirmBtBackgroundColor:(UIColor*)color;//确定按钮背景颜色
+ (void)setCancleBtBackgroundColor:(UIColor*)color;//取消按钮背景颜色
+ (void)setConfirmBtTitleColor:(UIColor*)color;//确定按钮字体颜色
+ (void)setCancleBtTitleColor:(UIColor*)color;//取消按钮字体颜色
+ (void)setContentTextColor:(UIColor*)color;//内容
+ (void)setContentFont:(UIFont*)font;//内容字体大小
+ (void)setBtTitleFont:(UIFont*)font;//按钮字体大小
+ (void)setContentLineSpace:(CGFloat)lineSpace;
+ (void)setTouchToHide:(BOOL)touchToHide;
+ (void)setContentTextAlignment:(NSTextAlignment)textAlignment;


//提示框类型
#pragma mark 只显示文字
+ (void)showContent:(NSString*)content;
#pragma mark 显示文字和一个确认
+ (void)showContent:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton;
#pragma mark 显示文字和一个确认一个取消
+ (void)showContent:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton;

#pragma mark  显示一张图片和文字
+ (void)showImage:(UIImage*)image content:(NSString*)content;
#pragma mark 显示一张图片,文字,确认
+ (void)showImage:(UIImage*)image content:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton;
#pragma mark  显示一张图片,文字,确认,取消
+ (void)showImage:(UIImage*)image content:(NSString*)content confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton;

#pragma mark 显示自定义view
+ (void)showCustomView:(UIView*)view;
#pragma mark 显示自定义view，确认
+ (void)showCustomView:(UIView*)view confirmButton:(ZSHAlertButton*)confirmButton;
#pragma mark 显示自定义view，确认，取消
+ (void)showCustomView:(UIView*)view confirmButton:(ZSHAlertButton*)confirmButton cancleButton:(ZSHAlertButton*)cancleButton;

#pragma mark 隐藏Alert方法
+(void)hide;

// 这个block在Alert完全隐藏后执行，可以放入你的相关操作，并在执行完成之后自动置为nil，不会影响接下来的行为
+(void)hideCompletion:(void (^)(void))completion;



@end
