//
//  ProfileViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ProfileViewController.h"
#import "NickNameViewController.h"
#import "EmailAddressViewController.h"
#import "PasswordViewController.h"
#import "SelectPhotoManager.h"
#import "SaveImageHeadModel.h"
#import "LoginModel.h"
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIImageView *imageHead;
@property (nonatomic, strong) SelectPhotoManager *photoManager;
@end
@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"#F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Profile";
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.backgroundColor = Color(@"#F5F5F5");
    self.tableview.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:self.tableview];
    
   //   model.merchant_id=[[LoginModel shareInstance] getUserInfo].user_info.merchant_id ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 90;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        if (indexPath.section == 0){
            UIImageView *imageHead = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-100, 15, 62, 62)];
            imageHead.layer.masksToBounds = YES;
            imageHead.layer.cornerRadius = 31;
            self.imageHead = imageHead;
            
            NSString* encodedString =[ [[LoginModel shareInstance]getUserInfo].uinfo.userimg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码

            [self.imageHead sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];

            
            [cell.contentView addSubview:imageHead];
        }
    }
    cell.textLabel.font=font(14);
    cell.detailTextLabel.font=font(14);
    if (indexPath.section == 0){
        cell.textLabel.text = @"User Head";
    }else{
        cell.textLabel.text = @[@"NickName",@"Email Address",@"Password"][indexPath.row];
        if ([cell.textLabel.text isEqualToString:@"NickName"]) {
            cell.detailTextLabel.text =[[LoginModel shareInstance]getUserInfo].uinfo.nickname;
        }
       else if ([cell.textLabel.text isEqualToString:@"Email Address"]) {
             cell.detailTextLabel.text =[[LoginModel shareInstance]getUserInfo].uinfo.email;
        }
        else
        {
             cell.detailTextLabel.text =@"******";
        }
  
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0){
        [self changeHead];
    }else{
        UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 0){
            NickNameViewController *nick=   [NickNameViewController new];
            nick.name=cell.detailTextLabel.text;
            nick.nameBlock = ^{
        
                [self.tableview reloadData];
            };
            [self.navigationController pushViewController:nick animated:YES];
        }else if (indexPath.row == 1){
            EmailAddressViewController *nick=   [EmailAddressViewController new];
            nick.name=cell.detailTextLabel.text;
            nick.emailBlock  = ^{
                 [self.tableview reloadData];
            };
            [self.navigationController pushViewController:nick animated:YES];
        }else{
            [self.navigationController pushViewController:[PasswordViewController new] animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = Color(@"#F5F5F5");
    return view;
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
     
//
//
//        //保存到本地
//        NSData *data = UIImagePNGRepresentation(image);
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
    };
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
