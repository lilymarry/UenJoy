//  FeedbackViewController.m
//  YDLSHOPPING
//  Created by mac on 2019/8/26.
//  Copyright © 2019 sunjiayu. All rights reserved.
#import "FeedbackViewController.h"
#import "ContactUsModel.h"
@interface FeedbackViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, strong) UITextField *tempTF;
@property (nonatomic, strong) UITextField *SubjectTF;
@property (nonatomic, strong) UITextView *textview;
@property (nonatomic, strong) UILabel *textViewholder;
@property (nonatomic, strong) UILabel *limitLab;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *emailTF;
@end
@implementation FeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Give us your feedback";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = Color(@"#ffffff");
    [self setMainView];
}
- (void)setMainView{
    
    UITextField *SubjectTF = [UITextField new];
    self.SubjectTF = SubjectTF;
    SubjectTF.backgroundColor = Color(@"#ffffff");
    SubjectTF.font =font(14);
    SubjectTF.placeholder = @"Subject*";
   // [SubjectTF setValue:Color(@"#333333") forKeyPath:@"_placeholderLabel.textColor"];

    SubjectTF.layer.masksToBounds = YES;
    SubjectTF.layer.cornerRadius = 2;
    SubjectTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    SubjectTF.layer.borderWidth = 1;
    SubjectTF.delegate = self;
    SubjectTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    SubjectTF.leftViewMode = UITextFieldViewModeAlways;
    SubjectTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.view addSubview:SubjectTF];
    [SubjectTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.right.offset(-12);
        make.top.equalTo(self.view).offset(NaviBarAndStatusBarHeight+15);
        make.height.offset(50);
    }];
    
    UITextView *textView = [UITextView new];
    textView.backgroundColor = Color(@"#ffffff");
    textView.delegate = self;
    self.textview = textView;
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 2;
    textView.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    textView.layer.borderWidth = 1;
    textView.textContainerInset = UIEdgeInsetsMake(13, 9, 13, 13);
    textView.font = font(14);
    textView.textColor = [UIColor blackColor];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.top.equalTo(SubjectTF.mas_bottom).offset(15);
        make.height.offset(200);
        make.right.offset(-12);
    }];
    
    UILabel *textViewPlaceholder = [UILabel new];
    self.textViewholder = textViewPlaceholder;
    textViewPlaceholder.text = @"Please write your feedback below*";
    textViewPlaceholder.font = font(14);
    textViewPlaceholder.textColor = Color(@"#333333");
    [textView addSubview:textViewPlaceholder];
    [textViewPlaceholder mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(textView).offset(13);
        make.top.equalTo(textView).offset(13);
    }];
    
    UILabel *limitLab = [UILabel new];
    limitLab.text = @"0/300";
    limitLab.font =font(14);
    self.limitLab = limitLab;
    limitLab.textColor = Color(@"#999999");
    [self.view addSubview:limitLab];
    [limitLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.view.mas_right).offset(-22);
        make.top.equalTo(self.view).offset(NaviBarAndStatusBarHeight+255);
    }];
    
    UITextField *nameTF = [UITextField new];
    self.nameTF = nameTF;
    nameTF.backgroundColor = Color(@"#ffffff");
    nameTF.font =font(14);
    nameTF.placeholder = @"Name*";
 //   [nameTF setValue:Color(@"#333333") forKeyPath:@"_placeholderLabel.textColor"];
    nameTF.layer.masksToBounds = YES;
    nameTF.layer.cornerRadius = 2;
    nameTF.layer.borderColor = [Color(@"#DDDDDD") CGColor];
    nameTF.layer.borderWidth = 1;
    nameTF.delegate = self;
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTF.leftViewMode = UITextFieldViewModeAlways;
    nameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    [self.view addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.right.offset(-12);
        make.top.equalTo(self.textview.mas_bottom).offset(10);
        make.height.offset(50);
    }];
    
    UITextField *emailTF = [UITextField new];
    self.emailTF = emailTF;
    emailTF.backgroundColor = Color(@"#ffffff");
    emailTF.font = font(14);
    emailTF.placeholder = @"Email*";
  //  [emailTF setValue:Color(@"#333333") forKeyPath:@"_placeholderLabel.textColor"];
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
        make.left.offset(12);
        make.right.offset(-12);
        make.top.equalTo(self.nameTF.mas_bottom).offset(10);
        make.height.offset(50);
    }];
    
    
    
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Submit" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];
    footerBtn.titleLabel.font = font(15);
    [footerBtn setBackgroundColor:Color(@"#F6AA00")];
    [self.view addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.right.offset(-12);
        make.height.offset(40);
        make.top.equalTo(self.emailTF.mas_bottom).offset(30);
    }];
    
    UILabel *lab = [UILabel new];
    lab.text = @"This is our customer service email service@uenjoy.com";
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font = font(12);
    lab.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.equalTo(footerBtn.mas_bottom).offset(20);
    }];
    
}

- (void)clickSubmit{
   
    
    if (self.SubjectTF.text.length==0) {
        [MBProgressHUD showSuccess:@"Subject cannot be empty" toView:self.view];
        return;
    }
    if (  self.textview.text.length==0) {
        [MBProgressHUD showSuccess:@"Feedback cannot be empty" toView:self.view];
        return;
    }
    if (self.nameTF.text.length==0) {
        [MBProgressHUD showSuccess:@"Name cannot be empty" toView:self.view];
        return;
    }
    if (self.emailTF.text.length==0) {
        [MBProgressHUD showSuccess:@"Email cannot be empty" toView:self.view];
        return;
    }
    
    ContactUsModel *model=[[ContactUsModel alloc]init];
    model.title=self.SubjectTF.text;
    model.customer_name=self.nameTF.text;
    model.customer_email=self.emailTF.text;
    model.content=self.textview.text;
     [MBProgressHUD showMessage:nil toView:self.view];
    [model ContactUsModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:message toView:self.view];
        });
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tempTF resignFirstResponder];
    [self.textview resignFirstResponder];
}

#pragma mark TextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tempTF = textField;
    return YES;
}

#pragma maek TextView
- (void)textViewDidChange:(UITextView *)textView{
    self.limitLab.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
    if ([textView.text isEqualToString:@""]){
        self.textViewholder.hidden = NO;
    }else{
        self.textViewholder.hidden = YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.location >= 300){
        return NO;
    }else{
        return YES;
    }
}

@end
