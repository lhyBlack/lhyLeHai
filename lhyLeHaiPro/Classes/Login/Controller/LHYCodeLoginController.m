//
//  LHYCodeLoginController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYCodeLoginController.h"
#import "LHYCodeLoginView.h"
#import "LHYRegistController.h"
#import "LHYFastLoginController.h"
#import "LHYFindMiMaController.h"

@interface LHYCodeLoginController ()<LHYCodeLoginViewDelegate>

@end

@implementation LHYCodeLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = LHY_Hex_Color(@"eeeeee");
    [self lhy_creatSubViews];
}

-(void)lhy_creatSubViews{
    LHYCodeLoginView *codeLoginView = [[LHYCodeLoginView alloc] initWithFrame:CGRectMake(0, kTopHeight+20*kScaleW, kScreenWidth, kScreenHeight-20*kScaleW-kTopHeight)];
    codeLoginView.delegate = self;
    [self.view addSubview:codeLoginView];
}

//找回密码
-(void)lhy_backMiMaBtnClickDelegate:(UIButton *)sender{
    [self.navigationController pushViewController:[LHYFindMiMaController new] animated:YES];
}

//短信验证码登录
-(void)lhy_codeVLoginClickDelegate:(UIButton *)senedr{
 
    [self.navigationController pushViewController:[LHYFastLoginController new] animated:YES];
}
//三方登录按钮点击
-(void)lhy_loginThreeBtnDelegate:(UIButton *)sender{
    
}
//注册按钮点击
-(void)lhy_registBtnClickDelegate:(UIButton *)sender{
    
    [self.navigationController pushViewController:[LHYRegistController new] animated:YES];
}

@end
