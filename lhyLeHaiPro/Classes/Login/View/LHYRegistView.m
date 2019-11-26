//
//  LHYRegistView.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYRegistView.h"
#import "GGVerifyCodeViewBtn.h"

@interface LHYRegistView ()

@property(nonatomic,weak)UIView *topBgView;

@property(nonatomic,weak)GGVerifyCodeViewBtn *countDownBtn;

@property(nonatomic,weak)UILabel *tipsLabel;

@property(nonatomic,weak)UIButton *switchBtn;

@end

@implementation LHYRegistView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //上面的白色的View
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*kScaleW)];
        topBgView.backgroundColor = LHY_Hex_Color(@"ffffff");
        [self addSubview:topBgView];
        self.topBgView = topBgView;
        NSArray *leftTextArr = @[@"手机号",@"密码",@"验证码",@"性别"];
        NSArray *textFieldArr = @[@"请输入手机号",@"6-20位字母或数字",@"请输入验证码"];
        NSArray *sexArr = @[@"男",@"女"];
        CGSize leftTitleSize = [self automaticallyAdaptToHighly:17*kScaleW targetString:leftTextArr[0]];
        for (int i = 0; i < 4; i++) {
            //分割线
            UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 60*kScaleW *i, kScreenWidth, 1)];
            lineV.backgroundColor = LHY_Hex_Color(@"EEEEEE");
            [topBgView addSubview:lineV];
            //左面标题
            UILabel *leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(15*kScaleW,20*kScaleW +60*kScaleW*i , leftTitleSize.width, 20*kScaleW)];
            leftTitle.textColor = LHY_Hex_Color(@"333333");
            leftTitle.font = LHYFont(17*kScaleW);
            leftTitle.text = leftTextArr[i];
            [topBgView addSubview:leftTitle];
            if (i < 3) {
                UITextField *centerTextField = [[UITextField alloc] initWithFrame:CGRectMake(leftTitle.maxX + 15*kScaleW, leftTitle.y, 180*kScaleW, leftTitle.height)];
                centerTextField.placeholder = textFieldArr[i];
                [topBgView addSubview:centerTextField];
                if (i == 2) {
                    self.countDownBtn.frame = CGRectMake(kScreenWidth - 120*kScaleW - 15*kScaleW, centerTextField.y, 120*kScaleW, 40*kScaleW);
                    self.countDownBtn.centerY = centerTextField.centerY;
                    self.countDownBtn.layer.cornerRadius = 20*kScaleW;
                    self.countDownBtn.layer.masksToBounds = YES;
                }
            }
            if (i == 3) {
                for (int j = 0; j < 2; j++) {
                    UIButton *sexBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftTitle.maxX + 15*kScaleW + 85*j*kScaleW, 0, 65*kScaleW, 35*kScaleW)];
                    sexBtn.centerY = leftTitle.centerY;
                    sexBtn.tag = 101+j;
                    if (j == 1) {
                        sexBtn.selected = YES;
                    }
                    [sexBtn setTitle:sexArr[j] forState:UIControlStateNormal];
                    [sexBtn setTitleColor:LHY_Hex_Color(@"ffffff") forState:UIControlStateNormal];
                    [sexBtn setTitleColor:LHY_Hex_Color(@"333333") forState:UIControlStateSelected];
                    [sexBtn setBackgroundImage:[UIImage imageNamed:@"login_register_gender_sel_image"] forState:UIControlStateNormal];
                    [sexBtn setBackgroundImage:[UIImage imageNamed:@"login_register_gender_nal_image"] forState:UIControlStateSelected];
                    [sexBtn addTarget:self action:@selector(lhy_sexBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [topBgView addSubview:sexBtn];
                }
            }
        }
        //添加一串文字
        UILabel *sexNoChange = [[UILabel alloc] commonPropertyWithTextColor:LHY_Hex_Color(@"999999") WithFont:17*kScaleW WithText:@"性别注册后不能修改"];
        sexNoChange.frame = CGRectMake(20*kScaleW, topBgView.maxY + 10*kScaleW, kScreenWidth/2, 20*kScaleW);
        [self addSubview:sexNoChange];
        //下一步按钮
        UIButton *nextStepBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kScaleW, sexNoChange.maxY + 15*kScaleW, kScreenWidth - 40*kScaleW, 40*kScaleW)];
        nextStepBtn.layer.cornerRadius = 8*kScaleW;
        nextStepBtn.layer.masksToBounds = YES;
        [nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextStepBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"71A5F1") size:nextStepBtn.size] forState:UIControlStateNormal];
        [nextStepBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"eeeeee") size:nextStepBtn.size] forState:UIControlStateDisabled];
        [self addSubview:nextStepBtn];
        //协议前面的按钮
        UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kScaleW, nextStepBtn.maxY + 10*kScaleW, 18*kScaleW, 18*kScaleW)];
        [switchBtn setBackgroundImage:[UIImage imageNamed:@"login_phone_cloose_nal_image"] forState:UIControlStateNormal];
        [switchBtn setBackgroundImage:[UIImage imageNamed:@"login_phone_cloose_sel_image"] forState:UIControlStateSelected];
        switchBtn.selected = YES;
        [switchBtn addTarget:self action:@selector(lhy_switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:switchBtn];
        self.switchBtn = switchBtn;
        //添加协议
        self.tipsLabel.frame = CGRectMake(switchBtn.maxX + 8*kScaleW, nextStepBtn.maxY + 10*kScaleW, 295*kScaleW, 20*kScaleW);
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

//协议懒加载
- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        UILabel *tipsLabel = [UILabel new];
        NSString *proxyString = @"伊人直播服务条款";
        tipsLabel.text = [@"注册即表示阅读并同意  " stringByAppendingString:proxyString];
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

//性别button点击事件
-(void)lhy_sexBtnBtnClick:(UIButton *)sender{
    
    for (int i=0;i<2;i++){
        if (sender.tag == 101+i) {
            sender.selected = NO;
            continue;
        }
        UIButton *btn =(UIButton *)[self viewWithTag:101+i];
        btn.selected = YES;
    }
}

//协议按钮前面对号
-(void)lhy_switchBtnClick{
    self.switchBtn.selected = !self.switchBtn.selected;
}

//协议按钮点击
-(void)lhy_tipsLabelClick{
    
    if ([self.delegate respondsToSelector:@selector(lhy_tipsLabelClickDelegate)]) {
        [self.delegate lhy_tipsLabelClickDelegate];
    }
}
@end
