//
//  OderInfoGoodList.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OderInfoGoodList.h"
#import "CartTableViewCell.h"
#import "OrderInfoModel.h"
#import "CommodityDetailViewController.h"
@interface OderInfoGoodList ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *myTableView;
@end

@implementation OderInfoGoodList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
     [self setupCartView];
}
#pragma mark -- 创建视图
- (void)setupCartView {
  
    CGFloat tableHeight =  ScreenHeight-NaviBarAndStatusBarHeight;
 
    [self.myTableView removeFromSuperview];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, tableHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
   
    table.rowHeight = 140;
  //  table.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    self.myTableView = table;
    
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray=[NSArray arrayWithArray:dataArray];
    [self.myTableView reloadData];
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartTableViewCell"];
    if (cell == nil) {
        cell = [[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CartTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     OrderInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    NSString* encodedString =[model.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    [ cell.lzImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
  
       cell.nameLabel.text = model.name;
       cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",_code,model.product_price];
 
    cell.numberLabel.text = [NSString stringWithFormat:@"X%d",(int)[model.qty intValue]];

    cell.addBtn.hidden=YES;
    cell.cutBtn.hidden=YES;
    cell.selectBtn.hidden=YES;
   
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
       OrderInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
       detail.product_id=model.product_id;
       [self.navigationController pushViewController:detail animated:YES];
}
@end
