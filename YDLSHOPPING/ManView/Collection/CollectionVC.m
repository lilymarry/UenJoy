//
//  CollectionVC.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CollectionVC.h"
#import "NotificationViewController.h"
#import "SearchViewController.h"
#import "CollectionListModel.h"
#import "CollectionVCCell.h"
#import "CommodityDetailViewController.h"
@interface CollectionVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *dataArr;
@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];

     [self setupView];
     [self setNavi];
     [self getData];
   
}
- (void)getData{
    [MBProgressHUD showMessage:nil toView:self.view];

    CollectionListModel *model=[[CollectionListModel alloc]init];
    [model CollectionListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            CollectionListModel *model=(  CollectionListModel *)data;
            self.dataArr=[NSArray arrayWithArray:model.data.collection];
            [self.myTableView reloadData];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setNavi{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImageView *naviImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 71, 21)];
    naviImageView.contentMode = UIViewContentModeScaleAspectFit;
    naviImageView.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = naviImageView;
    
    UIButton *btnL = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnL setImage:[UIImage imageNamed:@"nav_btn_essage" ] forState:UIControlStateNormal];
    [btnL addTarget:self action:@selector(goMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemL = [[UIBarButtonItem alloc] initWithCustomView:btnL];
    self.navigationItem.leftBarButtonItem = backItemL;
    
    UIButton *btnR = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnR setImage:[UIImage imageNamed:@"nav_btn_search" ] forState:UIControlStateNormal];
     [btnR addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemR = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = backItemR;
}
- (void)setupView {
    //创建底部视图

    CGFloat tableHeight = ScreenHeight-NaviBarAndStatusBarHeight-TabBarHeight;
    
    [self.myTableView removeFromSuperview];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, tableHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
   
    table.rowHeight = 140;
  
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:table];
    self.myTableView = table;
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionVCCell class]) bundle:nil] forCellReuseIdentifier:@"CollectionVCCell"];
    
        adjustsScrollViewInsets_NO(self.myTableView, self);
}

-(void)goMessage{
    if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
         
         LoginViewController *log = [LoginViewController new];
         YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
         log.isPresent=@"2";
         [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
         
         return;
     }
    
    NotificationViewController *noti = [NotificationViewController new];
    [self.navigationController pushViewController:noti animated:YES];
}


- (void)goSearch{
    SearchViewController  *search =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   CollectionVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionVCCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CollectionListModel *model=self.dataArr[indexPath.row];
    cell.model=model;
    cell.block = ^(CollectionListModel * _Nullable model) {
        CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
           detail.product_id=model.product_id;
           [self.navigationController pushViewController:detail animated:YES];
        return ;
    };
    
       return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       CollectionListModel *model=self.dataArr[indexPath.row];
    CGFloat Height=ScreenWidth*129/375+180+20;
    if (  model.collection_imgs.count==0) {
        Height=Height-ScreenWidth*129/375;
    }
    if (model.content_products.count==0) {
         Height=Height-180;
    }
    return Height;
}

@end
