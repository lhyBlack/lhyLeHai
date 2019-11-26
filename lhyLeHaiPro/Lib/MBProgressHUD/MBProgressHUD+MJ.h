//
//  MBProgressHUD+MJ.h
//
//  Created by MJ Lee on 13/4/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//


#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success afterDelay:(CGFloat)delay;
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error afterDelay:(CGFloat)delay;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end