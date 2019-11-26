//
//  AppDelegate.h
//  lhyLeHaiPro
//
//  Created by haha on 2019/11/22.
//  Copyright © 2019 haha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

