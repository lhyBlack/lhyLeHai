//
//  LHYRegistController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYRegistController.h"
#import "LHYRegistView.h"

@interface LHYRegistController ()

@end

@implementation LHYRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = LHY_Hex_Color(@"eeeeee");
    [self lhy_creatSubViews];
}

-(void)lhy_creatSubViews{
    LHYRegistView *registView = [[LHYRegistView alloc] initWithFrame:CGRectMake(0, kTopHeight+20*kScaleW, kScreenWidth, kScreenHeight-20*kScaleW-kTopHeight)];
    
    [self.view addSubview:registView];
}

@end
