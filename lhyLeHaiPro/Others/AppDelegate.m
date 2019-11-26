//
//  AppDelegate.m
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/22.
//  Copyright © 2019 haha. All rights reserved.
//

#import "AppDelegate.h"
#import "LHYTabbarController.h"
#import "LHYGuideController.h"
#import "LHYNavController.h"
#import "LHYLoginController.h"
// 键盘管理
#import "IQKeyboardManager.h"
//注册微信
#import "WXApi.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册微信appIDappID
    [WXApi registerApp:WXAppID universalLink:@"https://help.wechat.com/app/"];
    
    
    // 键盘管理
    [self lhy_setKeyboardManager];
    
    //设置window的frame
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 设置根控制器
    self.window.rootViewController = [self pickViewController];
    
    LHYLoginController *login = [[LHYLoginController alloc] init];
    LHYNavController *nav = [[LHYNavController alloc] initWithRootViewController:login];
     self.window.rootViewController = nav;
    //显示出来
    [self.window makeKeyAndVisible];
    return YES;
}

// 设置代理，onResp方法会从微信回来时调用
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp{
    if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *resp2 = (SendAuthResp *)resp;
        [KNotificationCenter postNotificationName:@"wxLogin" object:resp2];
    }else{
        NSLog(@"授权失败");
    }
}


// 选择应该显示的控制器
- (UIViewController*)pickViewController{
    // 判断 沙盒和当前的版本号是否一致
    if ([[self loadSavedAppVersion] isEqualToString:[self loadAppVersion]]) {
        
        //创建tabBar
        LHYTabbarController* tab = [[LHYTabbarController alloc] init];
        
        return tab;
    }
    else {
        //   不一致,显示新特性页面(引导页)
        LHYGuideController* guide = [[LHYGuideController alloc] init];
        return guide;
    }
}

// 获取沙盒中保存的版本号
- (NSString*)loadSavedAppVersion{
    // 获取ud对象
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"appVersion"];
}

// 把当前的版本号保存到沙盒当中
- (void)saveAppVersion{
    // 获取info.plist
    NSDictionary* dict = [NSBundle mainBundle].infoDictionary;
    // 获取ud对象
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dict[@"CFBundleShortVersionString"] forKey:@"appVersion"];
}

// 获取"当前"的版本号
- (NSString*)loadAppVersion{
    // 获取info.plist
    NSDictionary* dict = [NSBundle mainBundle].infoDictionary;
    NSLog(@"%@", dict[@"CFBundleShortVersionString"]);
    return dict[@"CFBundleShortVersionString"];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark -- 键盘管理
- (void)lhy_setKeyboardManager {
    //配置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"lhyLeHaiPro"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
