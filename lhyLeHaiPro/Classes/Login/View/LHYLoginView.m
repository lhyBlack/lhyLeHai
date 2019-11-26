//
//  LHYLoginView.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYLoginView.h"

@interface LHYLoginView ()

@property(nonatomic,weak)UIImageView *backImg;

@property(nonatomic,weak)UILabel *tipsLabel;

@end

@implementation LHYLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        backImg.image = [UIImage imageNamed:@"login_backView_image"];
        backImg.userInteractionEnabled = YES;
        [self addSubview:backImg];
        self.backImg = backImg;
        NSArray *threeBtnImg = @[@"login_qq_image",@"login_weixin_image",@"login_phone_image"];
        //添加登录的三个按钮
        for (int i = 0; i < 3; i++) {
            UIButton *loginThreeBtn = [[UIButton alloc] init];
            loginThreeBtn.tag = 100+i;
            [loginThreeBtn setBackgroundImage:[UIImage imageNamed:threeBtnImg[i]] forState:UIControlStateNormal];
            loginThreeBtn.frame = CGRectMake(120*kScaleW*i+50*kScaleW, kScreenHeight - 160*kScaleW, 40*kScaleW, 40*kScaleW);
            [backImg addSubview:loginThreeBtn];
            [loginThreeBtn addTarget:self action:@selector(lhy_loginThreeBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        //快速注册/账号登录
        NSArray *textArr = @[@"快速注册",@"账号登录"];
        for (int i = 0; i < 2; i++) {
            UIButton *registLoginBtn = [[UIButton alloc] init];
            registLoginBtn.tag = 100+i;
            [registLoginBtn setTitle:textArr[i] forState:UIControlStateNormal];
            [registLoginBtn setTitleColor:LHY_Hex_Color(@"333333") forState:UIControlStateNormal];
            registLoginBtn.frame = CGRectMake(100*kScaleW*i + 95*kScaleW, kScreenHeight - 100*kScaleW, 100*kScaleW, 20*kScaleW);
            [registLoginBtn addTarget:self action:@selector(lhy_registLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [backImg addSubview:registLoginBtn];
        }
        
        self.tipsLabel.frame = CGRectMake(20*kScaleW, kScreenHeight - 50*kScaleW, 335*kScaleW, 20*kScaleW);
        
    }
    return self;
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        UILabel *tipsLabel = [UILabel new];
        NSString *proxyString = @"伊人直播服务条款";
        tipsLabel.text = [@"登录/注册即表示同意" stringByAppendingString:proxyString];
        tipsLabel.textColor = LHY_Hex_Color(@"999999");
        tipsLabel.attributedText = [tipsLabel.text cm_changeTextRange:NSMakeRange(tipsLabel.text.length - proxyString.length, proxyString.length) Color:LHY_Hex_Color(@"000000") Font:LHYFont(12)];
        tipsLabel.font = LHYFont(12);
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lhy_tipsLabelClick)];
        [tipsLabel addGestureRecognizer:tap];
        _tipsLabel = tipsLabel;
        [self.backImg addSubview:_tipsLabel];
    }
    
    return _tipsLabel;
}

//三方登录按钮点击
-(void)lhy_loginThreeBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(lhy_loginThreeBtnDelegate:)]) {
        [self.delegate lhy_loginThreeBtnDelegate:sender];
    }
}
//注册登录按钮点击
-(void)lhy_registLoginBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(lhy_registLoginBtnClickDelegate:)]) {
        [self.delegate lhy_registLoginBtnClickDelegate:sender];
    }
}
//协议按钮点击
-(void)lhy_tipsLabelClick{
    if ([self.delegate respondsToSelector:@selector(lhy_tipsLabelClickDelegate)]) {
        [self.delegate lhy_tipsLabelClickDelegate];
    }
}

@end
