//
//  TabBarController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "TabBarController.h"
#import "HomeFirstController.h"
#import "CollectionVC.h"
#import "CategoriesViewController.h"
#import "CartViewController.h"
#import "AccountViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadControllers];
    
}

-(void)loadControllers{
    HomeFirstController *home = [HomeFirstController new];
    YDLNavigationViewController *homeNavi = [[YDLNavigationViewController alloc]initWithRootViewController:home];
    CollectionVC *collection = [CollectionVC new];
    YDLNavigationViewController *collectionNavi = [[YDLNavigationViewController alloc]initWithRootViewController:collection];
    CategoriesViewController *categories = [CategoriesViewController new];
    YDLNavigationViewController *categoriesNavi = [[YDLNavigationViewController alloc]initWithRootViewController:categories];
    CartViewController *cart = [CartViewController new];
    YDLNavigationViewController *cartNavi = [[YDLNavigationViewController alloc]initWithRootViewController:cart];
    AccountViewController *account = [AccountViewController new];
    YDLNavigationViewController *accountNavi = [[YDLNavigationViewController alloc]initWithRootViewController:account];
    
    self.viewControllers = @[homeNavi,collectionNavi,categoriesNavi,cartNavi,accountNavi];
    homeNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"tab_ic_home_pre"] selectedImage:nil];
    collectionNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Collection" image:[UIImage imageNamed:@"tab_ic_collection_nor"] selectedImage:nil];
    categoriesNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Categories" image:[UIImage imageNamed:@"tab_ic_categories_nor"] selectedImage:nil];
    cartNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Cart" image:[UIImage imageNamed:@"tab_ic_cart_nor"] selectedImage:nil];
    accountNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Account" image:[UIImage imageNamed:@"tab_ic_account_nor"] selectedImage:nil];
    
    
//    homeNavi.tabBarItem.imageInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
//    collectionNavi.tabBarItem.badgeValue = @"2";
    self.tabBar.tintColor = Color(@"#F6AA00");
//    self.tabBar.backgroundImage = [[UIImage alloc]init];
    
}

@end
