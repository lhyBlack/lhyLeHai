//
//  LHYNavController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/22.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYNavController.h"

@interface LHYNavController ()<UIGestureRecognizerDelegate>

/**default notes*/
@property (nonatomic,strong) UIButton *backButton;

@end

@implementation LHYNavController
- (UIButton *)backButton {
    
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 10*kScaleW, 30*kScaleW, 30*kScaleW);
        [_backButton setImage:[UIImage imageNamed:@"common_navi_backImage"] forState:UIControlStateNormal];
        
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条的背景图片
    [self.navigationBar setShadowImage:[UIImage new]];
    //添加返回手势
    //    self.interactivePopGestureRecognizer.delegate = self;
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    
    //    SDLog(@"%@",self.topViewController);
    
    if (self.childViewControllers.count == 1) {
        return NO;
    } else {
        
        if([NSStringFromClass([self.topViewController class]) isEqualToString:@"WD_HomeViewController"])
        {
            return NO;
        }
        
        if([NSStringFromClass([self.topViewController class]) isEqualToString:@"WD_SDKWebViewController"])
        {
            return NO;
        }
        
        if([NSStringFromClass([self.topViewController class]) isEqualToString:@"SDSetPassWordViewController"])
        {
            return NO;
        }
        if([NSStringFromClass([self.topViewController class]) isEqualToString:@"SDAuthenticationViewController"])
        {
            return NO;
        }
        if([NSStringFromClass([self.topViewController class]) isEqualToString:@"SDLeiXiongMemberVC"])
        {
            return NO;
        }
        
        if([NSStringFromClass([self.topViewController class]) isEqualToString:@"SDIDCardSuccessController"] || [NSStringFromClass([self.topViewController class]) isEqualToString:@"SDConfirmInfoViewController"] || [NSStringFromClass([self.topViewController class]) isEqualToString:@"SDLiveDetectViewController"] || [NSStringFromClass([self.topViewController class]) isEqualToString:@"SDShowVerificationInfoController"] || [NSStringFromClass([self.topViewController class]) isEqualToString:@"SDLiveDetectFailController"]
           || [NSStringFromClass([self.topViewController class]) isEqualToString:@"SDMoxieCarrierViewController"] ){
            return NO;
        }
        return YES;
    }
    
}

- (void)cmyh_whiteStyle {
    
    [self.navigationBar setBackgroundImage:[LHY_Hex_Color(@"ffffff") cm_imageWithSize:CGSizeMake(kScreenWidth, kTopHeight)] forBarMetrics:UIBarMetricsDefault];
    // 设置文字的颜色为白色
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName :[UIColor blackColor] }];
    
    //设置导航栏没有半透明效果
    //    self.navigationBar.translucent = NO;
    
    [self.backButton setImage:[[UIImage imageNamed:@"navi_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
}

- (void)cmyh_transparentStyle {
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置文字的颜色为白色
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor getColor:@"333333"] }];
    
    //设置导航栏没有半透明效果
    //    self.navigationBar.translucent = NO;
    
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.backButton setImage:[[UIImage imageNamed:@"Back Button"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    
}

- (void)cmyh_blackStyle {
    
    [self.navigationBar setBackgroundImage:[LHY_Hex_Color(@"007bff") cm_imageWithSize:CGSizeMake(kScreenWidth, kTopHeight)] forBarMetrics:UIBarMetricsDefault];
    
    // 设置文字的颜色为白色
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    //设置导航栏没有半透明效果
    //    self.navigationBar.translucent = NO;
    
    
    [self.backButton setImage:[[UIImage imageNamed:@"Back Button"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        //自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //自定义返回按钮
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        
        viewController.navigationItem.leftBarButtonItem = leftBar;
    }
    
    
    [super pushViewController:viewController animated:animated];
}


- (void)backAction {
    [self popViewControllerAnimated:YES];
}



@end
