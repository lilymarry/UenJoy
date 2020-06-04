//
//  LoginViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "LoginModel.h"
#import "CreateAccountModel.h"
@interface LoginViewController ()<UITextFieldDelegate>
//@property (nonatomic, assign) BOOL if_sign;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextField *emailTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UILabel *confirmPasswordlabel;
@property (nonatomic, strong) UITextField *confirmPasswordTF;
@property (nonatomic, strong) UILabel *InvitationCodeLabel;
@property (nonatomic, strong) UITextField *InvitationCodeTF;
@property (nonatomic, strong) UITextField *tempTF;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *SignBtn;
//@property (nonatomic, strong) UIView *selecedView;
@property (nonatomic, strong) UIButton *selecedBtn;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *forgetLabel;

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self setNavi];
    [self setMainView];
    
    
    self.emailTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    self.passwordTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tempTF resignFirstResponder];
    self.emailLabel.textColor = Color(@"#333333");
    self.passwordLabel.textColor = Color(@"#333333");
    self.confirmPasswordlabel.textColor = Color(@"#333333");
    self.InvitationCodeLabel.textColor = Color(@"#333333");
}
#pragma  mark 创建视图
- (void)setNavi{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setHidden:NO];
    UIButton *btnL = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnL addTarget:self action:@selector(colose) forControlEvents:UIControlEventTouchUpInside];
    [btnL setImage:[UIImage imageNamed:@"btn_closed" ] forState:UIControlStateNormal];
    UIBarButtonItem *backItemL = [[UIBarButtonItem alloc] initWithCustomView:btnL];
    self.navigationItem.leftBarButtonItem = backItemL;
}

- (void)setMainView{
    
    UIScrollView *mainScrollView = [UIScrollView new];
    mainScrollView.showsVerticalScrollIndicator = NO;
    self.scrollView=mainScrollView;
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(NaviBarAndStatusBarHeight);
        make.height.offset(ScreenHeight-NaviBarAndStatusBarHeight);
        make.width.offset(ScreenWidth);
        make.centerX.equalTo(self.view);
    }];
    mainScrollView.contentSize = CGSizeMake(0, ScreenHeight+40);
    
    
    UIImageView *naviImageView = [UIImageView new];
    naviImageView.contentMode = UIViewContentModeScaleAspectFit;
    naviImageView.image = [UIImage imageNamed:@"ic_logo"];
    [ self.scrollView addSubview:naviImageView];
    [naviImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(0);
        make.centerX.equalTo(mainScrollView);
    }];
    
    UILabel *sign = [UILabel new];
    sign.textColor = Color(@"#1A1A1A");
    sign.font = font(14);
    sign.text = @"Sign in";
    [self.scrollView addSubview:sign];
    [sign mas_makeConstraints:^(MASConstraintMaker *make){
      make.centerX.equalTo(mainScrollView).offset(-40);
      make.top.equalTo(naviImageView.mas_bottom).offset(30);
    }];
    sign.userInteractionEnabled = YES;
    UITapGestureRecognizer *signGes = [[UITapGestureRecognizer
                                 alloc]initWithTarget:self action:@selector(signIn)];
    [sign addGestureRecognizer:signGes];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = Color(@"#F6AA00");
    self.line1 = line1;
    self.line1.hidden = NO;
    [self.scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(sign.mas_bottom).offset(10);
        make.height.offset(2);
        make.width.offset(37);
        make.centerX.equalTo(sign);
    }];
    
    
    UILabel *account = [UILabel new];
    account.textColor = Color(@"#1A1A1A");
    account.font= font(14);
    account.text = @"Create account";
    [self.scrollView addSubview:account];
    [account mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(naviImageView.mas_bottom).offset(30);
       make.left.equalTo(sign.mas_right).offset(40);
    }];
    account.userInteractionEnabled = YES;
    UITapGestureRecognizer *accountGes = [[UITapGestureRecognizer
                                 alloc]initWithTarget:self action:@selector(creatAccount)];
    [account addGestureRecognizer:accountGes];
  
    UIView *line2 = [UIView new];
    line2.backgroundColor = Color(@"#F6AA00");
    self.line2 = line2;
    self.line2.hidden = YES;
    [self.scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(account.mas_bottom).offset(10);
        make.height.offset(2);
        make.width.offset(37);
        make.centerX.equalTo(account);
    }];
  
    UILabel *emailLabel = [UILabel new];
    self.emailLabel = emailLabel;
    emailLabel.textColor = Color(@"#333333");
 
    emailLabel.font= font(10);
    emailLabel.text = @"Email";
    [self.scrollView addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(line1).offset(28);
    }];
    
    UITextField *emailTF = [UITextField new];
    self.emailTF = emailTF;
    emailTF.backgroundColor = Color(@"#FAFAFA");
    emailTF.font= font(14);;
    emailTF.tag = 1;
    emailTF.layer.masksToBounds = YES;
    emailTF.layer.cornerRadius = 2;
    emailTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    emailTF.layer.borderWidth = 1;
    emailTF.delegate = self;
    emailTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTF.leftViewMode = UITextFieldViewModeAlways;
    emailTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.scrollView addSubview:emailTF];
    [emailTF mas_makeConstraints:^(MASConstraintMaker *make){
         make.left.offset(47);
          make.width.offset(ScreenWidth-47*2);

        make.top.equalTo(emailLabel.mas_bottom).offset(5);
        make.height.offset(38);
    }];
    
    UILabel *PasswordLabel = [UILabel new];
    self.passwordLabel = PasswordLabel;
    PasswordLabel.textColor = Color(@"#333333");
    PasswordLabel.font = font(10);
    PasswordLabel.text = @"Password";
    [self.scrollView addSubview:PasswordLabel];
    [PasswordLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(emailTF.mas_bottom).offset(10);
    }];
    
    UITextField *PasswordTF = [UITextField new];
    self.passwordTF = PasswordTF;
    PasswordTF.backgroundColor = Color(@"#FAFAFA");
   PasswordTF.font = font(14);
    PasswordTF.tag = 2;
    PasswordTF.layer.masksToBounds = YES;
    PasswordTF.layer.cornerRadius = 2;
    PasswordTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    PasswordTF.layer.borderWidth = 1;
    PasswordTF.secureTextEntry = YES;
    PasswordTF.delegate = self;
    PasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    PasswordTF.leftViewMode = UITextFieldViewModeAlways;
    PasswordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.scrollView addSubview:PasswordTF];
    [PasswordTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.width.offset(ScreenWidth-47*2);
        make.top.equalTo(PasswordLabel.mas_bottom).offset(5);
        make.height.offset(38);
    }];
  
    UILabel *ConfirmPasswordLabel = [UILabel new];
    self.confirmPasswordlabel = ConfirmPasswordLabel;
    ConfirmPasswordLabel.hidden = YES;
    ConfirmPasswordLabel.textColor = Color(@"#333333");
     ConfirmPasswordLabel.font = font(10);
    ConfirmPasswordLabel.text = @"Confirm Password";
    [self.scrollView addSubview:ConfirmPasswordLabel];
    [ConfirmPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(PasswordTF.mas_bottom).offset(10);
    }];
    
    UITextField *confirmPasswordTF = [UITextField new];
    self.confirmPasswordTF = confirmPasswordTF;
    confirmPasswordTF.hidden = YES;
    confirmPasswordTF.backgroundColor = Color(@"#FAFAFA");
    confirmPasswordTF.font = font(14);
    confirmPasswordTF.tag = 3;
    confirmPasswordTF.layer.masksToBounds = YES;
    confirmPasswordTF.layer.cornerRadius = 2;
    confirmPasswordTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    confirmPasswordTF.layer.borderWidth = 1;
    confirmPasswordTF.secureTextEntry = YES;
    confirmPasswordTF.delegate = self;
    confirmPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    confirmPasswordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.scrollView addSubview:confirmPasswordTF];
    [confirmPasswordTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.width.offset(ScreenWidth-47*2);
        make.top.equalTo(ConfirmPasswordLabel.mas_bottom).offset(5);
        make.height.offset(38);
    }];
    
    UILabel *InvitationCodeLabel = [UILabel new];
    self.InvitationCodeLabel = InvitationCodeLabel;
    InvitationCodeLabel.textColor = Color(@"#333333");
    InvitationCodeLabel.font = font(10);
     
    
    InvitationCodeLabel.hidden = YES;
    InvitationCodeLabel.text = @"Invitation code (Optional)";
    [self.scrollView addSubview:InvitationCodeLabel];
    [InvitationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(confirmPasswordTF.mas_bottom).offset(10);
    }];
    
    UITextField *InvitationCodeTF = [UITextField new];
    self.InvitationCodeTF = InvitationCodeTF;
    InvitationCodeTF.backgroundColor = Color(@"#FAFAFA");
    InvitationCodeTF.font = font(14);
    InvitationCodeTF.tag = 4;
    InvitationCodeTF.hidden = YES;
    InvitationCodeTF.layer.masksToBounds = YES;
    InvitationCodeTF.layer.cornerRadius = 2;
    InvitationCodeTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    InvitationCodeTF.layer.borderWidth = 1;
    InvitationCodeTF.delegate = self;
    InvitationCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    InvitationCodeTF.leftViewMode = UITextFieldViewModeAlways;
    InvitationCodeTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.scrollView addSubview:InvitationCodeTF];
    [InvitationCodeTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.width.offset(ScreenWidth-47*2);
        make.top.equalTo(InvitationCodeLabel.mas_bottom).offset(5);
        make.height.offset(38);
    }];

    self.selecedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selecedBtn.hidden = YES;
    self.selecedBtn.backgroundColor = [UIColor clearColor];
    [self.selecedBtn setImage:[UIImage imageNamed:@"btn-choose-no"] forState:UIControlStateNormal];
    [self.selecedBtn setImage:[UIImage imageNamed:@"btn-choose"] forState:UIControlStateSelected];
    [self.selecedBtn addTarget:self action:@selector(selectPress) forControlEvents:UIControlEventTouchUpInside];
    self.selecedBtn.selected=NO;
    [self.scrollView addSubview:self.selecedBtn];
    [self.selecedBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
     make.top.equalTo(InvitationCodeTF.mas_bottom).offset(10);
        make.height.offset(12);
        make.width.offset(12);
    }];
    
    UILabel *selectedLabel = [UILabel new];
    self.selectedLabel = selectedLabel;
    selectedLabel.textColor = Color(@"#333333");
    selectedLabel.hidden = YES;
    selectedLabel.font = font(10);
    
    selectedLabel.text = @"Sign up for our emails for secret sales & sneak peeks.";
    [self.scrollView addSubview:selectedLabel];
    [selectedLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.selecedBtn.mas_right).offset(10);
        make.centerY.equalTo(self.selecedBtn);
        make.width.offset(ScreenWidth-47*2);
    }];
    
    UIButton *SignBtn = [UIButton new];
    self.SignBtn = SignBtn;
    
    [SignBtn setBackgroundColor:Color(@"#F6AA00")];
    
    [SignBtn setTitle:@"Sign in" forState:0];
    SignBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    SignBtn.layer.masksToBounds = YES;
    SignBtn.layer.cornerRadius = 2;
    [SignBtn addTarget:self action:@selector(loginIn) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:SignBtn];
    [SignBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(PasswordTF.mas_bottom).offset(5);
        make.height.offset(38);
        make.width.offset(ScreenWidth-47*2);
    }];
    
    UILabel *forgetLabel = [UILabel new];
    self.forgetLabel = forgetLabel;
    forgetLabel.textColor = Color(@"#333333");
    forgetLabel.font =font(10);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Forgot password" attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    forgetLabel.attributedText = attrStr;
    [self.scrollView addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(SignBtn.mas_bottom).offset(7);
    }];
    UITapGestureRecognizer *forgotTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgotBtn)];
    forgetLabel.userInteractionEnabled = YES;
    [forgetLabel addGestureRecognizer:forgotTap];
    
    UIButton *SignFaceBookBtn = [UIButton new];
    [SignFaceBookBtn setBackgroundColor:Color(@"#3B5998")];
    [SignFaceBookBtn setTitle:@"Sign in with Facebook" forState:0];
    [SignFaceBookBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [SignFaceBookBtn setImage:[UIImage imageNamed:@"login_ic_facebook"] forState:0];
    SignFaceBookBtn.titleLabel.font =  [UIFont boldSystemFontOfSize:12];
    SignFaceBookBtn.layer.masksToBounds = YES;
    SignFaceBookBtn.layer.cornerRadius = 2;
    [self.scrollView addSubview:SignFaceBookBtn];
    [SignFaceBookBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(47);
        make.top.equalTo(forgetLabel.mas_bottom).offset(15);
        make.height.offset(38);
          make.width.offset(ScreenWidth-47*2);
    }];
    
    UILabel *explainLabel = [UILabel new];
    explainLabel.textColor = Color(@"#333333");
    explainLabel.font = font(10);
    explainLabel.numberOfLines = 0;
    
    
    explainLabel.text = @"By clicking ‘Sign In’ or Facebook you agree to the Terms of Use and Privacy Policy";
    explainLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:explainLabel];
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.width.offset(219*AUTOLAYOUT_WIDTH_SCALE);
        make.top.equalTo(SignFaceBookBtn.mas_bottom).offset(30);
    }];
   
    
}



#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [Color(@"#F6AA00") CGColor];
    self.tempTF = textField;
    self.emailLabel.textColor = textField.tag == 1 ? Color(@"#F6AA00") : Color(@"#333333");
    self.passwordLabel.textColor = textField.tag == 2 ? Color(@"#F6AA00") : Color(@"#333333");
    self.confirmPasswordlabel.textColor = textField.tag == 3 ? Color(@"#F6AA00") : Color(@"#333333");
    self.InvitationCodeLabel.textColor = textField.tag == 4 ? Color(@"#F6AA00") : Color(@"#333333");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [Color(@"#DDDDDD") CGColor];
}

#pragma mark 点击事件
-(void)colose{
    if ([self.isPresent isEqualToString:@"1"]) {
     
                   [self dismissViewControllerAnimated:YES completion:nil];
             }
             else
             {
                 TabBarController *tabbar = [TabBarController new];
                       self.view.window.rootViewController = tabbar;
             }
}
- (void)signIn{
    self.line1.hidden = NO;
    self.line2.hidden = YES;
    
    self.tempTF.text = @"";
    
    self.confirmPasswordlabel.hidden = YES;
    self.confirmPasswordTF.hidden = YES;
    self.InvitationCodeTF.hidden = YES;
    self.InvitationCodeLabel.hidden = YES;
    self.selecedBtn.hidden = YES;
    self.selectedLabel.hidden = YES;
    
    self.emailTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    self.passwordTF.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Forgot password" attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.forgetLabel.attributedText = attrStr;
    
    [self.SignBtn setTitle:@"Sign in" forState:0];
    [self.SignBtn  setBackgroundColor:Color(@"#F6AA00")];
    self.SignBtn.enabled=YES;
    [self.SignBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.passwordTF.mas_bottom).offset(5);
        make.left.offset(47);
        make.height.offset(38);
        make.width.offset(ScreenWidth-47*2);
    }];
}

- (void)creatAccount{
    self.line1.hidden = YES;
    self.line2.hidden = NO;
    
    self.tempTF.text = @"";
    self.emailTF.text=@"";
    self.passwordTF.text=@"";
    self.confirmPasswordlabel.hidden = NO;
    self.confirmPasswordTF.hidden = NO;
    self.InvitationCodeTF.hidden = NO;
    self.InvitationCodeLabel.hidden = NO;
    self.selecedBtn.hidden = NO;
    self.selectedLabel.hidden = NO;
    
    self.forgetLabel.text = @"or";
    
    [self.SignBtn setTitle:@"Create Account" forState:0];
    
    
    if (self.selecedBtn.selected) {
          [self.SignBtn  setBackgroundColor:Color(@"#F6AA00")];
        self.SignBtn.enabled=YES;
    }
    else
    {
         [self.SignBtn  setBackgroundColor:[UIColor lightGrayColor]];
           self.SignBtn.enabled=NO;
    }
    [self.SignBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.selecedBtn.mas_bottom).offset(30);
        make.left.offset(47);
        make.height.offset(38);
       make.width.offset(ScreenWidth-47*2);
    }];
}

- (void)forgotBtn{
    if ([self.forgetLabel.text isEqualToString:@"or"]) return;
    [self.navigationController pushViewController:[ForgetPasswordViewController new] animated:YES];
}
- (void)selectPress{
   if (![self.SignBtn.titleLabel.text isEqualToString:@"Sign in"]) {
        self.selecedBtn.selected=!self.selecedBtn.selected;
        if (self.selecedBtn.selected) {
            self.SignBtn.backgroundColor=Color(@"#F6AA00");
            self.SignBtn.enabled=YES;
           
        }
        else
        {
            self.SignBtn.backgroundColor=[UIColor lightGrayColor];
            self.SignBtn.enabled=NO;
        }
    }
  
    
}
- (void)loginIn{

    if ([self.SignBtn.titleLabel.text isEqualToString:@"Sign in"]) {
    LoginModel *model=[[LoginModel alloc]init];
    if (self.emailTF.text.length==0) {
            [MBProgressHUD showSuccess:@"Email   cannot be empty" toView:self.view];
     
        return;
    }
    if (self.passwordTF.text.length==0) {
       
        [MBProgressHUD showSuccess:@"Password  cannot be empty" toView:self.view];
     
  
        return;
    }
  
    model.password=self.passwordTF.text;
 
    model.email=self.emailTF.text;
    
   [MBProgressHUD showMessage:nil toView:self.view];
    [model LoginModelSuccessBlock:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
           LoginModel *login=(LoginModel *)data;
           [model save:login.data];

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Tourist_id"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordTF.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:self.emailTF.text forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if ([self.isPresent isEqualToString:@"1"]) {
                   self.block();
                  [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            else
            {
                TabBarController *tabbar = [TabBarController new];
                      self.view.window.rootViewController = tabbar;
            }
           
          
        }
        else
        {
       
            AlertMessageView *view=[[AlertMessageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
             view.subTitle.text=message;
               [self.view.window addSubview:view];
        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    }
    else
    {
       
        if (self.emailTF.text.length==0) {
            [MBProgressHUD showSuccess:@"Email   cannot be empty" toView:self.view];
            
            return;
        }
        if (self.passwordTF.text.length==0) {
            
            [MBProgressHUD showSuccess:@"Password  cannot be empty" toView:self.view];
            
            
            return;
        }
        if (self.confirmPasswordTF.text.length==0) {
              [MBProgressHUD showSuccess:@"Confirm Password  cannot be empty" toView:self.view];
            return;
        }
        if (![self.confirmPasswordTF.text isEqualToString:self.passwordTF.text]) {
              [MBProgressHUD showSuccess:@"Confirm password is not the same as password" toView:self.view];
                      return;
        }
        CreateAccountModel *model =[[CreateAccountModel  alloc]init];
        model.email=self.emailTF.text;
        model.password=self.passwordTF.text;
      
        [MBProgressHUD showMessage:nil toView:self.view];

        [model CreateAccountModelSuccessBlock:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showSuccess:message toView:self.view];
            if ([code intValue]==200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self signIn];
                });
            }

        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];

        }];
        
    }

}


@end
