//
//  NickNameViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "NickNameViewController.h"
#import "ModifyInfoModel.h"

@interface NickNameViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nickNameTF;
@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"#f5f5f5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Change Nickname";
    
    UITextField *nickNameTF = [UITextField new];
    self.nickNameTF = nickNameTF;
   nickNameTF.backgroundColor = Color(@"#ffffff");

    nickNameTF.font =font(14);
    nickNameTF.delegate = self;
   nickNameTF.text=_name;
 
    nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
     nickNameTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:nickNameTF];
    
    [nickNameTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(10+NaviBarAndStatusBarHeight);
        make.height.offset(50);
        make.width.offset(ScreenWidth);
    }];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 95, 50)];
    UILabel *leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 95, 50)];
    leftLabel.text = @"Nickname";
    leftLabel.font = font(14);
    leftLabel.textColor = Color(@"#999999");
    [leftView addSubview:leftLabel];
    nickNameTF.leftView =leftView;
    
    UIButton *SignBtn = [UIButton new];
    [SignBtn setBackgroundColor:Color(@"#F6AA00")];
    [SignBtn setTitle:@"Save" forState:0];
    SignBtn.titleLabel.font = font(15);
    SignBtn.layer.masksToBounds = YES;
    SignBtn.layer.cornerRadius = 2;
    [SignBtn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignBtn];
    [SignBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(13);
        make.right.offset(-13);
        make.top.equalTo(nickNameTF.mas_bottom).offset(50);
        make.height.offset(50);
    }];

}

- (void)clickSave{
    if (self.nickNameTF.text.length==0) {
         [MBProgressHUD showSuccess:@"Nickname cannot be empty" toView:self.view];
        return;
    }
    ModifyInfoModel *model=[[ModifyInfoModel alloc]init];
    model.nickname=self.nickNameTF.text;
    model.type=@"savename";
     [MBProgressHUD showMessage:nil toView:self.view];
    [model modifyInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            [self loginIn];
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nickNameTF resignFirstResponder];
}
- (void)loginIn{
    
    
    LoginModel *model=[[LoginModel alloc]init];
    
    
    model.password=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    
    model.email=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [model LoginModelSuccessBlock:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            LoginModel *login=(LoginModel *)data;
            [model save:login.data];
            
            
         //   [[NSUserDefaults standardUserDefaults] setObject:login.data.uinfo.access_token forKey:@"access_token"];
            
        //    [[NSUserDefaults standardUserDefaults] setObject:login.data.uuid forKey:@"userid"];
            
         //   [[NSUserDefaults standardUserDefaults] synchronize];
            self.nameBlock();
            [self.navigationController popViewControllerAnimated:YES];
        
        }
        else
        {
            [MBProgressHUD showSuccess:message toView:self.view];
            
        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
