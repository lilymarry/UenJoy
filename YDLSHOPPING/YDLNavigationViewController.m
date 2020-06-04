//
//  YDLNavigationViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "YDLNavigationViewController.h"
#import "PaySuccess.h"
@interface YDLNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YDLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame=CGRectMake(0, 0, 50, 40);
     
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
        [backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTintColor:[UIColor whiteColor]];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 10, 18)];
        imageView.image=[UIImage imageNamed:@"btn_return"];
               [backBtn addSubview:imageView];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)close
{
    BOOL isExit=NO;
            for(UIViewController *temp in self.viewControllers) {
                 if([temp isKindOfClass:[PaySuccess class]]){
                     isExit=YES;
                      [self popToRootViewControllerAnimated:YES];
                     break;
                 }
         }
       if (isExit==NO) {
            [self popViewControllerAnimated:YES];
           
       }
    
  
}

@end
