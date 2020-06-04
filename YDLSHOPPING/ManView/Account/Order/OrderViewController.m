//  OrderViewController.m
//  YDLSHOPPING
//  Created by mac on 2019/8/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
#import "OrderViewController.h"
#import "OrderListViewController.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Order";
    
    self.dataSource = @[@"Pending Payment",@"Processing",@"Shipped",@"Delivered",@"Canceled"];
    
    UITableView *tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = Color(@"#F5F5F5");
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(ScreenHeight-NaviBarAndStatusBarHeight-TabBarHeight);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
        make.top.offset(20);
        make.centerX.equalTo(self.view);
    }];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 2)];
    tableView.tableHeaderView = view;
}

#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*AUTOLAYOUT_WIDTH_SCALE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.section];
    cell.textLabel.font=font(14);
    cell.textLabel.textColor=Color(@"#333333");
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListViewController *OL = [OrderListViewController new];
    OL.flag = indexPath.section;
    [self.navigationController pushViewController:OL animated:YES];
}
@end
