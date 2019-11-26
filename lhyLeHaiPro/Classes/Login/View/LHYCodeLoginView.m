//
//  LHYCodeLoginView.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYCodeLoginView.h"

@interface LHYCodeLoginView ()

@property(nonatomic,weak)UIView *topBgView;

@end

@implementation LHYCodeLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //上面的白色的View
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120*kScaleW)];
        topBgView.backgroundColor = LHY_Hex_Color(@"ffffff");
        [self addSubview:topBgView];
        self.topBgView = topBgView;
        NSArray *leftImageArr = @[@"login_accountNumber_account_image",@"login_accountNumber_password_image"];
        NSArray *textFieldArr = @[@"请输入用户名/手机号",@"请输入密码"];
        for (int i = 0; i < 2; i++) {
            //分割线
            UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 60*kScaleW *i, kScreenWidth, 1)];
            lineV.backgroundColor = LHY_Hex_Color(@"EEEEEE");
            [topBgView addSubview:lineV];
            //左面的imageView
            UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*kScaleW, 20*kScaleW +60*kScaleW*i, 18*kScaleW, 21*kScaleW)];
            leftImageView.image = [UIImage imageNamed:leftImageArr[i]];
            [topBgView addSubview:leftImageView];
            //添加textField
            UITextField *centerTextField = [[UITextField alloc] initWithFrame:CGRectMake(leftImageView.maxX + 15*kScaleW, leftImageView.y, 180*kScaleW, leftImageView.height)];
            centerTextField.placeholder = textFieldArr[i];
            [topBgView addSubview:centerTextField];
        }
        //找回密码按钮
        UIButton *backMiMaBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100*kScaleW, topBgView.maxY + 15*kScaleW, 100*kScaleW, 20*kScaleW)];
        [backMiMaBtn setTitle:@"找回密码" forState:UIControlStateNormal];
        [backMiMaBtn setTitleColor:LHY_Hex_Color(@"333333") forState:UIControlStateNormal];
        [backMiMaBtn addTarget:self action:@selector(lhy_backMiMaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backMiMaBtn];
        //登录按钮
        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(15*kScaleW, backMiMaBtn.maxY + 15*kScaleW, 345*kScaleW, 50*kScaleW)];
        [loginBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"F9645B") size:loginBtn.size] forState:UIControlStateNormal];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn.layer.cornerRadius = 8*kScaleW;
        loginBtn.layer.masksToBounds = YES;
        [self addSubview:loginBtn];
        //通过短信验证码登录
        UIButton *codeVLogin = [[UIButton alloc] initWithFrame:CGRectMake(15*kScaleW, loginBtn.maxY+15*kScaleW, kScreenWidth - 30*kScaleW, 20*kScaleW)];
        [codeVLogin setTitle:@"通过短信验证码登录" forState:UIControlStateNormal];
        [codeVLogin setTitleColor:LHY_Hex_Color(@"52B7D1") forState:UIControlStateNormal];
        [codeVLogin addTarget:self action:@selector(lhy_codeVLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:codeVLogin];
        //一键登录分割左
        UIView *leftFView = [[UIView alloc] initWithFrame:CGRectMake(loginBtn.x, codeVLogin.maxY + 30*kScaleW, 125*kScaleW, 1)];
        leftFView.backgroundColor = LHY_Hex_Color(@"cccccc");
        [self addSubview:leftFView];
        //一键登录文字
        UILabel *yiJianDeng = [[UILabel alloc] commonPropertyWithTextColor:LHY_Hex_Color(@"cccccc") WithFont:17*kScaleW WithText:@"一键登录"];
        yiJianDeng.textAlignment = NSTextAlignmentCenter;
        yiJianDeng.frame = CGRectMake(leftFView.maxX, 0, 100*kScaleW, 20*kScaleW);
        yiJianDeng.centerY = leftFView.centerY;
        [self addSubview:yiJianDeng];
        //一键登录分割右
        UIView *rightFView = [[UIView alloc] initWithFrame:CGRectMake(yiJianDeng.maxX, codeVLogin.maxY + 30*kScaleW, 125*kScaleW, 1)];
        rightFView.backgroundColor = LHY_Hex_Color(@"cccccc");
        [self addSubview:rightFView];
        
        //添加登录的三个按钮
        NSArray *threeBtnImg = @[@"login_qq_image",@"login_weixin_image",@"login_phone_image"];
        NSArray *threeBtnText = @[@"QQ",@"微信",@"手机"];
        for (int i = 0; i < 3; i++) {
            UIButton *loginThreeBtn = [[UIButton alloc] init];
            loginThreeBtn.tag = 100+i;
            [loginThreeBtn setBackgroundImage:[UIImage imageNamed:threeBtnImg[i]] forState:UIControlStateNormal];
            loginThreeBtn.frame = CGRectMake(120*kScaleW*i+50*kScaleW, yiJianDeng.maxY + 20*kScaleW, 40*kScaleW, 40*kScaleW);
            [self addSubview:loginThreeBtn];
            [loginThreeBtn addTarget:self action:@selector(lhy_loginThreeBtn:) forControlEvents:UIControlEventTouchUpInside];
            //三个名称
            UILabel *textLabel = [[UILabel alloc] commonPropertyWithTextColor:LHY_Hex_Color(@"bbbbbb") WithFont:17*kScaleW WithText:threeBtnText[i]];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.x = loginThreeBtn.x;
            textLabel.y = loginThreeBtn.maxY + 10*kScaleW;
            textLabel.width = loginThreeBtn.width;
            textLabel.height = 20*kScaleW;
            [self addSubview:textLabel];
        }
        //注册按钮点击
        UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, self.height - 100*kScaleW, 100*kScaleW, 40*kScaleW)];
        registBtn.centerX = self.centerX;
        [registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registBtn setTitleColor:LHY_Hex_Color(@"52B7D1") forState:UIControlStateNormal];
        [registBtn.layer setBorderColor:LHY_Hex_Color(@"52B7D1").CGColor];
        [registBtn.layer setBorderWidth:1];
        registBtn.layer.cornerRadius = 3.0f;
        [registBtn addTarget:self action:@selector(lhy_registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registBtn];
    }
    return self;
}

//找回密码
-(void)lhy_backMiMaBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(lhy_backMiMaBtnClickDelegate:)]) {
        [self.delegate lhy_backMiMaBtnClickDelegate:sender];
    }
}

//短信验证码登录点击
-(void)lhy_codeVLoginClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(lhy_codeVLoginClickDelegate:)]) {
        [self.delegate lhy_codeVLoginClickDelegate:sender];
    }
}

//三方登录按钮点击
-(void)lhy_loginThreeBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(lhy_loginThreeBtnDelegate:)]) {
        [self.delegate lhy_loginThreeBtnDelegate:sender];
    }
}

-(void)lhy_registBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(lhy_registBtnClickDelegate:)]) {
        [self.delegate lhy_registBtnClickDelegate:sender];
    }
}

@end
