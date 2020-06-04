//
//  OrderListViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderDetailViewController.h"
#import "OrderListModel.h"
#import "NOPayCancelModel.h"
#import "RAMReasonView.h"
#import "PayCancelModel.h"
#import <PayPalMobile.h>
#import "PaySuccess.h"
@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource,PayPalPaymentDelegate>
{
    NSInteger  page;
}
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@end

@implementation OrderListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.title = @"Order";
    
    
    [self setMainView];
    [self initRefresh];
}
- (void)initRefresh
{
    __block OrderListViewController * blockSelf = self;
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
    OrderListModel  *model=[[OrderListModel alloc]init];
    model.p=[NSString stringWithFormat:@"%d",(int)page];
    model.wxRequestOrderStatus=[NSString stringWithFormat:@"%d",(int)_flag+1];
    [model OrderListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        OrderListModel *list=( OrderListModel *)data;
        if ([code intValue]==200) {
            if (page ==1) {
                [self.dataSource removeAllObjects];
                if (list.data.orderList.count==0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    self.dataSource =[NSMutableArray arrayWithArray:list.data.orderList];
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }
            else
            {
                if (list.data.orderList.count==0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                    [self.dataSource addObjectsFromArray:list.data.orderList];
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
        //   [self.tableView.mj_footer endRefreshing];
    } andFailure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)setMainView{
    UITableView *tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = Color(@"#F5F5F5");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[OrderListTableViewCell class] forCellReuseIdentifier:@"OrderListCell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(ScreenHeight);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
        make.centerX.equalTo(self.view);
    }];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.001)];
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
    //
    if (_flag == 3 || _flag == 4){
        return 180;
    }else{
        return 240;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListTableViewCell *cell=[OrderListTableViewCell cellWithTableView:tableView];
    cell.dataSoucreDic =self.dataSource[indexPath.section];
    cell.CancelBtn.tag=indexPath.section;
    cell.PayBtn.tag=indexPath.row;
    [cell.CancelBtn addTarget:self action:@selector(CancelPress:) forControlEvents:UIControlEventTouchUpInside];
    [cell.PayBtn addTarget:self action:@selector(payPress:) forControlEvents:UIControlEventTouchUpInside];
    cell.flag = self.flag;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 10;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailViewController *de = [OrderDetailViewController new];
    de.flag = self.flag;
    OrderListModel  *model =self.dataSource[indexPath.section];
    de.order_id=model.order_id;
    de.cancellBlock = ^{
       page=1;
        [self.tableView .mj_header beginRefreshing];
        
    };
    [self.navigationController pushViewController:de animated:YES];
}
- (void)CancelPress:(UIButton *)btn{
    if (self.flag==0 ) {
        OrderListModel  *model= self.dataSource[btn.tag];
        NOPayCancelModel *cancel=[[NOPayCancelModel alloc]init];
        cancel.order_id=model.order_id;
        cancel.type=@"cancelorder";
        [MBProgressHUD showMessage:nil toView:self.view];
        [cancel NOPayCancelModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
            
            if ([code intValue]==200) {
                [self getData];
            }
            
        } andFailure:^(NSError * _Nonnull error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            
            
        }];
        
    }
    else if (self.flag==2||self.flag==1)
    {
        RAMReasonView *reason=[[RAMReasonView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        __block OrderListViewController * blockSelf = self;
        
        reason.block = ^(NSString * _Nonnull reason) {
            OrderListModel  *list= blockSelf.dataSource[btn.tag];
            PayCancelModel *model=[[PayCancelModel alloc]init];
            model.order_id=list.order_id;
            model.detail=reason;
            model.nickname= [[LoginModel shareInstance]getUserInfo].uinfo.nickname;
            model.email= [[LoginModel shareInstance]getUserInfo].uinfo.email;
            [MBProgressHUD showMessage:nil toView:blockSelf.view];
            [model PayCancelModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
                [MBProgressHUD hideAllHUDsForView:blockSelf.view animated:YES];
                [MBProgressHUD showSuccess:message toView:blockSelf.view];
                if ([code intValue]==200) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [blockSelf getData];
                    });
                }
                
            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:blockSelf.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:blockSelf.view];
                
            }];
        };
        [self.view.window addSubview:reason];
    }
    
}
- (void)payPress:(UIButton *)btn{
    if (self.flag==0 ) {
        OrderListModel  *model= self.dataSource[btn.tag];
//        if (  [model.payment_method isEqualToString:@"paypal_standard"]) {
            [self onClickPayPalButtonAction:model.order_id OrderMoney:model.grand_total OrderMoneyCode:model.order_currency_code];
            
   //     }
    }
}
- (void)onClickPayPalButtonAction:(NSString *)orderId OrderMoney:(NSString *) grand_total   OrderMoneyCode:(NSString *)moneyCode
{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    NSString *priceString = grand_total;
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:priceString];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = moneyCode;
    payment.shortDescription = @"order summary";
    payment.custom =orderId;//self.order.order_no;
    
    
    //  payment.shippingAddress=  [PayPalShippingAddress shippingAddressWithRecipientName:@"1" withLine1:@"2" withLine2:@"3" withCity:@"3" withState:@"3" withPostalCode:@"4" withCountryCode:@"5"];
    
       if (payment!=nil) {
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc]initWithPayment:payment configuration:self.payPalConfig delegate:self];
        
        paymentViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
}
#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
         [self dismissViewControllerAnimated:YES completion:nil];
         [MBProgressHUD showSuccess:@"PayPal Payment Success!" toView:self.view];
     
    
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         PaySuccess *pay=[[PaySuccess alloc]init];
         pay.order_id=completedPayment.custom;
         [self.navigationController pushViewController:pay animated:YES];
               });
    
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showSuccess:@"PayPal Payment failed!" toView:self.view];
    });
    
    
}
@end
