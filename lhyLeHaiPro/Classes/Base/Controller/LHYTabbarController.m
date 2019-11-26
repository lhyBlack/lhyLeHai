//
//  LHYTabbarController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/22.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYTabbarController.h"
#import "LHYNavController.h"
#import "LHYShowController.h"
#import "LHYRankController.h"
#import "LHYFindController.h"
#import "LHYProfileController.h"
@interface LHYTabbarController ()

@end

@implementation LHYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //秀场控制器
    LHYShowController *showCtrl = [[LHYShowController alloc] init];
    //排行界面控制器
    LHYRankController *rankCtrl = [[LHYRankController alloc] init];
    //发现界面控制器
    LHYFindController *findCtrl = [[LHYFindController alloc] init];
    //我的界面控制器
    LHYProfileController *profileCtrl = [[LHYProfileController alloc] init];
    
    //秀场
    [self addChildViewController:showCtrl imageName:@"home" title:@"秀场"];
    //排行
    [self addChildViewController:rankCtrl imageName:@"zixun" title:@"排行"];
    //发现
    [self addChildViewController:findCtrl imageName:@"my" title:@"发现"];
    //我的
    [self addChildViewController:profileCtrl imageName:@"my" title:@"我的"];
}

//添加子控制器,设置标题与图片
- (void)addChildViewController:(UIViewController *)childCtrl imageName:(NSString *)imageName title:(NSString *)title{
    
    //    //使用自定义的tabBarItem,以便遍历badge身上的view
    //    childCtrl.tabBarItem = [[IWTabBarItem alloc] init];
    
    //    childCtrl.tabBarItem.badgeImageName = @"main_badge";
    //设置选中与未选中的图片-->指定一下渲染模式-->图片以原样的方式显示出来
    childCtrl.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置标题
    //    childCtrl.tabBarItem.title = title;
    //        childCtrl.navigationItem.title = title;
    childCtrl.title = title;
    
    //    childCtrl.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //指定一下属性
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor getColor:@"000000"];
    
    //        dic[NSForegroundColorAttributeName] = [UIColor redColor];
    
    //指定字体
    //    dic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    //指定选中状态下文字颜色
    [childCtrl.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    
    LHYNavController *navCtrl = [[LHYNavController alloc] initWithRootViewController:childCtrl];
    //    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:childCtrl];
    
    [self addChildViewController:navCtrl];
}

@end
