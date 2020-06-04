//
//  WishListViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AdressBookViewController.h"
#import "AdressBookTableViewCell.h"
#import "AddShippingAddressViewController.h"
#import "AdressListModel.h"
#import "SetAdressDefaultModel.h"
#import "DelectAdressModel.h"
#import "AddShippingAddressViewController.h"

@interface AdressBookViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIView *bottomVIew;
@end

@implementation AdressBookViewController
-(NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Address Book";
    
    
    [self setMainView];
    [self getData];
}
- (void)getData{
    [MBProgressHUD showMessage:nil toView:self.view];

    AdressListModel *model=[[AdressListModel alloc]init];
    
    [model AdressListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            AdressListModel *model=(AdressListModel *)data;
            self.dataSource =[NSMutableArray arrayWithArray:model.data.addressList];
            [self.tableView reloadData];
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
- (void)setMainView{
    UITableView *tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = Color(@"#F5F5F5");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.separatorColor=[UIColor clearColor];
    tableView.allowsMultipleSelectionDuringEditing = YES;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[AdressBookTableViewCell class] forCellReuseIdentifier:@"AddressBookCell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(0);
        make.height.offset(ScreenHeight);
        make.width.offset(ScreenWidth);
    }];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(addShipping) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Add shippingAddress" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];
    footerBtn.titleLabel.font = font(15);
    [footerBtn setBackgroundColor:Color(@"#F6AA00")];
    [footerView addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
        make.height.offset(40);
        make.center.equalTo(footerView);
    }];
    tableView.tableFooterView = footerView;
    
}

#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 158;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AdressBookTableViewCell *cell=[AdressBookTableViewCell cellWithTableView:tableView];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
   AdressListModel *model =self.dataSource[indexPath.row];
    cell.nameLab.text=[NSString stringWithFormat:@"%@%@ ,%@",model.last_name,model.first_name,model.telephone];

    cell.addressLab.text=[NSString stringWithFormat:@"%@, %@ , %@ ,%@ ,%@",model.street1,model.city,model.stateName,model.countryName,model.zip];
   // NSLog( @"SSSS   %@",model.is_default);
    if ([model.is_default intValue]==1) {
        [cell.defaultBtn setImage:[UIImage imageNamed:@"addressbook-default"] forState:UIControlStateNormal];
        cell.deleBtn.hidden=YES;
        
        [cell.deleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0);
        }];
        [cell layoutIfNeeded];
        
      
    }
    else
    {
       [cell.defaultBtn setImage:[UIImage imageNamed:@"addressbook-normal"] forState:UIControlStateNormal];
         cell.deleBtn.hidden=NO;
        [cell.deleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(60);
        }];
        [cell layoutIfNeeded];
    }
    
    cell.defaultBtn.tag=indexPath.row;
    cell.editBtn.tag=indexPath.row;
    cell.deleBtn.tag=indexPath.row;
    
    [cell.defaultBtn addTarget:self action:@selector(defaultPress:) forControlEvents:UIControlEventTouchUpInside];
    [ cell.editBtn  addTarget:self action:@selector(editPress: ) forControlEvents:UIControlEventTouchUpInside];
    [ cell.deleBtn  addTarget:self action:@selector(delePress:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 //   [self.navigationController pushViewController:[AddShippingAddressViewController new] animated:YES];
}


#pragma mark -空数据页代理
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"addressbook-empty"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"You have no saved shipping address";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName:Color(@"#666666")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100.0;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

- (void)addShipping{
    AddShippingAddressViewController *add=[[AddShippingAddressViewController alloc]init];
    add.AddBlock = ^{
        [self getData];
    };
    [self.navigationController pushViewController:add animated:YES];
}
- (void)defaultPress:(UIButton *)but{
      AdressListModel *model =self.dataSource[but.tag];
    SetAdressDefaultModel  *set =[[SetAdressDefaultModel alloc]init];
    set.address_id=model.address_id;
    [MBProgressHUD showMessage:nil toView:self.view];

    [set SetAdressDefaultModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if ([code intValue]==200) {
            [self getData];
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
- (void)editPress:(UIButton *)but{
    AdressListModel *model =self.dataSource[but.tag];
    AddShippingAddressViewController *add=[[AddShippingAddressViewController alloc]init];
    add.address_id=model.address_id;
    add.mainModel=model;
    add.AddBlock = ^{
        [self getData];
    };
    [self.navigationController pushViewController:add animated:YES];
}
- (void)delePress:(UIButton *)but{
    AdressListModel *model =self.dataSource[but.tag];
    DelectAdressModel  *set =[[DelectAdressModel alloc]init];
    set.address_id=model.address_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [set DelectAdressModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            [self getData];
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
@end
