//
//  OderInfoNew.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OderInfoNew.h"
#import "OderInforGoodHeaderCell.h"
#import "OderInforGoodContentCell.h"
#import "OderInforGoodFootCell.h"
#import "SelectAddressTopCell.h"
#import "OrderInfoModel.h"
#import "ContactCell.h"
#import "GetAddressInfoModel.h"
#import "ChangeCountryModel.h"
#import "PickView.h"
#import "OderInfoNewTwo.h"
#import "TouristChangecontry.h"
#import "SaveAdressModel.h"
#import "AddCouponModel.h"
@interface OderInfoNew ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PickViewDelegate>
{
       BOOL isShow;//商品缩放

       NSString *firstName;
       NSString *lastName;
       NSString * contry;
       NSString * address1;
       NSString * address2;
       NSString * code;
       NSString * city;
       NSString * state;
       NSString * email;
       NSString *phone;
    
    NSString *grand_total;
    NSString *countryMoneyCode;
    
    NSString *cntactEmail;
    
    NSString * contryCode;
    NSString * stateCode;
    
    BOOL saveAddress;
    
    NSString *shipping_cost;
    
    NSString *coupon_code;
    
    NSString * coupon_cost;
  
    
}
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *goodList;
@property (nonatomic, strong) NSMutableArray *countryArr;
@property (nonatomic, strong) NSMutableArray *stateArr;
@end

@implementation OderInfoNew

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Payment";
    
    [self setupTableView];
    isShow=YES;
    [self getDataType:@"0"];
    
     firstName=@"";
      lastName=@"";
      contry=@"";
      address1=@"";
     address2=@"";
      code=@"";
      city=@"";
      state=@"";
     email=@"";
      phone=@"";
      
    cntactEmail=@"";
    
    coupon_code=@"";
    
    self.countryArr =[NSMutableArray array];
    self.stateArr=[NSMutableArray array];
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
     if (uid.length==0) {
          [self getAddressData];
     }
    
    saveAddress=NO;
    
}
- (void)setupTableView {
    //创建底部视图
    
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Continue" forState:0];
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTopCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTopCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactCell class]) bundle:nil] forCellReuseIdentifier:@"ContactCell"];
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
       
       tapGestureRecognizer.cancelsTouchesInView =NO;
       
       [self.myTableView addGestureRecognizer:tapGestureRecognizer];
    
}
#pragma mark 游客地址信息
- (void)getTourstDataWithContry:(NSString *)contryStr{
    TouristChangecontry *contry=[[TouristChangecontry alloc]init];
    contry.country=contryStr;
    [contry TouristChangecontryModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSDictionary * _Nonnull data) {
         if ([code intValue]==200) {
             @try {
                 [data[@"stateArr"] enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
                                   
                                   NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                                   [dic setValue:obj forKey:@"value"];
                                   [dic setValue:key forKey:@"key"];
                                   [self.stateArr addObject:dic];
                                   
                               }];
             } @catch (NSException *exception) {
                 
             } @finally {
                 
             }
          
     
         }
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)getAddressData{
    GetAddressInfoModel * info=[[GetAddressInfoModel alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [info GetAddressInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,NSDictionary *data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            
            @try {
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
            } @catch (NSException *exception) {
                
            } @finally {
                
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

- (void)getDataType:(NSString *)type{
    [MBProgressHUD showMessage:nil toView:self.view];
    OrderInfoModel *info=[[OrderInfoModel alloc]init];
    info.refresh=type;
    [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list ,id  _Nonnull payments,NSDictionary *contryDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            OrderInfoModel *sumModel=(OrderInfoModel *)data;
           countryMoneyCode=sumModel.data.currency_info.symbol;
         
           grand_total= sumModel.data.cart_info.grand_total;
            
            
            shipping_cost=sumModel.data.cart_info.shipping_cost;
            
           coupon_cost=sumModel.data.cart_info.coupon_cost;

            self.goodList=[NSArray arrayWithArray:sumModel.data.cart_info.products];
            
            NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
                if (uid.length>0) {
         
                    [self getTourstDataWithContry:sumModel.data.cart_address.country];
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

#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
        return 181;
    }
    else
    {
        return 577;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            OderInforGoodHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforGoodHeaderCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.moneyLab.text=[NSString stringWithFormat:@"%@%@",countryMoneyCode,grand_total];
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
                     cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",countryMoneyCode,model.product_price];
                cell.sizeLabel.text =[NSString stringWithFormat:@"product_weight:%@",model.product_weight];
                  cell.numberLabel.text = [NSString stringWithFormat:@"x%d",(int)[model.qty intValue]];
                  
                return cell;
            }
            else
            {
                OderInforGoodFootCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OderInforGoodFootCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                 cell.totalLab.text=[NSString stringWithFormat:@"%@%.2f",countryMoneyCode,[grand_total doubleValue]];
                
                  cell.discountLab.text=[NSString stringWithFormat:@"You’re saved%@%.2f",countryMoneyCode,[coupon_cost doubleValue]];
                if ([shipping_cost doubleValue]==0) {
                    cell.shipping_costLab.text=@"Free Shipping";
                }
                else
                {
                      cell.shipping_costLab.text= [NSString stringWithFormat:@"%@%.2f",countryMoneyCode,[shipping_cost doubleValue]];
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
        ContactCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
        cell.emailTf.text=cntactEmail;
        cell.emailTf.delegate=self;
        [cell.loginBtn addTarget: self action:@selector(tologin) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return  cell;
    }
    else
    {
        SelectAddressTopCell*cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressTopCell"];
               cell.firstName_tf.text= firstName;
               cell.lastName_tf.text= lastName;
               cell. contry_lab.text=contry;
               cell.address1_tf.text=address1;
               cell.address2_tf.text=address2;
               cell.code_tf.text=code;
               cell.city_tf.text=city;
               cell.state_lab.text=state;
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
        NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
            if (uid.length>0) {
                cell.CountryView.hidden=YES;
                cell.CountryViewHH.constant=0;
            }
        else
        {
            cell.CountryView.hidden=NO;
            cell.CountryViewHH.constant=60;
        }
        [cell.saveBtn addTarget:self action:@selector(saveAddressPress) forControlEvents:UIControlEventTouchUpInside];
        return  cell;
    }
}
- (void)keyboardHide
{
    [self.view endEditing:YES];
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
                           [self getDataType:@"1"];
                            }
                  });

    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
               [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
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
- (void)showPress{
    isShow=!isShow;
    [self.myTableView reloadData];
}
- (void)selectRow:(NSDictionary *)data type:(NSString *)type
{
    if ([type isEqualToString:@"contry"]) {
    
       contry=data[@"value"];
        contryCode=data[@"key"];
        [self changeContryListConntry:data[@"key"]];
        
        state=nil;
    }
    else
    {
        state=data[@"value"];
        stateCode=data[@"key"];
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
        case 5001:
            cntactEmail=textField.text;
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


- (NSInteger )cherkNUll{
    
      NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
         [dic1 setValue:firstName forKey:@"name"];
      
      NSMutableDictionary *dic2=[NSMutableDictionary dictionary];
           [dic2 setValue:lastName forKey:@"name"];
      
      NSMutableDictionary *dic3=[NSMutableDictionary dictionary];
           [dic3 setValue:contry forKey:@"name"];
      
      NSMutableDictionary *dic4=[NSMutableDictionary dictionary];
           [dic4 setValue:address1 forKey:@"name"];
      
      NSMutableDictionary *dic5=[NSMutableDictionary dictionary];
           [dic5 setValue:code forKey:@"name"];
      
      NSMutableDictionary *dic6=[NSMutableDictionary dictionary];
           [dic6 setValue:city forKey:@"name"];
      
      NSMutableDictionary *dic7=[NSMutableDictionary dictionary];
           [dic7 setValue:state forKey:@"name"];
      
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
- (void)submitPress{
    if (cntactEmail.length==0) {
          [MBProgressHUD showSuccess:@"Contact cannot be empty" toView:self.view];
        
        return;

    }
    if (saveAddress==NO) {
           [MBProgressHUD showSuccess:@"Please keep the receiving address" toView:self.view];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:cntactEmail forKey:@"cntactEmail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    OderInfoNewTwo  *two=[[OderInfoNewTwo alloc]init];
    [self.navigationController pushViewController:two animated:YES];
  
}
- (void)saveAddressPress{
    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    if (uid.length>0) {
                        [MBProgressHUD showSuccess:@"Need to log in first" toView:self.view];
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [self    loginPressWithType:@"1"];
                                 });

              
          }
    
      else
      {

                SaveAdressModel *model=[[SaveAdressModel alloc]init];
            NSInteger index= [self cherkNUll];

                     if (index!=8000) {

                         [MBProgressHUD showSuccess:@"Someone is empty" toView:self.view];
                         
                         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
                         SelectAddressTopCell *cell=(SelectAddressTopCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
                         [cell setTitleNoSelect:[NSString stringWithFormat:@"%ld",(long)index]];
                         return;
                     }
            
            BOOL result=  [HelpCommon  validateEmail:email];
            if (result==NO) {
                [MBProgressHUD showSuccess:@"Please enter the correct email address" toView:self.view];
                return;
            }
            
                model.first_name=firstName;
                model.last_name=lastName;
                model.addressCountry=contryCode;
                
                model.street1=address1;
                model.street2=address2;
                model.zip=code;
                model.city=city;
                
                model.addressState=stateCode;
                
                model.email=email;
                model.telephone=phone;
                
                model.isDefaultActive=@"1";
                [MBProgressHUD showMessage:nil toView:self.view];
                [model SaveAdressModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    saveAddress=YES;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:message toView:self.view];
                        });
                   
                } andFailure:^(NSError * _Nonnull error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
      }
    
    
}
- (void)tologin{
      [self loginPressWithType:@"2"];
}
- (void)loginPressWithType:(NSString *)type{
     LoginViewController *log = [LoginViewController new];
       YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
         
          
    if ([type isEqualToString:@"2"]) {
         log.isPresent=@"2";
        [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
    }
    
    else
    {
        navi.modalPresentationStyle = UIModalPresentationOverFullScreen;
        log.isPresent=@"1";
        log.block = ^{
         
              [self getAddressData];
           contry=@"";
           state=@"";
              [self.myTableView reloadData];
            
          };
          [self presentViewController:navi animated:YES completion:nil];
    }
  
}
@end
