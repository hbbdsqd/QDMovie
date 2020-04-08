//
//  AppDelegate.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window; 
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic,strong) QDTabBarViewController *tabbarVC;

/**
 判断加载引导图还是主要tabbar
 */
- (void)loadLaunchVC;

- (void)saveContext;
@end

