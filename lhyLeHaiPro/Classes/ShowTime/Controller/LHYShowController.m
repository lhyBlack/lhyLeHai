//
//  LHYShowController.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#import "LHYShowController.h"
#import "LHYShowMainView.h"

@interface LHYShowController ()

@property(nonatomic,weak)LHYShowMainView *showMainView;

@end

@implementation LHYShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatMainView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)creatMainView{
    
    LHYShowMainView *showMainView = [[LHYShowMainView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
    [self.view addSubview:showMainView];
    
}
@end
