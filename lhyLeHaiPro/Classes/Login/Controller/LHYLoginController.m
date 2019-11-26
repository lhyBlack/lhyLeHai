//
//  LHYLoginController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//wojiushi ceshiyixia aaaa

#import "LHYLoginController.h"
#import "LHYLoginView.h"
#import "LHYRegistController.h"
#import "LHYCodeLoginController.h"
#import "WXApi.h"

@interface LHYLoginController ()<LHYLoginViewDelegate,WXApiDelegate>{
NSString *_code;//用户换取access_token的code，仅在ErrCode为0时有效
/*    NSString *_accessToken;//接口调用凭证
 NSString *_refreshToken;//用户刷新access_token
 NSString *_openid;//授权用户唯一标识
 NSString *_scope;//用户授权的作用域，使用逗号（,）分隔
 NSString *_unionid; //当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段*/
}
@end

@implementation LHYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lhy_creatSubViews];
    
    [KNotificationCenter addObserver:self selector:@selector(wxLogin:) name:@"wxLogin" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)lhy_creatSubViews{
    LHYLoginView *loginView = [[LHYLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

//三方登录按钮点击
-(void)lhy_loginThreeBtnDelegate:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            
            break;
        case 101:{
            //判断微信是否安装
            if([WXApi isWXAppInstalled]){
                SendAuthReq *req = [[SendAuthReq alloc] init];
                req.scope = @"snsapi_userinfo";
                req.state = @"App";
                [WXApi sendAuthReq:req viewController:self delegate:self completion:^(BOOL success) {
                    NSLog(@"微信回调成功");
                }];
            }else{
                [MBProgressHUD showError:@"检测到您未安装微信客户端,请先安装微信客户端"];
            }
        }
            break;
        case 102:
            break;
        default:
            break;
    }
}
//注册登录按钮点击
-(void)lhy_registLoginBtnClickDelegate:(UIButton *)sender{
    if (sender.tag == 100) {
        [self.navigationController pushViewController:[LHYRegistController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[LHYCodeLoginController new] animated:YES];
    }
}
//协议按钮点击
-(void)lhy_tipsLabelClickDelegate{
    NSLog(@"协议点击");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- 未安装微信提示
- (void)setupAlertController{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfim = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [vc addAction:actionConfim];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)wxLogin:(NSNotification*)noti{
    //获取到code
    SendAuthResp *resp = noti.object;
    NSLog(@"%@",resp.code);
}


@end
