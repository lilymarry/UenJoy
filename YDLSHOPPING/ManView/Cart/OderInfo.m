//
//  OderInfo.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OderInfo.h"
#import "OderInforGoodCell.h"
#import "SelectAddressTwoCell.h"
#import "OderInforMoneyCell.h"
#import "OrderInfoModel.h"
#import "ChangeInfoModel.h"
#import "SetOrderModel.h"
#import "RestPayModel.h"
#import <Stripe.h>
#import "CreditCardList.h"
#import "PayModel.h"
#import "PaySuccess.h"
#import <PayPalMobile.h>
#import "SelectAddressTwo.h"
#import "OderInfoGoodList.h"
#import "PromoCode.h"
@interface OderInfo ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,STPAddCardViewControllerDelegate,PayPalPaymentDelegate>
{
  //  ChangeInfoModel  *mainModel;
    NSDictionary *cartInfo;
    
    NSString *  current_shipping_method;
    NSString *  current_payment_method;

    NSString *country;
    NSString * countryMoneyCode;
    NSString * cart_address_id;
    NSString * address;
    NSString * state;
    NSString *userName;
   // OrderInfoModel *mainInfo;
    
    NSString * product_total;
    NSString *  items_count;
    NSString *shipping_cost;
    NSString *grand_total;
    NSArray *goodList;
    
}
@property (strong,nonatomic)UITableView *myTableView;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong) NSArray *dataSource;
@end

@implementation OderInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Payment";
 
    [self setupTableView];
    
   // [self changeOrderInfo];
    
    [self getData];
    
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddCartDate:) name:@"AddCreditCard" object:nil];
     [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
}
- (void)getAddCartDate: (NSNotification *) notification {
    NSDictionary *dic=   notification.object;
    if ([dic  count]>0) {
        cartInfo =dic;
    }
}

- (void)getData{
    [MBProgressHUD showMessage:nil toView:self.view];
     OrderInfoModel *info=[[OrderInfoModel alloc]init];
     [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list  ,id  _Nonnull payments,NSDictionary *contryDic) {
         
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         if ([code intValue]==200) {
            OrderInfoModel *sumModel=(OrderInfoModel *)data;
            current_shipping_method= sumModel.data.current_shipping_method;
             current_payment_method=sumModel.data.current_payment_method;
               country=sumModel.data.country;
           countryMoneyCode=sumModel.data.currency_info.symbol;
          
        
             OrderInfoModel *model=(OrderInfoModel *)address_list;
                self.dataSource =[NSArray arrayWithArray:(NSArray *)model.address_list];
             
             
             if ( self.dataSource.count>0) {
                 for (  OrderInfoModel *model in self.dataSource ) {
                     if ([model.is_default intValue]==1) {
                  cart_address_id=model.address_info.address_id;
                       address=model.address;
                       userName=[NSString stringWithFormat:@"%@%@   %@",model.address_info.last_name,model.address_info.first_name,model.address_info.telephone];
                     }
                 }
             }
           
           product_total=  sumModel.data.cart_info.product_total;
             items_count=sumModel.data.cart_info .items_count;
            shipping_cost= sumModel.data.cart_info.shipping_cost;
            grand_total= sumModel.data.cart_info.grand_total;
            goodList=[NSArray arrayWithArray:sumModel.data.cart_info.products];
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


- (void)changeOrderInfo{
  
    ChangeInfoModel  *model=[[ChangeInfoModel alloc]init];
    model.country=country;
    model.address_id=cart_address_id;
    model.state=state;
    model.shipping_method=current_shipping_method;
    [MBProgressHUD showMessage:nil toView:self.view];

    [model ChangeInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

         
         if ([code intValue]==200) {
             ChangeInfoModel  *sumModel =(  ChangeInfoModel  *) data;
       
           product_total=  sumModel.data.cart_info.product_total;
            items_count=sumModel.data.cart_info .items_count;
                      shipping_cost= sumModel.data.cart_info.shipping_cost;
                      grand_total= sumModel.data.cart_info.grand_total;
         
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
- (void)setupTableView {
    //创建底部视图
    
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Submit" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];

    [footerBtn setBackgroundColor:Color(@"#F6AA00")];
    footerBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
    [self.view addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.height.offset(50);
        make.bottom.offset(0);
    }];
    
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, ScreenHeight-NaviBarAndStatusBarHeight-50) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    
    table.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    self.myTableView = table;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTwoCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTwoCell"];

    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OderInforGoodCell class]) bundle:nil] forCellReuseIdentifier:@"OderInforGoodCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OderInforMoneyCell class]) bundle:nil] forCellReuseIdentifier:@"OderInforMoneyCell"];
    
}
- (void)submitPress{
    
//    if (cartInfo.count==0) {
//           [MBProgressHUD showSuccess:@"Please choose payment" toView:self.view];
//        return;
//
//    }
     
    if (cart_address_id.length==0) {
            [MBProgressHUD showSuccess:@"Please choose address" toView:self.view];
    }
    
    [self onClickPayPalButtonAction];
      /*
    SetOrderModel *model=[[SetOrderModel alloc]init];
    model.address_id=cart_address_id;
    model.create_account=@"0";
    model.payment_method=    @"paypal_standard";//_current_payment_method;

    model.shipping_method=current_shipping_method;
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:cartInfo[@"first_name"] forKey:@"first_name"];
    [dic setValue:cartInfo[@"last_name"] forKey:@"last_name"];
       [dic setValue:cartInfo[@"email"] forKey:@"email"];
    
    [dic setValue:cartInfo[@"telephone"] forKey:@"telephone"];
    [dic setValue:cartInfo[@"street1"] forKey:@"street1"];
    [dic setValue:cartInfo[@"street2"] forKey:@"street2"];
      [dic setValue:cartInfo[@"country"] forKey:@"country"];
    
     [dic setValue:cartInfo[@"state"] forKey:@"state"];
     [dic setValue:cartInfo[@"city"] forKey:@"city"];
     [dic setValue:cartInfo[@"zip"] forKey:@"zip"];
  
    model.billing=[ExchangToJsonData dicToJSONString:dic];
    [MBProgressHUD showMessage:nil toView:self.view];

    [model SetOrderModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            SetOrderModel *model=(SetOrderModel *)data;
            RestPayModel *pay =[[RestPayModel  alloc]init];
            pay.in_id=  model.data.in_id;
             [MBProgressHUD showMessage:nil toView:self.view];
            [pay RestPayModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                if ([code intValue]==200) {
                    RestPayModel *pa = (  RestPayModel *)data;
                    
                    [[STPPaymentConfiguration sharedConfiguration]setPublishableKey:pa.data.public_key];
                    //@"pk_test_AYYdDVg4ZRCKkTjb5p26lZcb00QaX96v2p"
                    
                    [self stripePay:pa.data in_id: model.data.in_id];
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
     */
  
}
- (void)stripePay:(RestPayModel *)pay in_id:(NSString *)in_id{
    
    NSArray *arr=[cartInfo[@"expires"] componentsSeparatedByString:@"/"];
    STPCardParams *cart=[[STPCardParams alloc]init];
    cart.number=cartInfo[@"cartNum"];
    cart.expYear=[arr[1] integerValue];
    cart.expMonth=[arr[0] integerValue];
    cart.cvc=cartInfo[@"cvv"];
    [[STPAPIClient sharedClient] createTokenWithCard:cart completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        NSLog(@"STPCardParams %@",token);
        if (!error) {
            PayModel *model=[[PayModel alloc]init];
            model.client_id=pay.client_id;
            model.in_id=in_id;
            model.stripeToken=[NSString stringWithFormat:@"%@",token];
            model.cmail=pay.client_mail;
            model.order_id=pay.order_id;
            [model PayModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
                if ([code intValue]==200) {
                    PaySuccess  *success=[[PaySuccess alloc]init];
                    [self.navigationController pushViewController:success animated:YES];
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
        else{
              [MBProgressHUD showSuccess:@"The card does not support payment temporarily" toView:self.view];
        }
    }];

}
- (void)paymentPress{
   
    CreditCardList *list =[[CreditCardList alloc]init];
    list.selectAddressId=cart_address_id;
    list.block = ^(NSDictionary * _Nonnull data) {
         if ([data  count]>0) {
             cartInfo =data;
           }
    };
    [self.navigationController pushViewController:list animated:YES];
    
}
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return 1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 250;
    }
    else if (indexPath.section==1)
    {
        return 228;
    }
    else
    {
        return 217;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        SelectAddressTwoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressTwoCell"];
           cell.cellTitleLab.text=@"Confirm payment information";
        if (cart_address_id.length==0) {
             cell.labView.hidden=YES;
             [cell.addBtn setTitle:@"+ Add a New Address" forState:UIControlStateNormal];
        }
        else
        {
             cell.labView.hidden=NO;
            cell.titleLab.text=userName;
            cell.subTitleLab.text=address;
            [cell.addBtn setTitle:@"" forState:UIControlStateNormal];
        }
    [cell.addBtn addTarget:self action:@selector(addAdressPress) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else  if (indexPath.section==1)
    {
        OderInforGoodCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforGoodCell"];
       
        OrderInfoModel *model=   goodList[0];
         NSString* encodedString =[model.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        [cell.goodsImagView1  sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
     if (goodList.count>1) {
                        OrderInfoModel *model1=   goodList[1];
                 NSString* encodedString1 =[model1.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
                [cell.goodsImagView2  sd_setImageWithURL:[NSURL URLWithString:encodedString1] placeholderImage:[UIImage imageNamed:@"null-picture"]];
        }
        
        
        cell.itemNumLab.text=[NSString stringWithFormat:@"%d items",[items_count intValue]]
        ;
    ///    cell.paymentLab.text=_current_payment_method;
        [cell.paymentBtn addTarget:self action:@selector(paymentPress) forControlEvents:UIControlEventTouchUpInside];
         [cell.goodListBtn addTarget:self action:@selector(goodListPress) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.PromoCodebBtn addTarget:self action:@selector(PromoCodePress) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        OderInforMoneyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforMoneyCell"];
        
        cell.totalLab.text=[NSString stringWithFormat:@"%@%.2f ",countryMoneyCode,[product_total doubleValue]];
       cell.shipLab.text=[NSString stringWithFormat:@"%@%.2f ",countryMoneyCode,[shipping_cost doubleValue]];
        
    cell.orderTotalLab.text=[NSString stringWithFormat:@"%@%.2f ",countryMoneyCode,[grand_total doubleValue]];
        return  cell;
    }
    
}

#pragma mark - PaypalSDK支付
- (void)onClickPayPalButtonAction
{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = NO;
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    NSString *priceString = @"0.01";
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:priceString];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"test";
    payment.custom = @"123456789";//self.order.order_no;
    
  
    payment.shippingAddress=  [PayPalShippingAddress shippingAddressWithRecipientName:@"1" withLine1:@"2" withLine2:@"3" withCity:@"3" withState:@"3" withPostalCode:@"4" withCountryCode:@"5"];
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc]initWithPayment:payment configuration:self.payPalConfig delegate:self];
    
    paymentViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:paymentViewController animated:YES completion:nil];
}


#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:kNoticePaidSuccess object:@"paypal"userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddCreditCard" object:nil];
}
- (void)addAdressPress{
    SelectAddressTwo *one =[[SelectAddressTwo alloc]init];
  //  one.type=@"2";
    one.block = ^(NSString * _Nonnull addressId, NSString * _Nonnull countryStr, NSString * _Nonnull stateStr,NSString * user,NSString *addressStr ) {
        
        cart_address_id=addressId;
       state=stateStr;
       country=countryStr;
       userName=user;
        address=addressStr;
        [self changeOrderInfo];
    };
    [self.navigationController pushViewController:one animated:YES];
}
- (void)goodListPress{
    OderInfoGoodList *list=[[OderInfoGoodList alloc]init];
     list.dataArray=goodList;
    list.code=countryMoneyCode;
    [self.navigationController pushViewController:list animated:YES];
    
}
- (void)PromoCodePress{
    PromoCode *code =[[PromoCode alloc]init];
    [self.navigationController pushViewController:code animated:YES];
}
@end
