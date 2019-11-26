//
//  LHYFastLoginView.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYFastLoginView.h"
#import "GGVerifyCodeViewBtn.h"

@interface LHYFastLoginView ()

@property(nonatomic,weak)UIView *topBgView;

@property(nonatomic,weak)GGVerifyCodeViewBtn *countDownBtn;

@property(nonatomic,weak)UIButton *switchBtn;

@property(nonatomic,weak)UILabel *tipsLabel;
@end

@implementation LHYFastLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //上面的白色的View
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180*kScaleW)];
        topBgView.backgroundColor = LHY_Hex_Color(@"ffffff");
        [self addSubview:topBgView];
        self.topBgView = topBgView;
        NSArray *textFieldArr = @[@"请输入手机号",@"请输入验证码"];
        for (int i = 0; i < 3; i++) {
            //分割线
            UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 60*kScaleW *i, kScreenWidth, 1)];
            lineV.backgroundColor = LHY_Hex_Color(@"EEEEEE");
            [topBgView addSubview:lineV];
            if (i == 0) {
                //电话归属地
                UILabel *telLabel = [[UILabel alloc] commonPropertyWithTextColor:LHY_Hex_Color(@"333333") WithFont:16*kScaleW WithText:@"+86 中国"];
                telLabel.frame = CGRectMake(0, 20*kScaleW, 100*kScaleW, 20*kScaleW);
                telLabel.centerX = topBgView.centerX;
                [topBgView addSubview:telLabel];
                //跳转箭头
                UIButton *pushAro = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 19*kScaleW - 15*kScaleW, telLabel.y, 19*kScaleW, 19*kScaleW)];
                [pushAro setBackgroundImage:[UIImage imageNamed:@"common_usercard_arrow_image"] forState:UIControlStateNormal];
                [topBgView addSubview:pushAro];
            }
            if (i > 0) {
                UITextField *centerTextField = [[UITextField alloc] initWithFrame:CGRectMake(15*kScaleW, 20*kScaleW +60*kScaleW*i, 180*kScaleW, 20*kScaleW)];
                centerTextField.placeholder = textFieldArr[i-1];
                [topBgView addSubview:centerTextField];
                if (i == 2) {
                    self.countDownBtn.frame = CGRectMake(kScreenWidth - 120*kScaleW - 15*kScaleW, centerTextField.y, 120*kScaleW, 40*kScaleW);
                    self.countDownBtn.centerY = centerTextField.centerY;
                    self.countDownBtn.layer.cornerRadius = 20*kScaleW;
                    self.countDownBtn.layer.masksToBounds = YES;
                }
            }
        }
        //无痕浏览
        UIButton *noTranceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, topBgView.maxY + 15*kScaleW, 100*kScaleW, 18*kScaleW)];
        [noTranceBtn setTitle:@"无痕浏览" forState:UIControlStateNormal];
        [noTranceBtn setTitleColor:LHY_Hex_Color(@"333333") forState:UIControlStateNormal];
        [noTranceBtn setImage:[UIImage imageNamed:@"login_phone_cloose_nal_image"] forState:UIControlStateNormal];
        [noTranceBtn setImage:[UIImage imageNamed:@"login_phone_cloose_sel_image"] forState:UIControlStateSelected];
        [noTranceBtn addTarget:self action:@selector(noTranceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:noTranceBtn];
        //登录按钮
        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kScaleW, noTranceBtn.maxY + 25*kScaleW, kScreenWidth - 40*kScaleW, 50*kScaleW)];
        loginBtn.layer.cornerRadius = 25*kScaleW;
        loginBtn.layer.masksToBounds = YES;
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"9ED299") size:loginBtn.size] forState:UIControlStateNormal];
        [loginBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"eeeeee") size:loginBtn.size] forState:UIControlStateDisabled];
        [self addSubview:loginBtn];
        //协议前面的按钮
        UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kScaleW, loginBtn.maxY + 10*kScaleW, 18*kScaleW, 18*kScaleW)];
        [switchBtn setBackgroundImage:[UIImage imageNamed:@"login_phone_cloose_nal_image"] forState:UIControlStateNormal];
        [switchBtn setBackgroundImage:[UIImage imageNamed:@"login_phone_cloose_sel_image"] forState:UIControlStateSelected];
        switchBtn.selected = YES;
        [switchBtn addTarget:self action:@selector(lhy_switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:switchBtn];
        self.switchBtn = switchBtn;
        //添加协议
        self.tipsLabel.frame = CGRectMake(switchBtn.maxX + 8*kScaleW, loginBtn.maxY + 10*kScaleW, 295*kScaleW, 20*kScaleW);
    }
    return self;
}

//倒计时懒加载
- (GGVerifyCodeViewBtn *)countDownBtn {
    if (!_countDownBtn) {
        GGVerifyCodeViewBtn *countDownBtn = [[GGVerifyCodeViewBtn alloc] init];
        //        countDownBtn.enabled = NO;
        countDownBtn.titleLabel.font = LHYFont(17);
        countDownBtn.backgroundColor = LHY_Hex_Color(@"71A5F1");
        [countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownBtn setTitleColor:LHY_Hex_Color(@"ffffff") forState:UIControlStateNormal];
        [countDownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        //        countDownBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [countDownBtn addTarget:self action:@selector(lhy_codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
        [self.topBgView addSubview:countDownBtn];
        _countDownBtn = countDownBtn;
    }
    return _countDownBtn;
}
//验证码点击事件
- (void)lhy_codeBtnVerification {
    
    /*
     
     调用短信验证码接口
     用户输入的验证码数字传给server，判断请求结果作不同的逻辑处理，根据自己家的产品大大需求来即可....
     */
    
    /*
     if （请求成功且匹配成功验证码数字）{
     [self.countDownBtn timeFailBeginFrom:60];  // 倒计时60s
     } else {
     [self.countDownBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
     }
     */
    
    [self.countDownBtn timeFailBeginFrom:6];
}

-(void)noTranceBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

//协议按钮前面对号
-(void)lhy_switchBtnClick{
    self.switchBtn.selected = !self.switchBtn.selected;
}

//协议按钮点击
-(void)lhy_tipsLabelClick{
    
//    if ([self.delegate respondsToSelector:@selector(lhy_tipsLabelClickDelegate)]) {
//        [self.delegate lhy_tipsLabelClickDelegate];
//    }
}

//协议懒加载
- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        UILabel *tipsLabel = [UILabel new];
        NSString *proxyString = @"伊人直播服务条款";
        tipsLabel.text = [@"登录即表示阅读并同意  " stringByAppendingString:proxyString];
        tipsLabel.textColor = LHY_Hex_Color(@"999999");
        tipsLabel.attributedText = [tipsLabel.text cm_changeTextRange:NSMakeRange(tipsLabel.text.length - proxyString.length, proxyString.length) Color:LHY_Hex_Color(@"71A5F1") Font:LHYFont(12)];
        tipsLabel.font = LHYFont(14);
//        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lhy_tipsLabelClick)];
        [tipsLabel addGestureRecognizer:tap];
        _tipsLabel = tipsLabel;
        [self addSubview:_tipsLabel];
    }
    
    return _tipsLabel;
}
@end
