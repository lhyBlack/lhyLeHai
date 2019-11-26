//
//  LHYFindMiMaController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYFindMiMaController.h"
#import "LHYFindMiMaView.h"

@interface LHYFindMiMaController ()

@end

@implementation LHYFindMiMaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = LHY_Hex_Color(@"eeeeee");
    [self lhy_creatSubViews];
}

-(void)lhy_creatSubViews{
    LHYFindMiMaView *findMiMaView = [[LHYFindMiMaView alloc] initWithFrame:CGRectMake(0, kTopHeight+20*kScaleW, kScreenWidth, kScreenHeight-20*kScaleW-kTopHeight)];
    //    fastLoginView.delegate = self;
    [self.view addSubview:findMiMaView];
}

@end
