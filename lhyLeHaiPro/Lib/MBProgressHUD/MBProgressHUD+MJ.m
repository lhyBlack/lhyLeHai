//
//  MBProgressHUD+MJ.m
//
//  Created by MJ Lee on 13/4/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view afterDelay:(CGFloat)delay
{
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //在StatusBarHud 显示期间，由于lastObject的Frame的缘故将导致
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //字体变小且自动换行
    hud.detailsLabelText = text;
    hud.mode = MBProgressHUDModeCustomView;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    if (delay == 0.0) {
        delay = 2.5;
    }
    // 默认1.5秒之后再消失
    [hud hide:YES afterDelay:delay];
}


#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"" view:view afterDelay:0.0];
}
+ (void)showError:(NSString *)error toView:(UIView *)view afterDelay:(CGFloat)delay {
    [self show:error icon:@"" view:view afterDelay:0.0];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view afterDelay:0.0];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view afterDelay:(CGFloat)delay
{
    [self show:success icon:@"success.png" view:view afterDelay:delay];
}



static UIImageView *imageView;
+ (void)load{
//    NSMutableArray *imgArr = [NSMutableArray array];
//    for (int i = 0; i < 24; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"loading3/loading 00%02d.png",i+1];
//        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
//        UIImage *img = [UIImage imageWithContentsOfFile:path];
//        [imgArr addObject:img];
//    }
//    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50*kScaleW, 50*kScaleW)];
//    imageView.animationImages = imgArr;
//    imageView.animationDuration = 1;
//    [imageView startAnimating];
}
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.color = [UIColor clearColor];
////    hud.labelText = message;
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
//    hud.customView = imageView;
//    return hud;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    return hud;
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success afterDelay:(CGFloat)delay
{
    [self showSuccess:success toView:nil afterDelay:delay];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error afterDelay:(CGFloat)delay
{
    [self showError:error toView:nil afterDelay:delay];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //在StatusBarHud 显示期间，由于lastObject的Frame的缘故将导致
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
