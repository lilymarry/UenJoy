//
//  NickNameViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "PasswordViewController.h"
#import "ModifyInfoModel.h"
@interface PasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *oldPasswordTF;
@property (nonatomic, strong) UITextField *NewPasswordTF;
@property (nonatomic, strong) UITextField *NewPasswordAgainTF;
@property (nonatomic, strong) UITextField *tempTF;
@property (nonatomic, strong) UIButton *oldBtn;
@property (nonatomic, strong) UIButton *NewBtn;
@property (nonatomic, strong) UIButton *NewBtnAgin;
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"#f5f5f5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Change Password";
    
    UITextField *oldPasswordTF = [UITextField new];
    self.oldPasswordTF = oldPasswordTF;
    oldPasswordTF.backgroundColor = Color(@"#ffffff");
    oldPasswordTF.font =font(14);

    oldPasswordTF.delegate = self;
    oldPasswordTF.secureTextEntry = YES;
    oldPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:oldPasswordTF];
    [oldPasswordTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(10+NaviBarAndStatusBarHeight);
        make.height.offset(50);
        make.width.offset(ScreenWidth-40);
    }];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
    leftLabel.text = @"Old Password";
    leftLabel.font = font(14);
    leftLabel.textColor = Color(@"#999999");
    [leftView addSubview:leftLabel];
//    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make){
//        make.center.equalTo(leftView);
//    }];
    oldPasswordTF.leftView = leftView;
    
    UIButton *oldImage = [UIButton new];
    self.oldBtn = oldImage;
    [oldImage setBackgroundColor:[UIColor whiteColor]];
    [oldImage setImage:[UIImage imageNamed:@"password-eye-close"] forState:0];
    [oldImage addTarget:self action:@selector(clickOldEye) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oldImage];
    [oldImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(oldPasswordTF);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.offset(50);
        make.width.offset(40);
    }];
    
//
    UITextField *NewPasswordTF = [UITextField new];
    self.NewPasswordTF = NewPasswordTF;
    NewPasswordTF.backgroundColor = Color(@"#ffffff");
    NewPasswordTF.font =font(14);
    NewPasswordTF.delegate = self;
    NewPasswordTF.secureTextEntry = YES;
//    NewPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    NewPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:NewPasswordTF];
    [NewPasswordTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.oldPasswordTF.mas_bottom).offset(1);
        make.height.offset(50);
        make.width.offset(ScreenWidth-40);
    }];
    UIView *leftView111 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 115, 50)];
    UILabel *leftLabel111 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 115, 50)];
    leftLabel111.text = @"New Password";
    leftLabel111.font = font(14);
    leftLabel111.textColor = Color(@"#999999");
    [leftView111 addSubview:leftLabel111];
//    [leftLabel111 mas_makeConstraints:^(MASConstraintMaker *make){
//        make.center.equalTo(leftView111);
//    }];
    NewPasswordTF.leftView = leftView111;
    
    UIButton *NewBtn = [UIButton new];
    self.NewBtn = NewBtn;
    [NewBtn setBackgroundColor:[UIColor whiteColor]];
    [NewBtn setImage:[UIImage imageNamed:@"password-eye-close"] forState:0];
    [NewBtn addTarget:self action:@selector(clickNewEye) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NewBtn];
    [NewBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(NewPasswordTF);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.offset(50);
        make.width.offset(40);
    }];
    
    
    UITextField *NewPasswordAgainTF = [UITextField new];
    self.NewPasswordAgainTF = NewPasswordAgainTF;
    NewPasswordAgainTF.backgroundColor = Color(@"#ffffff");
    NewPasswordAgainTF.font =font(14);
    NewPasswordAgainTF.delegate = self;
    NewPasswordAgainTF.secureTextEntry = YES;
//    NewPasswordAgainTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    NewPasswordAgainTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:NewPasswordAgainTF];
    [NewPasswordAgainTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(NewPasswordTF.mas_bottom).offset(1);
        make.height.offset(50);
        make.width.offset(ScreenWidth-40);
    }];
    UIView *leftView222 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 50)];
    UILabel *leftLabel222 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 50)];
    leftLabel222.text = @"Confirm Password";
    leftLabel222.font = font(14);
    leftLabel222.textColor = Color(@"#999999");
    [leftView222 addSubview:leftLabel222];
//    [leftLabel222 mas_makeConstraints:^(MASConstraintMaker *make){
//        make.center.equalTo(leftView222);
//    }];
    NewPasswordAgainTF.leftView = leftView222;
    
    UIButton *NewBtnAgin = [UIButton new];
    self.NewBtnAgin = NewBtnAgin;
    [NewBtnAgin setBackgroundColor:[UIColor whiteColor]];
    [NewBtnAgin setImage:[UIImage imageNamed:@"password-eye-close"] forState:0];
    [NewBtnAgin addTarget:self action:@selector(clickNewEteAgain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NewBtnAgin];
    [NewBtnAgin mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(NewPasswordAgainTF);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.offset(50);
        make.width.offset(40);
    }];
    
    
    UIButton *SignBtn = [UIButton new];
    [SignBtn setBackgroundColor:Color(@"#F6AA00")];
    [SignBtn setTitle:@"Save" forState:0];
    SignBtn.titleLabel.font =font(15);
    SignBtn.layer.masksToBounds = YES;
    SignBtn.layer.cornerRadius = 2;
    [SignBtn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignBtn];
    [SignBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(13);
        make.right.offset(-13);
        make.top.equalTo(NewPasswordAgainTF.mas_bottom).offset(50);
        make.height.offset(50);
    }];
    
}

- (void)clickSave{
    
    if (self.oldPasswordTF.text.length==0) {
        [MBProgressHUD showSuccess:@"Old password cannot be empty" toView:self.view];
        return;
    }
    
  
    
    if (self.NewPasswordTF.text.length==0) {
        [MBProgressHUD showSuccess:@"New password cannot be empty" toView:self.view];
        return;
    }
    if (self.NewPasswordAgainTF.text.length==0) {
        [MBProgressHUD showSuccess:@"Confirm password cannot be empty" toView:self.view];
        return;
    }
    if (![self.NewPasswordTF.text isEqualToString:self.NewPasswordAgainTF.text]) {
         [MBProgressHUD showSuccess:@"Confirm password is different from new password" toView:self.view];
        return;
    }
    ModifyInfoModel *model=[[ModifyInfoModel alloc]init];
    model.current_password=self.oldPasswordTF.text;
    model.password=self.NewPasswordTF.text;
    model.confirmation=self.NewPasswordAgainTF.text;
    model.type=@"savepwd";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model modifyInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            self.passwordBlock();
            [self.navigationController popViewControllerAnimated:YES];
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
    [self.tempTF resignFirstResponder];
}

#pragma mark TextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tempTF = textField;
    return YES;
}

- (void)clickOldEye{
    if (self.oldPasswordTF.secureTextEntry){
        self.oldPasswordTF.secureTextEntry = NO;
        [self.oldBtn setImage:[UIImage imageNamed:@"password-eye-normal"] forState:0];
    }else{
        self.oldPasswordTF.secureTextEntry = YES;
        [self.oldBtn setImage:[UIImage imageNamed:@"password-eye-close"] forState:0];
    }
}

- (void)clickNewEye{
    if (self.NewPasswordTF.secureTextEntry){
        self.NewPasswordTF.secureTextEntry = NO;
        [self.NewBtn setImage:[UIImage imageNamed:@"password-eye-normal"] forState:0];
    }else{
        self.NewPasswordTF.secureTextEntry = YES;
        [self.NewBtn setImage:[UIImage imageNamed:@"password-eye-close"] forState:0];
    }
}

- (void)clickNewEteAgain{
    if (self.NewPasswordAgainTF.secureTextEntry){
        self.NewPasswordAgainTF.secureTextEntry = NO;
        [self.NewBtnAgin setImage:[UIImage imageNamed:@"password-eye-normal"] forState:0];
    }else{
        self.NewPasswordAgainTF.secureTextEntry = YES;
        [self.NewBtnAgin setImage:[UIImage imageNamed:@"password-eye-close"] forState:0];
    }
}





@end
