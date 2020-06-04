//
//  ForgetPasswordViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tempTF;
@property (nonatomic, strong) UITextField *emailTF;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavi];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMainView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tempTF resignFirstResponder];
    self.tempTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
}
#pragma mark 创建视图
- (void)setNavi{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)setMainView{
    UIImageView *naviImageView = [UIImageView new];
    naviImageView.contentMode = UIViewContentModeScaleAspectFit;
    naviImageView.image = [UIImage imageNamed:@"ic_logo"];
    [self.view addSubview:naviImageView];
    [naviImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(80);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *tishi = [UILabel new];
    tishi.textColor = Color(@"333333");
    tishi.font = font(12);
    tishi.text = @"Let’s reset your password";
    [self.view addSubview:tishi];
    [tishi mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(naviImageView.mas_bottom).offset(60);
    }];
    
    UITextField *emailTF = [UITextField new];
    self.emailTF = emailTF;
    emailTF.backgroundColor = Color(@"#FAFAFA");
    emailTF.font = font(14);
    emailTF.placeholder = @"Email";
    emailTF.layer.masksToBounds = YES;
    emailTF.layer.cornerRadius = 2;
    emailTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    emailTF.layer.borderWidth = 1;
    emailTF.delegate = self;
    emailTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTF.leftViewMode = UITextFieldViewModeAlways;
    emailTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.view addSubview:emailTF];
    [emailTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.right.offset(-47);
        make.top.equalTo(tishi.mas_bottom).offset(40);
        make.height.offset(38);
    }];
    
    UIButton *SignBtn = [UIButton new];
    [SignBtn setBackgroundColor:Color(@"#F6AA00")];
    [SignBtn setTitle:@"Reset Password" forState:0];
    SignBtn.titleLabel.font =  [UIFont boldSystemFontOfSize:12];
    SignBtn.layer.masksToBounds = YES;
    SignBtn.layer.cornerRadius = 2;
    [self.view addSubview:SignBtn];
    [SignBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(emailTF.mas_bottom).offset(10);
        make.height.offset(38);
        make.right.offset(-47);
    }];
}


#pragma mark TextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [Color(@"#F6AA00") CGColor];
    self.tempTF = textField;
    return YES;
}

@end
