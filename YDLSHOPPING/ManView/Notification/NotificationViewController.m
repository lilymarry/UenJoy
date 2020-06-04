//
//  NotificationViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationTableViewCell.h"
#import "NotificationModel.h"

@interface NotificationViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSInteger  page;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation NotificationViewController

-(NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Notification";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = Color(@"#f5f5f5");
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableview.tableFooterView = [UIView new];
    tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableview.bounds.size.width, 15)];
    self.tableView = tableview;
    tableview.estimatedRowHeight = 94;
    tableview.estimatedSectionHeaderHeight = 38;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = Color(@"#F5F5F5");
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.emptyDataSetSource = self;
    tableview.emptyDataSetDelegate = self;
    tableview.rowHeight = UITableViewAutomaticDimension;
    [tableview registerClass:[NotificationTableViewCell class] forCellReuseIdentifier:@"notificationCell"];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.offset(ScreenHeight);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
    }];
    [self initRefresh];
}
- (void)initRefresh
{
    __block NotificationViewController * blockSelf = self;
    blockSelf.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf getData];
    }];
    [_tableView.mj_header beginRefreshing];
    blockSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf getData];
    }];
    
}
-(void)getData
{
    NotificationModel *list=[[NotificationModel alloc]init];
    list.customerid=[[LoginModel shareInstance]getUserInfo].uinfo.id;
    list.pagenum=[NSString stringWithFormat:@"%d",(int)page];
    list.numperpage=@"10";
    
    [list notificationModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        
        NotificationModel *list=( NotificationModel *)data;
        if ([code intValue]==200) {
            if (page ==1) {
                [self.dataSource removeAllObjects];
                if (list.data.private_inform2.count==0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    self.dataSource =[NSMutableArray arrayWithArray:list.data.private_inform2];
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }
            else
            {
                if (list.data.private_inform2.count==0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [self.dataSource addObjectsFromArray:list.data.private_inform2];
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        // [self.tableView.mj_footer endRefreshing];
    } andFailure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataSource.count == 0){
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
    }else{
        self.view.backgroundColor = Color(@"#f5f5f5");
        self.tableView.backgroundColor = Color(@"#f5f5f5");
    }
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationTableViewCell *cell=[NotificationTableViewCell cellWithTableView:tableView];
    
    cell.model =self.dataSource[indexPath.section];
    cell.contentView.layer.masksToBounds = YES;
    cell.contentView.layer.cornerRadius = 2;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 38)];
    UILabel *label = [UILabel new];
    label.textColor = Color(@"999999");
    label.font = font(12);
    NotificationModel *model =self.dataSource[section];
    label.text = [HelpCommon timeWithTimeIntervalString:model.created_at andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(view);
    }];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 -(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
 return YES;
 }
 
 -(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 if(editingStyle == UITableViewCellEditingStyleDelete){
 jxt_showAlertTwoButton(@"", @"Delete the message?", @"Cancel", ^(NSInteger buttonIndex) {
 
 }, @"Delete", ^(NSInteger buttonIndex) {
 
 });
 }
 }
 
 - (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return @"删除";
 }
 
 */
#pragma mark -空数据页代理
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"notification-img-empty"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"It is still empty";
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


@end
