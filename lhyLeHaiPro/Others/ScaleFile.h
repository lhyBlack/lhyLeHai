
//
//  ScaleFilr.h
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/25.
//  Copyright © 2019 haha. All rights reserved.
//

#ifndef ScaleFilr_h
#define ScaleFilr_h

// 屏幕宽高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//比例系数
#define kScaleH kScreenHeight/667.0
#define kScaleW kScreenWidth/375.0

#define KScaleH(f) f*kScreenHeight/667.0
#define KScaleW(f) f*kScreenWidth/375.0

//NavBar TabBar StatusBar 的高度问题
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavBarHeight self.navigationController.navigationBar.frame.size.height
#define kTabBarHeight self.tabBarController.tabBar.frame.size.height
#define kTopHeight (kStatusBarHeight+kNavBarHeight)



#define LHYFont(a) [UIFont systemFontOfSize:a]



//宏定义单利的定义
#define CMYH_SINGLETON_DEF(_type_) +(_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));\


//宏定义单利的实现
#define CMYH_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}


#endif /* ScaleFilr_h */
