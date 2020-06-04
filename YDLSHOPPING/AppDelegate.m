//
//  AppDelegate.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarController.h"
//引导页
#import "SNewFeaturesVC.h"
#import <PayPalMobile.h>
#import <Bugly/Bugly.h>

#define PAYPAL_SANDBOX  @"AcQxuBDdBh3jNaYTnB79coxVr3wihIQVkJzI1stUX4V2yJByccNTgKNu1zeO"

#define PAYPAL_PRODUCTION @"AcrNxxV_v87UOZze37E8Id3Ly8ZVepoOiIocD0AYuxLLXT3T02dA-g-8lQq7cjRbEJH-ZQ_xmXHb9R_A"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction:PAYPAL_PRODUCTION,PayPalEnvironmentSandbox:PAYPAL_SANDBOX}];
    
      [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
  
    [Bugly startWithAppId:@"dd8c374dd9"];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
  
    //监听版本
   [self version];
  
    
[self.window makeKeyWindow];
    return YES;
}
- (void)version {
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    
    if ([version isEqualToString:saveVersion]){

         TabBarController *tabbar = [TabBarController new];
         self.window.rootViewController = tabbar;

    } else {
        // 版本号不一样：第一次使用新版本
        // 将新版本号写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        /**
         *搜索数组
         */
        NSArray * keywords_arr = [[NSArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:@"keywords_arr"];
        
        
        SNewFeaturesVC * newFeature = [[SNewFeaturesVC alloc] init];
        self.window.rootViewController = newFeature;
  }
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
}


@end
