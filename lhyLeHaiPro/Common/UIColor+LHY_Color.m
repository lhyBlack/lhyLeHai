//
//  UIColor+LHY_Color.m
//  lhyFangDai
//
//  Created by ruhua on 2019/6/27.
//  Copyright © 2019 ruhua. All rights reserved.
//

#import "UIColor+LHY_Color.h"

@implementation UIColor (LHY_Color)
+ (UIColor *)getColor:(NSString *)hexColor
{
    if (hexColor == nil || hexColor.length == 0) {
        NSLog(@"color string is nil.");
        return [UIColor blackColor];
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    NSString *deHexColor = [hexColor substringWithRange:range];
    [[NSScanner scannerWithString:deHexColor] scanHexInt:&red];
    
    range.location = 2;
    deHexColor = [hexColor substringWithRange:range];
    [[NSScanner scannerWithString:deHexColor] scanHexInt:&green];
    
    range.location = 4;
    deHexColor = [hexColor substringWithRange:range];
    [[NSScanner scannerWithString:deHexColor] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

- (UIImage *)cm_imageWithSize:(CGSize)size {
    
    
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
