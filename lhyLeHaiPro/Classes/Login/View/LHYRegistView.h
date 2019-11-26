//
//  LHYRegistView.h
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LHYRegistViewDelegate <NSObject>

//协议按钮点击
-(void)lhy_tipsLabelClickDelegate;

@end

@interface LHYRegistView : LHYBaseView

@property(nonatomic,weak) id<LHYRegistViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
