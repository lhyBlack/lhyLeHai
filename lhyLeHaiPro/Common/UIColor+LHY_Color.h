//
//  UIColor+LHY_Color.h
//  lhyFangDai
//
//  Created by ruhua on 2019/6/27.
//  Copyright © 2019 ruhua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LHY_Color)

+ (UIColor *)getColor:(NSString *)hexColor;

- (UIImage *)cm_imageWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
