//
//  LHYFindMiMaView.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYFindMiMaView.h"
#import "GGVerifyCodeViewBtn.h"

@interface LHYFindMiMaView ()

@property(nonatomic,weak)UIView *topBgView;

@property(nonatomic,weak)GGVerifyCodeViewBtn *countDownBtn;

@end

@implementation LHYFindMiMaView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //上面的白色的View
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120*kScaleW)];
        topBgView.backgroundColor = LHY_Hex_Color(@"ffffff");
        [self addSubview:topBgView];
        self.topBgView = topBgView;
        NSArray *textFieldArr = @[@"请输入要找回的伊人直播账号",@"请输入验证码"];
        for (int i = 0; i < 2; i++) {
            //分割线
            UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 60*kScaleW *i, kScreenWidth, 1)];
            lineV.backgroundColor = LHY_Hex_Color(@"EEEEEE");
            [topBgView addSubview:lineV];
            //添加textField
            UITextField *centerTextField = [[UITextField alloc] initWithFrame:CGRectMake(15*kScaleW, 20*kScaleW +60*kScaleW*i, 220*kScaleW, 20*kScaleW)];
            centerTextField.placeholder = textFieldArr[i];
            [topBgView addSubview:centerTextField];
            if (i == 1) {
                self.countDownBtn.frame = CGRectMake(kScreenWidth - 120*kScaleW - 15*kScaleW, centerTextField.y, 120*kScaleW, 40*kScaleW);
                self.countDownBtn.centerY = centerTextField.centerY;
                self.countDownBtn.layer.cornerRadius = 20*kScaleW;
                self.countDownBtn.layer.masksToBounds = YES;
            }
        }
        //下一步按钮
        UIButton *nextStepBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kScaleW, topBgView.maxY + 15*kScaleW, kScreenWidth - 40*kScaleW, 40*kScaleW)];
        nextStepBtn.layer.cornerRadius = 8*kScaleW;
        nextStepBtn.layer.masksToBounds = YES;
        [nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextStepBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"71A5F1") size:nextStepBtn.size] forState:UIControlStateNormal];
        [nextStepBtn setBackgroundImage:[self switchToImageWithColor:LHY_Hex_Color(@"eeeeee") size:nextStepBtn.size] forState:UIControlStateDisabled];
        [self addSubview:nextStepBtn];
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


@end
