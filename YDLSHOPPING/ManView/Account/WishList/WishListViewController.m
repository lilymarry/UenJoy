//
//  WishListViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "WishListViewController.h"
#import "WishListTableViewCell.h"
#import "WishListModel.h"
#import "AddOrDeleteFavoriteModel.h"
#import "AddCartModel.h"
#import "CommodityDetailViewController.h"
@interface WishListViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    BOOL isEditing;
    BOOL isAllSelect;
     NSInteger  page;
}
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIView *bottomVIew;
@end

@implementation WishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Wish List";
    UIButton *btnR = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [btnR setBackgroundImage:[UIImage imageNamed:@"nav_wish_edit"] forState:0];
    [btnR addTarget:self action:@selector(click_edit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemR = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = backItemR;
    
   
    [self setMainView];
    
    [self getData];
    isEditing=NO;
    isAllSelect=NO;
    
    [self initRefresh];
}
- (void)initRefresh
{
    __block WishListViewController * blockSelf = self;
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
- (void)getData{
    WishListModel *model=[[WishListModel alloc]init];
     [MBProgressHUD showMessage:nil toView:self.view];
    model.p=[NSString stringWithFormat:@"%ld",(long)page];
    [model WishListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            WishListModel *mod=(WishListModel *)data;
            
            if (page ==1) {
                      [self.dataSource removeAllObjects];
                         if (mod.data.productList.count==0) {
                                                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                              }
                                              else
                                              {
                                                     self.dataSource =[NSMutableArray arrayWithArray:mod.data.productList];
                                                    [self.tableView.mj_footer endRefreshing];
                                             }
                  }
                  else
                  {
                      if (mod.data.productList.count==0) {
                             [self.tableView.mj_footer endRefreshingWithNoMoreData];
                      }
                      else
                      {
                           [self.dataSource addObjectsFromArray:mod.data.productList];
                          [self.tableView.mj_footer endRefreshing];
                      }
                    
                  }
            
               [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
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
    tableView.allowsMultipleSelectionDuringEditing = YES;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[WishListTableViewCell class] forCellReuseIdentifier:@"WishListCell"];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(0);
        make.height.offset(ScreenHeight);
        make.width.offset(ScreenWidth);
    }];
    
    UIView *bottomVIew = [UIView new];
    self.bottomVIew = bottomVIew;
    bottomVIew.backgroundColor=[UIColor redColor];
    bottomVIew.hidden = YES;
    [self.view addSubview:bottomVIew];
    [bottomVIew mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.offset(Is_iPhoneX?-34:0);
        make.height.offset(50);
        make.width.offset(ScreenWidth);
    }];
    
    UIView *leftVIew = [UIView new];
    leftVIew.backgroundColor = [UIColor whiteColor];
    [bottomVIew addSubview:leftVIew];
    [leftVIew mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(bottomVIew).offset(0);
        make.top.offset(0);
        make.height.offset(50);
       // make.width.offset(120);
       make.width.offset(145*AUTOLAYOUT_WIDTH_SCALE);
    }];
    leftVIew.userInteractionEnabled = YES;
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAll)];
    [leftVIew addGestureRecognizer:leftTap];
    
    UIImageView *circleImage = [UIImageView new];
    self.circleImage = circleImage;
    circleImage.image = [UIImage imageNamed:@"wish_sel_nor"];
    [leftVIew addSubview:circleImage];
    [circleImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(20*AUTOLAYOUT_WIDTH_SCALE);
        make.centerY.equalTo(leftVIew);
        make.height.offset(17);
        make.width.offset(17);
    }];
    
    UILabel *selectLab = [UILabel new];
    selectLab.textColor = Color(@"#666666");
    selectLab.font =  font(16);
    selectLab.text = @"select all";
    [leftVIew addSubview:selectLab];
    [selectLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(circleImage.mas_right).offset(13*AUTOLAYOUT_WIDTH_SCALE);
        make.centerY.equalTo(circleImage);
    }];
    
    UIButton *rightBtn = [UIButton new];
    rightBtn.frame=CGRectMake(145*AUTOLAYOUT_WIDTH_SCALE, 0, ScreenWidth-145*AUTOLAYOUT_WIDTH_SCALE, 50);
    [rightBtn setTitle:@"Delete" forState:0];
    [rightBtn setBackgroundColor:Color(@"CCCCCC")];
    [rightBtn setTitleColor:Color(@"ffffff") forState:0];
    rightBtn.titleLabel.font =font(18);
    [rightBtn addTarget:self action:@selector(deletePress) forControlEvents:UIControlEventTouchUpInside];
    [bottomVIew addSubview:rightBtn];

}
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WishListTableViewCell *cell=[WishListTableViewCell cellWithTableView:tableView];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
   WishListModel *dataSoucreDic =self.dataSource[indexPath.row];
       NSString* encodedString =[dataSoucreDic.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    [  cell.image sd_setImageWithURL:[NSURL URLWithString: encodedString]
                    placeholderImage:[UIImage imageNamed:@"null-picture"]];
    
    cell.title.text = dataSoucreDic.name;
    
    cell.money.text = [NSString stringWithFormat:@"%@%.2f",dataSoucreDic.price_info.special_price.symbol,[dataSoucreDic.price_info.special_price.value doubleValue] ];
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    
    NSString *old=[NSString stringWithFormat:@"%@%.2f",dataSoucreDic.price_info.price.symbol,[dataSoucreDic.price_info.price.value doubleValue] ];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:old attributes:attribtDic];
    cell.oldmoney.attributedText = attribtStr;
    cell.wish_icImage.tag=indexPath.row;
    [cell.wish_icImage addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (isEditing) {
        cell.flag_image.hidden=NO;
        if (dataSoucreDic.isSelect) {
             cell.flag_image.image = [UIImage imageNamed:@"wish_sel_pre"];
        }
        else{
            cell.flag_image.image = [UIImage imageNamed:@"wish_sel_nor"];
        }
       
    }
    else
    {
        cell.flag_image.hidden=YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      WishListModel *model =self.dataSource[indexPath.row];
     if (isEditing) {

    model.isSelect=! model.isSelect;
    
   BOOL isselect= [self cherkArrAllSelect];
    if (isselect) {
         self.circleImage.image = [UIImage imageNamed:@"wish_sel_pre"];
    }
    else{
          self.circleImage.image = [UIImage imageNamed:@"wish_sel_nor"];
    }
    [self.tableView reloadData];
     }
    else
    {
        CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
        
           detail.product_id=model.product_id;
           [self.navigationController pushViewController:detail animated:YES];
    }
}
- (void)addCart:(UIButton *)but{
      WishListModel *list =self.dataSource[but.tag];
    AddCartModel *model=[[AddCartModel alloc]init];
          model.product_id=list.product_id;
          model.qty=@"1";
          
   
          [MBProgressHUD showMessage:nil toView:self.view];

          [model AddCartModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [MBProgressHUD showSuccess:message toView:self.view];
              });

          } andFailure:^(NSError * _Nonnull error) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              [MBProgressHUD showError:[error localizedDescription] toView:self.view];

          }];
}
- (void)click_edit{
    isEditing=!isEditing;
    self.bottomVIew.hidden =! isEditing;
    [self setArrSelectOrNotSelect:NO];
    self.circleImage.image = [UIImage imageNamed:@"wish_sel_nor"];
    [self.tableView reloadData];
}

- (void)selectAll{
    if ([self.circleImage.image isEqual:[UIImage imageNamed:@"wish_sel_pre"]]){
        self.circleImage.image = [UIImage imageNamed:@"wish_sel_nor"];
        [self setArrSelectOrNotSelect:NO];
     
    }else{
        self.circleImage.image = [UIImage imageNamed:@"wish_sel_pre"];
         [self setArrSelectOrNotSelect:YES];
       
    }
}
- (void)deletePress{
    
    if (self.dataSource.count==0) {
        [MBProgressHUD showSuccess:@"You don't have a collection yet" toView:self.view];
        return;
    }
    NSString *goods=[self getSelectGoods];
    if (goods.length==0) {
        [MBProgressHUD showSuccess:@"You don't have anything to delete yet" toView:self.view];
        return;
    }
    AddOrDeleteFavoriteModel *model=[[AddOrDeleteFavoriteModel alloc]init];
    model.type=@"del";
    model.product_id=goods;
    
    [MBProgressHUD showMessage:nil toView:self.view];

    [model addOrDeleteFavoriteModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
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
- (void)setArrSelectOrNotSelect:(BOOL)isselect{
    
    for ( WishListModel *data in self.dataSource) {
        data.isSelect=isselect;
    }
    [self.tableView reloadData];
 
}
- (BOOL )cherkArrAllSelect{
    for ( WishListModel *data in self.dataSource) {
        if ( data.isSelect==NO) {
            return NO;
        }
      
    }
    return YES;
}
-(NSString *)getSelectGoods
{
    NSMutableArray *arr=[NSMutableArray array];
    for ( WishListModel *data in self.dataSource) {
        if ( data.isSelect==YES) {
            [arr addObject:data];
        }
        
    }
    NSMutableString *str=[NSMutableString string];
    for (int i=0; i<arr.count; i++) {
        WishListModel *model=arr[i];
        [str appendString:model.product_id];
        
        if (i!=arr.count-1) {
            [str appendString:@","];
        }
    }
    return str;
}
#pragma mark -空数据页代理
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"wish_pic"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"Go pick something you love.";
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
