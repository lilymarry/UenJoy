//
//  ConbinationViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ConbinationViewController.h"
#import "ConbinationMainCell.h"
@interface ConbinationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *myTableView;
@end

@implementation ConbinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = Color(@"f5f5f5");
    [self setupCartView];
    
    
}

- (void)setupCartView {
    //创建底部视图

    CGFloat tableHeight = ScreenHeight-NaviBarAndStatusBarHeight-54;
   
    [self.myTableView removeFromSuperview];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, tableHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
 //   table.rowHeight = 140;
    table.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    table.backgroundColor = Color(@"f5f5f5");
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    self.myTableView = table;
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConbinationMainCell class]) bundle:nil] forCellReuseIdentifier:@"ConbinationMainCell"];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConbinationMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConbinationMainCell"];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height= ((ScreenWidth-17)/3+50-10)*1+20+68+17*2;
    return height;
}
@end
