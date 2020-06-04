//
//  OderInfoNewTwo.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OderInfoNewTwo.h"
#import "OderInforGoodHeaderCell.h"
#import "OderInforGoodContentCell.h"
#import "OderInforGoodFootCell.h"
#import "ContactInforCell.h"
#import "PaymentCell.h"
#import "BillingAddressCell.h"
#import "OrderInfoModel.h"
#import "SelectAddress.h"
#import <PayPalMobile.h>
#import "HooDatePicker.h"
#import "ChangeInfoModel.h"
#import "SelectAddressTopCell.h"
#import "GetAddressInfoModel.h"
#import "ChangeCountryModel.h"
#import "PickView.h"
#import "SetOrderModel.h"
#import "AddCouponModel.h"
#import "PaySuccess.h"
@interface OderInfoNewTwo ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PayPalPaymentDelegate,HooDatePickerDelegate,PickViewDelegate>
{
  //  NSString *countryMoneyCode;
    NSString *grand_total;
    BOOL isShow;
    BOOL isContact;
    NSString *cntactEmail;
    
    
    NSString *payType;
    NSString *expires;
    NSString *cartNum;
    NSString *cvv;
    
    OrderInfoModel * currency_info;
    OrderInfoModel * cart_address;
    NSString *current_shipping_method;
    NSString * current_payment_method;
    
    BOOL isBilling;
    
    
    
    NSString *firstName;
    NSString *lastName;
    NSString * billingContry;//账单国家
    NSString * address1;
    NSString * address2;
    NSString * code;
    NSString * city;
    NSString * billingState;//账单区域
    NSString * email;
    NSString *phone;
    
    NSString * billingContryCode;
    NSString * billingStateCode;
    
    
    NSString *shipping_cost;
    NSString *coupon_code;
    NSString *coupon_cost;
    NSString *countryCode;//收货国家简称
    NSString *contryName;//收货国家名字
    NSString *stateCode;//区域简称
    
    NSString *useCouponType;// 优惠券 1 使用 0 不使用
    
}
@property (nonatomic, strong) HooDatePicker *datePicker1;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *goodList;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property (nonatomic, strong) NSMutableArray *countryArr;
@property (nonatomic, strong) NSMutableArray *stateArr;
@end

@implementation OderInfoNewTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Payment";
    
    [self setupTableView];
    
    useCouponType=@"0";
    [self getDataWithType:@"0" andRelistType:@"0"];
    isShow=YES;
    
    
    isContact=NO;
    cntactEmail=[[NSUserDefaults standardUserDefaults] objectForKey:@"cntactEmail"];
    
    if (cntactEmail.length==0) {
        isContact=YES;
    }
    
    self.datePicker1 = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker1.delegate = self;
    
    self.datePicker1.datePickerMode = HooDatePickerModeYearAndMonth;
    
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
    NSString *str= [self stringFromDate:[NSDate date]andDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [dateFormatter dateFromString:str];
    [ self.datePicker1 setDate:[NSDate date] animated:YES];
    self.datePicker1.minimumDate = minDate;
    self.datePicker1.maximumDate = maxDate;
    expires=@"";
    cartNum=@"";
    
    isBilling=YES;
    self.countryArr =[NSMutableArray array];
    self.stateArr=[NSMutableArray array];
    [self getAddressData];
    
}
- (void)setupTableView {
    //创建底部视图
    
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Complete order" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];
    
    [footerBtn setBackgroundColor:Color(@"#F6AA00")];
    footerBtn.titleLabel.font=font(15);
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OderInforGoodHeaderCell class]) bundle:nil] forCellReuseIdentifier:@"OderInforGoodHeaderCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OderInforGoodContentCell class]) bundle:nil] forCellReuseIdentifier:@"OderInforGoodContentCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OderInforGoodFootCell class]) bundle:nil] forCellReuseIdentifier:@"OderInforGoodFootCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactInforCell class]) bundle:nil] forCellReuseIdentifier:@"ContactInforCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PaymentCell class]) bundle:nil] forCellReuseIdentifier:@"PaymentCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BillingAddressCell class]) bundle:nil] forCellReuseIdentifier:@"BillingAddressCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTopCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTopCell"];
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    
    tapGestureRecognizer.cancelsTouchesInView =NO;
    
    [self.myTableView addGestureRecognizer:tapGestureRecognizer];
    
}
- (void)getAddressData{
    GetAddressInfoModel * info=[[GetAddressInfoModel alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [info GetAddressInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,NSDictionary *data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            
            [data[@"countryArr"] enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                [dic setValue:obj forKey:@"value"];
                [dic setValue:key forKey:@"key"];
                [self.countryArr addObject:dic];
                
            }];
            
            [data[@"stateArr"] enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                [dic setValue:obj forKey:@"value"];
                [dic setValue:key forKey:@"key"];
                [self.stateArr addObject:dic];
                
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
}


- (void)getDataWithType:(NSString *)type andRelistType:(NSString *)relistType {
    [MBProgressHUD showMessage:nil toView:self.view];
    OrderInfoModel *info=[[OrderInfoModel alloc]init];
     info.refresh=type;
    [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list  ,id  _Nonnull payments,NSDictionary *contryDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            OrderInfoModel *sumModel=(OrderInfoModel *)data;
          
            currency_info=sumModel.data.currency_info;
          shipping_cost=sumModel.data.cart_info.shipping_cost;
            
           grand_total= sumModel.data.cart_info.grand_total;
            self.goodList=[NSArray arrayWithArray:sumModel.data.cart_info.products];
            current_shipping_method=sumModel.data.current_shipping_method;
           
         
           coupon_cost=sumModel.data.cart_info.coupon_cost;
           countryCode=sumModel.data.country;
            if (contryDic!=nil) {
                contryName=contryDic[countryCode];
            }
           
            
            if (contryName.length==0) {
                  contryName=sumModel.data.country;
                if (contryDic!=nil) {
                     countryCode=[contryDic allKeys][0] ;
                }
                  
            }
            
            
            if ([relistType isEqualToString:@"0"]) {
                  OrderInfoModel *model=(OrderInfoModel *)address_list;
                          
                          NSArray *arr=(NSArray *)model.address_list;
                          if (arr.count>0) {
                              for (  OrderInfoModel *model in arr) {
                                  if ([model.is_default intValue]==1) {
                                     cart_address=model;
                                      break;
                                  }
                              }
                          }
            }
            else
            {
               [self changeOrderInfoWithContry:countryCode state:stateCode];
            }
          
            
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
- (void)changeOrderInfoWithContry:(NSString *)country state:(NSString *)state{
   //更新地址后 计算运费
    ChangeInfoModel  *model=[[ChangeInfoModel alloc]init];
    model.country=country;
    model.address_id=cart_address.address_info.address_id;
    model.state=state;
    model.shipping_method=current_shipping_method;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model ChangeInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data)
     {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        if ([code intValue]==200) {
            ChangeInfoModel  *sumModel =(  ChangeInfoModel  *) data;
        
           grand_total= sumModel.data.cart_info.grand_total;
           shipping_cost=sumModel.data.cart_info.shipping_cost;
            
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
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isBilling) {
        return 4;
    }
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if (isShow) {
            return self.goodList.count+2;
        }
        return 1;
    }
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 44;
        }
        else
        {
            if (indexPath.row>0&&indexPath.row<self.goodList.count+1) {
                return 94;
            }
            else
            {
                return 186;
            }
        }
        
    }
    else if (indexPath.section==1)
    {
        return 245;
    }
    else if (indexPath.section==2)
    {
        return 120;
       // return 342;
    }
    else if (indexPath.section==3)
    {
        
        if (isBilling) {
            return 174;
        }
        else
        {
            return 66;
        }
    }
    else
    {
        return 564;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            OderInforGoodHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforGoodHeaderCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.moneyLab.text=[NSString stringWithFormat:@"%@%@",currency_info.symbol,grand_total];
            [cell.showBtn addTarget:self action:@selector(showPress) forControlEvents:UIControlEventTouchUpInside];
            if (isShow) {
                cell.imagViewFlag.image=[UIImage imageNamed:@"灰色下箭头"];
            }
            else
            {
                cell.imagViewFlag.image=[UIImage imageNamed:@"灰色上箭头"];
            }
            return cell;
        }
        else
        {
            
            
            if (indexPath.row>0&&indexPath.row<self.goodList.count+1) {
                OderInforGoodContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforGoodContentCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                OrderInfoModel *model =    self.goodList[indexPath.row-1];
                
                NSString* encodedString =[model.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
                [ cell.lzImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
                
                cell.nameLabel.text = model.name;
                cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",currency_info.symbol,model.product_price];
                cell.sizeLabel.text =[NSString stringWithFormat:@"product_weight:%@",model.product_weight];
                cell.numberLabel.text = [NSString stringWithFormat:@"x%d",(int)[model.qty intValue]];
                
                return cell;
            }
            else
            {
                OderInforGoodFootCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforGoodFootCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.totalLab.text=[NSString stringWithFormat:@"%@%@",currency_info.symbol,grand_total];
                   cell.discountLab.text=[NSString stringWithFormat:@"You’re saved %@%.2f",currency_info.symbol,[coupon_cost doubleValue]];
                if ([shipping_cost doubleValue]==0) {
                    cell.shipping_costLab.text=@"Free Shipping";
                }
                else
                {
                    cell.shipping_costLab.text= [NSString stringWithFormat:@"%@%.2f",currency_info.symbol,[shipping_cost doubleValue]];
                }
                cell.couponTf.tag=5002;
                             cell.couponTf.text=coupon_code;
                             cell.couponTf.delegate=self;
                             [cell.couponBtn addTarget:self action:@selector(addCoupon) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            
        }
        
        
    }
    
    else  if(indexPath.section==1)
    {
        ContactInforCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContactInforCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contactTf.text= cntactEmail;
        cell.contactTf.delegate=self;;
        cell.contactTf.tag=2002;
        
        
        if (isContact) {
            cell.contactTf.borderStyle=UITextBorderStyleRoundedRect;
            cell.contactTf.enabled=YES;
        }
        else{
            cell.contactTf.borderStyle=UITextBorderStyleNone;
            cell.contactTf.enabled=NO;
        }
        [cell.btn1 addTarget:self action:@selector(contactPress) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(changeAddressPress) forControlEvents:UIControlEventTouchUpInside];
        cell.lab2.text=[NSString stringWithFormat:@"%@ %@ %@",cart_address.address_info.first_name,cart_address.address_info.last_name,cart_address.address_info.telephone];
        cell.lab1.text=[NSString stringWithFormat:@"%@\n%@ %@ %@ %@",cart_address.address_info.street1,cart_address.address_info.city,cart_address.address_info.state,contryName,cart_address.address_info.zip];
        return  cell;
    }
    else  if(indexPath.section==2)
    {
        PaymentCell*cell=[tableView dequeueReusableCellWithIdentifier:@"PaymentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([payType isEqualToString:@"payPal"]) {
            cell.payPalImagView.image=[UIImage imageNamed:@"payment-icon-choice"];
            cell.CreditcardImageView.image=[UIImage imageNamed:@"payment-icon-nochoice"];
        }
        else  if ([payType isEqualToString:@"Creditcard"]) {
            cell.payPalImagView.image=[UIImage imageNamed:@"payment-icon-nochoice"];
            cell.CreditcardImageView.image=[UIImage imageNamed:@"payment-icon-choice"];
        }
        else
        {
            cell.payPalImagView.image=[UIImage imageNamed:@"payment-icon-nochoice"];
            cell.CreditcardImageView.image=[UIImage imageNamed:@"payment-icon-nochoice"];
        }
        cell.dateTf.text=expires;
        cell.dateTf.delegate=self;
        [cell.payPalBtn addTarget:self action:@selector(payPalPress) forControlEvents:UIControlEventTouchUpInside];
        [cell.CreditcardBtn addTarget:self action:@selector(CreditcardPress) forControlEvents:UIControlEventTouchUpInside];
        [cell.dateBtn addTarget:self action:@selector(datePrees) forControlEvents:UIControlEventTouchUpInside];
        cell.CreditcardTf.text=cartNum;
        cell.CreditcardTf.tag=2000;
        cell.CreditcardTf.delegate=self;
        
        cell.cvvTf.text=cvv;
        cell.cvvTf.delegate=self;
        cell.cvvTf.tag=2001;
        
        return  cell;
    }
    else  if(indexPath.section==3)
    {
        BillingAddressCell*cell=[tableView dequeueReusableCellWithIdentifier:@"BillingAddressCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (isBilling) {
            cell.lab2.text=[NSString stringWithFormat:@"%@ %@ %@",cart_address.address_info.first_name,cart_address.address_info.last_name,cart_address.address_info.telephone];
            cell.lab1.text=[NSString stringWithFormat:@"%@\n%@ %@ %@ %@",cart_address.address_info.street1,cart_address.address_info.city,cart_address.address_info.state,contryName,cart_address.address_info.zip];
        }
        if (isBilling) {
            [cell.switchBtn setOn:YES];
        }
        else
        {
            [cell.switchBtn setOn:NO];
        }
        [cell.switchBtn addTarget:self action:@selector(billingAddressSwitchChange:) forControlEvents:UIControlEventValueChanged];
        return  cell;
    }
    else
    {
        
        SelectAddressTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressTopCell"];
        cell.topHH.constant=0;
        cell.titleLab.text=@"Billing Address";
                   cell.firstName_tf.text= firstName;
                    cell.lastName_tf.text= lastName;
                    cell. contry_lab.text=billingContry;
                    cell.address1_tf.text=address1;
                    cell.address2_tf.text=address2;
                    cell.code_tf.text=code;
                    cell.city_tf.text=city;
                    cell.state_lab.text=billingState;
                    cell.email_tf.text=email;
                    cell.phone_tf.text=phone;
        
                    cell.firstName_tf.delegate=self;
                        cell.lastName_tf.delegate=self;
                        cell.address1_tf.delegate=self;
                        cell.address2_tf.delegate=self;
                        cell.code_tf.delegate=self;
                        cell.city_tf.delegate=self;
                        cell.email_tf.delegate=self;
                     cell.phone_tf.delegate=self;
        
        
                    [cell.contryBtn addTarget:self action:@selector(contryPress) forControlEvents:UIControlEventTouchUpInside];
                    [cell.stateBtn addTarget:self action:@selector(statePress) forControlEvents:UIControlEventTouchUpInside];
    
        cell.saveBtn.hidden=YES;
        return cell;
    }
}
- (void)selectRow:(NSDictionary *)data type:(NSString *)type
{
    if ([type isEqualToString:@"contry"]) {
    
       billingContry=data[@"value"];
        billingContryCode=data[@"key"];
        [self changeContryListConntry:data[@"key"]];
        billingState=nil;
        
    }
    else
    {
        billingState=data[@"value"];
        billingStateCode=data[@"key"];
    }
    [self.myTableView reloadData];
}
- (void)changeContryListConntry:(NSString *)contr{
    ChangeCountryModel *model=[[ChangeCountryModel alloc]init];
    model .country=contr;
    [model ChangeCountryModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSDictionary * _Nonnull data) {
        if ([code intValue]==200) {
            [data[@"stateArr"] enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                [dic setValue:obj forKey:@"value"];
                [dic setValue:key forKey:@"key"];
                [self.stateArr addObject:dic];
                
            }];
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1000:
            firstName=textField.text;
            break;
        case 1001:
            lastName=textField.text;
            break;
        case 1002:
            address1=textField.text;
            break;
        case 1003:
            address2=textField.text;
            break;
        case 1004:
            code=textField.text;
            break;
        case 1005:
            city=textField.text;
            break;
        case 1006:
            email=textField.text;
            break;
        case 1007:
            phone=textField.text;
            break;
           
            case 2000:
                       cartNum = textField.text;
                       break;
                   case 2001:
                       
                       cvv=textField.text;
                       break;
                   case 2002:
        {
            if (textField.text.length>0) {
                 cntactEmail=textField.text;
                               isContact=NO;
                                 [[NSUserDefaults standardUserDefaults] setObject:cntactEmail forKey:@"cntactEmail"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
            }
              
        }
                    
            
            break;
            case 5002:
                                coupon_code=textField.text;
                                break;
        default:
            break;
    }

    [self.myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    return YES;
}

- (void)keyboardHide
{
    [self.view endEditing:YES];
    
}
- (void)contryPress{
    PickView *pick =[[PickView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
           [pick loadPick:self.countryArr andType:@"contry"];
            pick.delegate=self;
    
          [self.view.window addSubview:pick];
}
- (void)statePress{
    PickView *pick =[[PickView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
          [pick loadPick:self.stateArr andType:@"state"];
         pick.delegate=self;
 
        [self.view.window addSubview:pick];
}
- (void)billingAddressSwitchChange:(UISwitch *)sender{
    if (sender.on) {
        isBilling=YES;
        
    }
    else
    {
        isBilling=NO;
        
    }
    
    
    [self.myTableView reloadData];
}
- (void)addCoupon{
    if (coupon_code.length==0) {
          [MBProgressHUD showSuccess:@"Discount cannot be empty" toView:self.view];
              
              return;
    }
    AddCouponModel *model=[[AddCouponModel alloc]init];
    model.coupon_code=coupon_code;
     [MBProgressHUD showMessage:nil toView:self.view];
    [model AddCouponModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message)
    {  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      [MBProgressHUD showSuccess:message toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if ([code intValue]==200) {
                          useCouponType=@"1";
                        [self getDataWithType:@"1" andRelistType:@"0"];
                           }
                  });

    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
               [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)payPalPress{
    payType =@"payPal";
    current_payment_method=@"paypal_standard";
    [self.myTableView reloadData];
}
- (void)CreditcardPress{
    payType =@"Creditcard";
     current_payment_method=@"asiabill_creditcard";
    [self.myTableView reloadData];
}
- (void)datePrees{
    [self.datePicker1 show];
}
- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date WithFlag:(NSString *)flag {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else if (datePicker.datePickerMode == HooDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"MM/yy"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    
    expires=  [dateFormatter stringFromDate:date];
    
    if ([self compareOneDay:expires withAnotherDay:[self stringFromDate:[NSDate date]andDateFormat:@"MM/yy"]]==-1) {
        [MBProgressHUD showError:@"Expires is wrong" toView:self.view];
        return;
    }
  //  payType =@"Creditcard";
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:2];
    [self.myTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    [self.datePicker1 dismiss];
    
    
    
}
-(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/yy"];
    
    
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //   NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //  NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    // NSLog(@"两者时间是同一个时间");
    return 0;
}
- (NSString *)stringFromDate:(NSDate *)date andDateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // [dateFormatter setDateFormat:@"MM/yy"];
    [dateFormatter setDateFormat:dateFormat];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //判断是否是当前输入框
    if (textField.tag==2000) {
        NSString *text = textField.text;
        //限制字符 至于那个\b用在search中 写不写都行
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        //去掉空格
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        //检查除数字之外的字符 invertedSet:意思是取反,除了数字和退格的内容
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        //拼接text 要输入的部分+原有的
        text = [text stringByReplacingCharactersInRange:range withString:string];
        //去空格
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * newString = @"";
        //四位添加空格
        while (text.length > 0) {
            NSString * subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        //去掉除数字部分
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }
        //赋值
        [textField setText:newString];
        return NO;
    }
    return YES;
}



- (void)submitPress{

    if (cntactEmail.length==0) {
         [MBProgressHUD showSuccess:@"Contact cannot empty" toView:self.view];
               return;
    }
    if (current_payment_method.length==0) {
           [MBProgressHUD showSuccess:@"Payment cannot empty" toView:self.view];
                    return;
    }
    BOOL result1=  [HelpCommon  validateEmail:cntactEmail];
                  if (result1==NO) {
                      [MBProgressHUD showSuccess:@"Please enter the correct Contact" toView:self.view];
                      return;
                  }
    if (isBilling==NO)
    {   NSInteger index= [self cherkNUll];

                          if (index!=8000) {

                              [MBProgressHUD showSuccess:@"Someone is empty" toView:self.view];
                              
                              NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:4];
                              SelectAddressTopCell *cell=(SelectAddressTopCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                              [cell setTitleNoSelect:[NSString stringWithFormat:@"%ld",(long)index]];
                              return;
                          }
        
        BOOL result=  [HelpCommon  validateEmail:email];
        if (result==NO) {
            [MBProgressHUD showSuccess:@"Please enter the correct email address" toView:self.view];
            return;
        }
    }
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    if (uid.length>0) {
        [MBProgressHUD showSuccess:@"Need to log in first" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self    loginPress];
        });
       
        
    }
    else
    {
        [self setOrderWithPayType:current_payment_method];
    }
    
}
- (void) setOrderWithPayType:(NSString*)payType{
     SetOrderModel *model=[[SetOrderModel alloc]init];
     model.address_id=cart_address.address_info.address_id;;
      
    model.payment_method= payType;

       model.shipping_method=current_shipping_method;
       NSMutableDictionary *dic=[NSMutableDictionary dictionary];
       [dic setValue:cart_address.address_info.first_name forKey:@"first_name"];
       [dic setValue:cart_address.address_info.last_name forKey:@"last_name"];
          [dic setValue:cart_address.address_info.email forKey:@"email"];
       
       [dic setValue:cart_address.address_info.telephone forKey:@"telephone"];
       [dic setValue:cart_address.address_info.street1 forKey:@"street1"];
       [dic setValue:cart_address.address_info.street2 forKey:@"street2"];
        [dic setValue:countryCode forKey:@"country"];
       
        [dic setValue:cart_address.address_info.state forKey:@"state"];
        [dic setValue:cart_address.address_info.city forKey:@"city"];
        [dic setValue:cart_address.address_info.zip forKey:@"zip"];
     
       model.billing=[ExchangToJsonData dicToJSONString:dic];
    
    
    if (isBilling) {
       model.billing_address=[ExchangToJsonData dicToJSONString:dic];
    }
    else
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:firstName forKey:@"first_name"];
        [dic setValue:lastName forKey:@"last_name"];
        [dic setValue:email forKey:@"email"];
             
             [dic setValue:phone forKey:@"telephone"];
             [dic setValue:address1 forKey:@"street1"];
             [dic setValue:address2 forKey:@"street2"];
              [dic setValue:billingContryCode forKey:@"country"];
              [dic setValue:billingStateCode forKey:@"state"];
              [dic setValue:city forKey:@"city"];
              [dic setValue:code forKey:@"zip"];
         model.billing_address=[ExchangToJsonData dicToJSONString:dic];
    }
    
    model.contact_email=cntactEmail;
       [MBProgressHUD showMessage:nil toView:self.view];

       [model SetOrderModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           if ([code intValue]==200) {
               
                 SetOrderModel *model=(SetOrderModel *)data;
               if ([payType isEqualToString:@"paypal_standard"]) {
                    [self onClickPayPalButtonAction:model.data.in_id];
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
- (void)onClickPayPalButtonAction:(NSString *)orderId
{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;//接受信用卡支付
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    NSString *priceString = grand_total;
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:priceString];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = currency_info.code;
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
    NSLog(@"PayPal Payment Success!");
 
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
- (void)showPress{
    isShow=!isShow;
    [self.myTableView reloadData];
}
- (void)contactPress{
    
    if (isContact) {
        isContact=NO;
        [[NSUserDefaults standardUserDefaults] setObject:cntactEmail forKey:@"cntactEmail"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        isContact=YES;
    }
    [self.myTableView reloadData];
}
- (void)loginPress{
    LoginViewController *log = [LoginViewController new];
    YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
    log.isPresent=@"2";
    [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
}

- (void)changeAddressPress{
    SelectAddress *address=[[SelectAddress alloc]init];
    address.block = ^(NSString * _Nonnull contry, NSString * _Nonnull state) {
        countryCode=contry;
        stateCode=state;
        [self getDataWithType:useCouponType andRelistType:@"0"];
    };

    [self.navigationController pushViewController:address animated:YES];
}
- (NSInteger )cherkNUll{

      NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
       [dic1 setValue:firstName forKey:@"name"];
    
    NSMutableDictionary *dic2=[NSMutableDictionary dictionary];
         [dic2 setValue:lastName forKey:@"name"];
    
    NSMutableDictionary *dic3=[NSMutableDictionary dictionary];
         [dic3 setValue:billingContry forKey:@"name"];
    
    NSMutableDictionary *dic4=[NSMutableDictionary dictionary];
         [dic4 setValue:address1 forKey:@"name"];
    
    NSMutableDictionary *dic5=[NSMutableDictionary dictionary];
         [dic5 setValue:code forKey:@"name"];
    
    NSMutableDictionary *dic6=[NSMutableDictionary dictionary];
         [dic6 setValue:city forKey:@"name"];
    
    NSMutableDictionary *dic7=[NSMutableDictionary dictionary];
         [dic7 setValue:billingState forKey:@"name"];
    
    NSMutableDictionary *dic8=[NSMutableDictionary dictionary];
         [dic8 setValue:email forKey:@"name"];
    
    NSMutableDictionary *dic9=[NSMutableDictionary dictionary];
         [dic9 setValue:phone forKey:@"name"];
    
     NSArray *arr=[NSArray arrayWithObjects: dic1,dic2, dic3, dic4, dic5, dic6 ,dic7, dic8, dic9, nil];
   
    if (arr.count>0) {
        BOOL isExit=NO;
          for (int i=0; i<arr.count; i++) {
              NSDictionary *dic =arr[i];
              if ([dic[@"name"] length]==0) {
                  isExit=YES;
                  return i;

              }
          }
        if (isExit==NO && arr.count==9) {
            return 8000;
        }
      return 0;
    }
    else
    {
          return 0;
    }
    
}
@end
