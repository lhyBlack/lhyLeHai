//
//  UIView+Extension.h
//  My-Microblog
//
//  Created by 赵志丹 on 15/11/29.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

/** 通过一个方法来找到这个黑线 */
- (UIImageView *)findHairlineImageView;

//高度自适应
-(CGSize )automaticallyAdaptToHighly:(CGFloat )value targetString:(NSString *)targetStr;

//创建label
-(UILabel *)commonPropertyWithTextColor:(UIColor *)color WithFont:(CGFloat)font WithText:(NSString *)textStr;
/**
 
 * 创建纯色的图片，用来做背景
 
 */- (UIImage *)switchToImageWithColor:(UIColor *)color size:(CGSize)size;
@end
