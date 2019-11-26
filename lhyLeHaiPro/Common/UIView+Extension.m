//
//  UIView+Extension.m
//  My-Microblog
//
//  Created by 赵志丹 on 15/11/29.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

/** 通过一个方法来找到这个黑线 */
- (UIImageView *)findHairlineImageView {
    if ([self isKindOfClass:UIImageView.class] && self.bounds.size.height <= 1.0) {
        return (UIImageView *)self;
    }
    for (UIView *subView in self.subviews) {
        UIImageView *imageView = [subView findHairlineImageView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

// label高度自适应
-(CGSize )automaticallyAdaptToHighly:(CGFloat )value targetString:(NSString *)targetStr{
    //自适应宽高
    CGSize MaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    // 表示字体的字典
    //    NSDictionary *attr = @{NSFontAttributeName : LHYTextFont(value*kScaleW)};
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:(value)]};
    // 计算后的昵称文字尺寸
    CGSize LabelSize = [targetStr boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    return LabelSize;
}
//创建label
-(UILabel *)commonPropertyWithTextColor:(UIColor *)color WithFont:(CGFloat)font WithText:(NSString *)textStr{
    
    UILabel *commonLabel = [[UILabel alloc] init];
    commonLabel.textColor = color;
    commonLabel.font = LHYFont(font);
    commonLabel.text = textStr;
    
    return commonLabel;
}

/**
 
 * 创建纯色的图片，用来做背景
 
 */
- (UIImage *)switchToImageWithColor:(UIColor *)color size:(CGSize)size

{
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    [color set];
    
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    UIImage *ColorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return ColorImg;
    
}

@end
