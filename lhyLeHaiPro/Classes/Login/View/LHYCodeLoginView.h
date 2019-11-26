//
//  LHYCodeLoginView.h
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LHYCodeLoginViewDelegate <NSObject>
//找回密码
-(void)lhy_backMiMaBtnClickDelegate:(UIButton *)sender;
//短信验证码登录
-(void)lhy_codeVLoginClickDelegate:(UIButton *)senedr;
//三方登录按钮点击
-(void)lhy_loginThreeBtnDelegate:(UIButton *)sender;
//注册按钮点击
-(void)lhy_registBtnClickDelegate:(UIButton *)sender;

@end

@interface LHYCodeLoginView : LHYBaseView

@property(nonatomic,weak) id<LHYCodeLoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
