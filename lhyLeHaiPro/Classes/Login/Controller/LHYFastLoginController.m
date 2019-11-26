//
//  LHYFastLoginController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYFastLoginController.h"
#import "LHYFastLoginView.h"

@interface LHYFastLoginController ()

@end

@implementation LHYFastLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快速登录";
    self.view.backgroundColor = LHY_Hex_Color(@"eeeeee");
    [self lhy_creatSubViews];
}

-(void)lhy_creatSubViews{
    LHYFastLoginView *fastLoginView = [[LHYFastLoginView alloc] initWithFrame:CGRectMake(0, kTopHeight+20*kScaleW, kScreenWidth, kScreenHeight-20*kScaleW-kTopHeight)];
//    fastLoginView.delegate = self;
    [self.view addSubview:fastLoginView];
}

@end
