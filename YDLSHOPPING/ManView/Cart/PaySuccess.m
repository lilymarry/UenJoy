//
//  PaySuccess.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "PaySuccess.h"

@interface PaySuccess ()
@property (weak, nonatomic) IBOutlet UILabel *tltleLab;

@end

@implementation PaySuccess

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Completed";
    _tltleLab.text=[NSString stringWithFormat:@"Your order #%@ has been placed",_order_id];
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    UIView *view= self.navigationItem.leftBarButtonItem.customView;
    
    UIButton *but=(UIButton *)view;
    
    
    if ([but isKindOfClass:[UIButton class]]) {
        [but addTarget:self action:@selector(butpress) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
- (void)butpress{
   
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
