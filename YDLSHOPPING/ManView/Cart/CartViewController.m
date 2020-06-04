//
//  CartViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/5.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "CartListModel.h"
#import "UpdateCartModel.h"
#import "CommodityDetailViewController.h"
#import "CartSelectModel.h"
#import "WishListViewController.h"
#define  TAG_CartEmptyView 100

#define LZTabBarHeight 54

#import "OderInfo.h"
#import "OderInfoNew.h"
#import "OderInfoNewTwo.h"
#import "OrderInfoModel.h"
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSString *code;//货币符号
    BOOL edit_isno;//NO默认 YES编辑
    UIButton * rigthBtn;
    
}
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UIButton *checkBtn;
@property (strong,nonatomic)UIButton *wishListBtn;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@property (nonatomic, strong) UIView *backgroundView;
@property (strong,nonatomic)UITableView *myTableView;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 //   _isHasTabBarController = self.tabBarController?YES:NO;
    self.title = @"My Cart";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setupCartView];
    
    
    rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 80, 50);
    
    [rigthBtn setTitle:@"Edit" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = font(15);
    rigthBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -20);
    [rigthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    edit_isno = NO;
    code=@"$";
    [rigthBtn setTitle:@"Edit" forState:UIControlStateNormal];
    self.totlePriceLabel.hidden=NO;
    self.wishListBtn.hidden=YES;
    self.allSellectedButton.selected=NO;
    [self.checkBtn setTitle:@"CHECKOUT" forState:UIControlStateNormal];
    self.checkBtn.backgroundColor = Color(@"#F6AA00");
    
    
    [self getData];
}
#pragma mark -- 创建视图
- (void)setupCartView {
    //创建底部视图
    [self setupCustomBottomView];
    CGFloat tableHeight = 0;
    if (_ishiddenTabBarController) {
        tableHeight = ScreenHeight-NaviBarAndStatusBarHeight-LZTabBarHeight;
    } else {
        tableHeight = ScreenHeight-NaviBarAndStatusBarHeight-LZTabBarHeight-TabBarHeight;
    }
    [self.myTableView removeFromSuperview];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, tableHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.emptyDataSetSource = self;
    table.emptyDataSetDelegate = self;
    table.rowHeight = 140;
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:table];
    self.myTableView = table;
    
}
//底部视图
- (void)setupCustomBottomView {
    [self.backgroundView removeFromSuperview];
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = Color(@"#fafafa");
    backgroundView.tag = TAG_CartEmptyView + 1;
    self.backgroundView = backgroundView;
    backgroundView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
  
    if (_ishiddenTabBarController == YES) {
        backgroundView.frame = CGRectMake(0, ScreenHeight-LZTabBarHeight, ScreenWidth, LZTabBarHeight);
    } else {
        backgroundView.frame = CGRectMake(0, ScreenHeight -  TabBarHeight-LZTabBarHeight, ScreenWidth, LZTabBarHeight);
    }
    
    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = font(15);
    
    [selectAll setTitleColor:Color(@"#333333") forState:UIControlStateNormal];
    selectAll.frame = CGRectMake(7, 5, 100, LZTabBarHeight - 10);
    // selectAll.backgroundColor=[UIColor redColor];
    [selectAll setTitle:@" Select All" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"wish_sel_nor"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"wish_sel_pre"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    
    self.allSellectedButton = selectAll;
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = Color(@"#F6AA00");
    [btn setTitle:@"CHECKOUT" forState:0];
    btn.titleLabel.textColor = Color(@"#ffffff");
    btn.titleLabel.font = font(12);
    [btn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    self.checkBtn=btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-12);
        make.centerY.equalTo(selectAll);
        make.height.offset(30);
        make.width.offset(97);
    }];
    
    
    self.wishListBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    self.wishListBtn.backgroundColor = Color(@"#F6AA00");
    [self.wishListBtn setTitle:@"Wish List" forState:0];
    self.wishListBtn.titleLabel.textColor = Color(@"#ffffff");
    self.wishListBtn.titleLabel.font =font(12);
    [self.wishListBtn addTarget:self action:@selector(wishListPress) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:self.wishListBtn];
    [self.wishListBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(btn.mas_left).offset(-10);
        make.centerY.equalTo(selectAll);
        make.height.offset(30);
        make.width.offset(97);
    }];
    
    
    
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    self.totlePriceLabel = label;
    label.font = font(12);
    label.textColor = [UIColor redColor];
    [backgroundView addSubview:label];
    label.attributedText = [self LZSetString:@"$0.00"];
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(btn.mas_left).offset(-10);
        make.centerY.equalTo(btn);
    }];
    
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
    CartListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    NSString* encodedString =[model.img_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    [ cell.lzImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    
    cell.nameLabel.text = model.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",code,model.product_price];
    cell.dateLabel.text = model.product_row_price;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)[model.qty intValue]];
    
    
    cell.selectBtn.selected = [model.active intValue]  ?1:0;
    
    cell.addBtn.tag=indexPath.row;
    cell.cutBtn.tag=indexPath.row;
    cell.selectBtn.tag=indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
    
    detail.product_id=model.product_id;
    [self.navigationController pushViewController:detail animated:YES];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"cart-img-empty"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"My cart is empty";
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

#pragma  mark 网络请求
- (void)getData{
    CartListModel *model=[[CartListModel alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model CartListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        CartListModel *model= (CartListModel *)data;
        if ([code intValue]==200) {
            self.dataArray=[NSMutableArray arrayWithArray:model.data.cart_info.products];
            
            code=model.data.currency.symbol;
            
            if ([self cherkDataIsNotAllSelect]) {
                self.allSellectedButton.selected=NO;
            }
            else
            {
                self.allSellectedButton.selected=YES;
            }
            [self getAllPrice];
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
- (void)upDataFromNetWithType:(NSString *)type item_id:(NSString *)item_id{
    
    UpdateCartModel *update=[[UpdateCartModel alloc]init];
    update.up_type=type;
    update.item_id=item_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [update UpdateCartModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
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
#pragma mark 按钮点击
//选中与不选中
- (void)selectBtnClick:(UIButton*)button {
    CartListModel *model = [self.dataArray objectAtIndex:button.tag];
    
    CartSelectModel *cart=[[CartSelectModel alloc]init];
    if ([model.active intValue]==0) {
        cart.checked=@"1";
    }
    else{
        cart.checked=@"0";
    }
    cart.type=@"one";
    cart.item_id=model.item_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [cart CartSelectModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
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
// 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    CartSelectModel *cart=[[CartSelectModel alloc]init];
    if (button.selected) {
        cart.checked=@"1";
    }
    else{
        cart.checked=@"0";
    }
    cart.type=@"all";
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [cart CartSelectModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
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
// 下单 批量删除
- (void)checkBtnClick {
    
    NSArray *arr=[self getSelectModelInArr];
    if (arr.count==0) {
        [MBProgressHUD showError:@"You haven't chosen  products yet~" toView:self.view];
        
    }
    else{
        
        if (edit_isno) {
            //批量删除
            NSMutableString * str=[NSMutableString string];
            for (int i=0;i<arr.count;i++) {
                CartListModel *model=arr[i];
                if ([model.active intValue]==1) {
                    [str appendString:model.item_id];
                }
                if (i!=arr.count-1) {
                    [str appendString:@","];
                }
            }
            
            [self upDataFromNetWithType:@"remove" item_id:str];
            
            
        }
        else
        {
            NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
            if (uid.length>0) {
                OderInfoNew  *one=[[OderInfoNew alloc]init];
                [self.navigationController pushViewController:one animated:YES];
                
                
            }
            else
            {
                [MBProgressHUD showMessage:nil toView:self.view];
                OrderInfoModel *info=[[OrderInfoModel alloc]init];
                 info.refresh=@"0";
                [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list ,id  _Nonnull payments,NSDictionary *contryDic) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([code intValue]==200) {
                        OrderInfoModel *model=(OrderInfoModel *)address_list;
                        
                        NSArray *arr=(NSArray *)model.address_list;
                        if (arr.count>0) {
                            OderInfoNewTwo *one=[[OderInfoNewTwo alloc]init];
                            [self.navigationController pushViewController:one animated:YES];
                        }
                        else
                        {
                            OderInfoNew  *one=[[OderInfoNew alloc]init];
                            [self.navigationController pushViewController:one animated:YES];
                     }
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
            
        }
    }
}
- (void)wishListPress{
    if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
        
        LoginViewController *log = [LoginViewController new];
        YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
        log.isPresent=@"2";
        [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
        
        return;
    }
    WishListViewController *list=[[WishListViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
    
}

- (void)addBtnClick:(UIButton*)button {
    CartListModel *model = [self.dataArray objectAtIndex:button.tag];
    [self upDataFromNetWithType:@"add_one" item_id:model.item_id];
}

- (void)cutBtnClick:(UIButton*)button {
    
    CartListModel *model = [self.dataArray objectAtIndex:button.tag];
    if ([model.qty intValue]<1) {
        return;
    }
    if ([model.qty intValue]==1) {
        [self upDataFromNetWithType:@"remove" item_id:model.item_id];
    }
    else
    {
        [self upDataFromNetWithType:@"less_one" item_id:model.item_id];
    }
    
}
- (void)rigthBtnClick {
    if (edit_isno == NO) {
        [rigthBtn setTitle:@"Complete" forState:UIControlStateNormal];
        edit_isno = YES;
        
        self.totlePriceLabel.hidden=YES;
        self.wishListBtn.hidden=NO;
        
        [self.checkBtn setTitle:@"Delete" forState:UIControlStateNormal];
        [self.checkBtn setBackgroundColor:Color(@"#CCCCCC")];
        
        [self.myTableView reloadData];
        
    } else {
        [rigthBtn setTitle:@"Edit" forState:UIControlStateNormal];
        edit_isno = NO;
        self.totlePriceLabel.hidden=NO;
        self.wishListBtn.hidden=YES;
        [self.checkBtn setTitle:@"CHECKOUT" forState:UIControlStateNormal];
        self.checkBtn.backgroundColor = Color(@"#F6AA00");
    }
}

#pragma mark 辅助方法
- (NSMutableAttributedString*)LZSetString:(NSString*)string {
    NSString *text = [NSString stringWithFormat:@"Subtotal  %@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"Subtotal  "];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:rang];
    return LZString;
}

-(BOOL)cherkDataIsNotAllSelect
{
    if (self.dataArray.count==0) {
        return YES;
    }
    for ( CartListModel *model  in self.dataArray) {
        if ([model.active intValue]==0) {
            return YES;
        }
    }
    return NO;
}
-(NSArray *)getSelectModelInArr
{
    NSMutableArray *arr=[NSMutableArray array];
    for ( CartListModel *model  in self.dataArray) {
        if ([model.active intValue]!=0) {
            [arr addObject:model];
        }
    }
    return arr;
}
- (void)getAllPrice{
    NSArray *arr=[self getSelectModelInArr];
    double price=0;
    
    for (CartListModel *model in arr) {
        price=price+ [model.product_price doubleValue]*[model.qty intValue];
    }
    
    NSString *money=[NSString stringWithFormat:@"%@%.2f",code ,price];
    
    self.totlePriceLabel.attributedText=  [self LZSetString:money];
    
}

@end
