//
//  LHYLoginView.h
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LHYLoginViewDelegate <NSObject>
//三方登录按钮点击
-(void)lhy_loginThreeBtnDelegate:(UIButton *)sender;
//注册登录按钮点击
-(void)lhy_registLoginBtnClickDelegate:(UIButton *)sender;
//协议按钮点击
-(void)lhy_tipsLabelClickDelegate;

@end

@interface LHYLoginView : LHYBaseView

@property(nonatomic,weak) id<LHYLoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
