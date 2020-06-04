//
//  AccountViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/5.
//  Copyright © 2019 sunjiayu. All rights reserved.
//
#import "AccountViewController.h"
#import "AccountTableViewCell.h"
#import "LoginViewController.h"
#import "HelpAndContact.h"
#import "OrderViewController.h"
#import "ProfileViewController.h"
#import "SelectPhotoManager.h"
//#import "DiscountCounponsViewController.h"
#import "WishListViewController.h"

#import "AddReviewsViewController.h"
#import "RAMViewController1.h"
#import "AdressBookViewController.h"
//#import "GiveViewController.h"
#import "SaveImageHeadModel.h"
@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) SelectPhotoManager *photoManager;
@property (nonatomic, strong) UIImageView *imageHead;
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    [self mainView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setHidden:NO];
    
    if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
        
        LoginViewController *log = [LoginViewController new];
           YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
           log.isPresent=@"2";
           [[UIApplication sharedApplication] keyWindow].rootViewController=navi;

        return;
    }
     else
     {
         if ([[LoginModel shareInstance]getUserInfo].uinfo.nickname.length>0) {
                self. nameLabel.text = [[LoginModel shareInstance]getUserInfo].uinfo.nickname;
         }
         else
         {
             self. nameLabel.text = @"no set";
         }
      NSString* encodedString =[ [[LoginModel shareInstance]getUserInfo].uinfo.userimg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码

       [self.imageHead sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];

         
     }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)mainView{
    UIView *topView = [UIView new];
    topView.backgroundColor = Color(@"F5F5F5");
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(0);
     //   make.height.offset( Is_iPhoneX? ScreenWidth*2/3.7+30 : ScreenWidth*2/3.7+10);
        make.left.offset(0);
        make.right.offset(0);
          make.height.offset( ScreenWidth*2/3.7+30);
     //   make.width.offset(ScreenWidth);
    }];
    
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = Color(@"#555555");
 
   [topView addSubview:grayView];

    [grayView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(ScreenWidth*2/3.7);
      //  make.width.mas_equalTo(ScreenWidth);
    }];


    UIButton *btnR = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnR setTitle:@"Profile" forState:0];
    btnR.titleLabel.font =font(12);
    [btnR addTarget:self action:@selector(click_profile) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemR = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = backItemR;
    
    UIImageView *imageHead = [UIImageView new];
    imageHead.layer.masksToBounds = YES;
    imageHead.layer.cornerRadius = 31;
    self.imageHead = imageHead;
   
    imageHead.backgroundColor = Color(@"ffffff");
    [grayView addSubview:imageHead];
    [imageHead mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(62);
        make.width.offset(62);
        make.centerX.equalTo(grayView);
        make.top.offset(55);
    }];
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHead)];
    imageHead.userInteractionEnabled = YES;
    [imageHead addGestureRecognizer:headerTap];
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = font(15);
    nameLabel.textColor = Color(@"ffffff");
    [grayView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imageHead.mas_bottom).offset(12);
        make.centerX.equalTo(grayView);
    }];

    UIView *whiteView = [UIView new];
    whiteView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
  whiteView.backgroundColor = Color(@"ffffff");
    whiteView.layer.shadowOffset = CGSizeMake(0,3);
    whiteView.layer.shadowOpacity = 1;
    whiteView.layer.shadowRadius = 4;
    whiteView.layer.cornerRadius = 1.5;
    [topView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make){
     //make.top.equalTo(grayView.mas_bottom).offset(Is_iPhoneX? -20 : -8);
        make.top.equalTo(grayView.mas_bottom).offset( -8);
        make.centerX.equalTo(grayView);
        make.height.offset(50);
        make.width.offset(ScreenWidth-40);
      
    }];
   
    UIView *line = [UIView new];
    line.backgroundColor = Color(@"#CDDDDA");
    [whiteView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(18);
        make.width.offset(1);
        make.centerX.equalTo(whiteView);
        make.centerY.equalTo(whiteView);
    }];
    
    UIImageView *leftImage = [UIImageView new];
    leftImage.image = [UIImage imageNamed:@"account-coupons"];
    [whiteView addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(whiteView);
        make.left.equalTo(whiteView).offset(20);
        make.height.offset(18);
        make.width.offset(18);
    }];
    
    UILabel *leftLabel = [UILabel new];
    leftLabel.text = @"Discount Coupons";
    leftLabel.font =font(12);
    [whiteView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(leftImage.mas_right).offset(10);
        make.centerY.equalTo(whiteView);
    }];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDiscount)];
    leftLabel.userInteractionEnabled = YES;
    [leftLabel addGestureRecognizer:leftTap];
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.text = @"Wish List";
    rightLabel.font = font(12);
    [whiteView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(whiteView).offset(-50);
        make.centerY.equalTo(whiteView);
    }];
    
    UIImageView *rightImage = [UIImageView new];
    rightImage.image = [UIImage imageNamed:@"account-wishlist"];
    [whiteView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(whiteView);
        make.right.equalTo(rightLabel.mas_left).offset(-10);
        make.height.offset(18);
        make.width.offset(18);
    }];
    
    UIButton *leftBtn = [UIButton new];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    [whiteView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(clickDiscount) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(whiteView).offset(0);
        make.top.equalTo(whiteView).offset(0);
        make.height.offset(56);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE/2);
    }];
    
    UIButton *rightBtn = [UIButton new];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [whiteView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clickWishList) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(whiteView.mas_right).offset(0);
        make.top.equalTo(whiteView).offset(0);
        make.height.offset(56);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE/2);
    }];
    
  
    UITableView *tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = Color(@"#F5F5F5");
    tableView.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    [tableView registerClass:[AccountTableViewCell class] forCellReuseIdentifier:@"accountCell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(ScreenHeight-208-TabBarHeight);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
        make.top.equalTo(topView.mas_bottom).offset(Is_iPhoneX? 34 : 20);
        make.centerX.equalTo(self.view);
    }];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.001)];
    tableView.tableHeaderView = view;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 351, 60)];
    footerView.backgroundColor =Color(@"#f5f5f5");
    tableView.tableFooterView = footerView;
    
    UIView *footerWhiteView = [UIView new];
    footerWhiteView.backgroundColor = Color(@"#ffffff");
    [footerView addSubview:footerWhiteView];
    footerWhiteView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(signOut)];
    [footerWhiteView addGestureRecognizer:gesture];
    [footerWhiteView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(50);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
        make.top.equalTo(footerView).offset(10);
    }];
    
    UILabel *footerLabel = [UILabel new];
    footerLabel.text = @"Sign Out";
    footerLabel.font =font(14);
    [footerWhiteView addSubview:footerLabel];
    [footerLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(footerWhiteView);
        make.centerX.equalTo(footerWhiteView);
    }];

}

- (void)changeHead{
    if (!_photoManager) {
        _photoManager =[[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:@"选择头像"];
    __weak typeof(self)mySelf=self;
    //选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
        
     
       SaveImageHeadModel  *model =[[SaveImageHeadModel alloc]init];
              [MBProgressHUD showMessage:nil toView:mySelf.view];
              model.imageArr=[NSArray arrayWithObjects:image, nil];
              [model SaveImageHeadModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
                    [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
                  if ([code intValue]==200) {
                      mySelf.imageHead.image=image;
                      
                      [mySelf loginIn];
                  }
                  else
                  {
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [MBProgressHUD showSuccess:message toView:mySelf.view];
                                });
                  }
              } andFailure:^(NSError * _Nonnull error) {
                  [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
                  [MBProgressHUD showError:[error localizedDescription] toView:mySelf.view];
              }];
    };
}

- (void)clickDiscount{
    RAMViewController1 *ram=[[RAMViewController1 alloc]init];
                                    ram.type=@"discount";
                                    [self.navigationController pushViewController:ram animated:YES];
                                                       
//    [self.navigationController pushViewController:[DiscountCounponsViewController new] animated:YES];
}

- (void)clickWishList{
    [self.navigationController pushViewController:[WishListViewController new] animated:YES];
}

-(void)click_profile{
    [self.navigationController pushViewController:[ProfileViewController new] animated:YES];
}

#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 3;
    }else{
        return 1;
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*AUTOLAYOUT_WIDTH_SCALE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountCell"];
    cell.backgroundColor = Color(@"ffffff");
    if (indexPath.section == 0){
        if (indexPath.row == 0){
             cell.image.image = [UIImage imageNamed:@"account-order1"];
            cell.label.text = @"Order";
        }else if (indexPath.row == 1){
              cell.image.image = [UIImage imageNamed:@"account-review"];
            cell.label.text = @"Reviews";
        }else{
              cell.image.image = [UIImage imageNamed:@"account-RMA"];
            cell.label.text = @"RMA";
        }
    }else if(indexPath.section == 1){
        cell.image.image = [UIImage imageNamed:@"account-address"];
        cell.label.text = @"Address book";
    }
//    else if(indexPath.section == 2){
//        cell.image.image = [UIImage imageNamed:@"account-give5"];
//        cell.label.text = @"Give$5,Get$5";
//    }
    else if(indexPath.section == 2){
        cell.image.image = [UIImage imageNamed:@"account-feedback"];
        cell.label.text = @"Help & Contact";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0.1;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[OrderViewController new] animated:YES];
                   break;
                case 1:
                    {
                                    RAMViewController1 *ram=[[RAMViewController1 alloc]init];
                                    ram.type=@"review";
                                    [self.navigationController pushViewController:ram animated:YES];
                                                       break;
                                    
                                }
                case 2:
                {
                    RAMViewController1 *ram=[[RAMViewController1 alloc]init];
                    ram.type=@"RAM";
                    [self.navigationController pushViewController:ram animated:YES];
                                       break;
                    
                }
                   
                    
            }
            break;
        case 1:
            [self.navigationController pushViewController:[AdressBookViewController new] animated:YES];
            break;

        case 2:
            [self.navigationController pushViewController:[HelpAndContact new] animated:YES];
            break;
    }
}

- (void)signOut{
    
  [[LoginModel shareInstance] deleteUserInfo];
  
    LoginViewController *log = [LoginViewController new];
          YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
          log.isPresent=@"2";
          [[UIApplication sharedApplication] keyWindow].rootViewController=navi;

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
