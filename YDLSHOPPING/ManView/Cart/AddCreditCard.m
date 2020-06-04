//
//  AddCreditCard.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddCreditCard.h"
#import "AddCreditCardCell.h"
#import "PickView.h"
#import "GetAddressInfoModel.h"
#import "ChangeCountryModel.h"
#import "AddCreditCardModel.h"
#import "HooDatePicker.h"
#import "OderInfo.h"
@interface AddCreditCard ()<UITableViewDelegate,UITableViewDataSource,PickViewDelegate,UITextFieldDelegate,HooDatePickerDelegate>
{
    BOOL isShowBillingAddressSwitch;
    
    NSString *cartNum;
    NSString *cvv;
    NSString * contry;
    NSString * address1;
    NSString * address2;
    NSString * code;
    NSString * city;
    NSString * state;
    NSString * email;
    NSString *phone;
    
    NSString *expires;
    
  //  NSString *contryCode;
  //  NSString *stateCode;
    OrderInfoModel* address_info;
    
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *countryArr;
@property (nonatomic, strong) NSMutableArray *stateArr;
@property (nonatomic, strong) HooDatePicker *datePicker1;
@end

@implementation AddCreditCard

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_myTableView, self);
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Add a New Card";
    cartNum=@"";
    cvv=@"";
    contry=@"";
    address1=@"";
    address2=@"";
    code=@"";
    city=@"";
    state=@"";
    email=@"";
    phone=@"";
    
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddCreditCardCell class]) bundle:nil] forCellReuseIdentifier:@"AddCreditCardCell"];
    isShowBillingAddressSwitch=YES;
    self.countryArr =[NSMutableArray array];
    self.stateArr=[NSMutableArray array];
    [self getData];
    
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    
    tapGestureRecognizer.cancelsTouchesInView =NO;
    
    [self.myTableView addGestureRecognizer:tapGestureRecognizer];
    self.datePicker1 = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker1.delegate = self;
    
    self.datePicker1.datePickerMode = HooDatePickerModeYearAndMonth;
    
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
    NSDate *minDate = [dateFormatter dateFromString:@"2016-01-01"];
    [ self.datePicker1 setDate:[NSDate date] animated:YES];
    self.datePicker1.minimumDate = minDate;
    self.datePicker1.maximumDate = maxDate;
    [self getAddressData];
    
}
- (void)keyboardHide
{
    [self.datePicker1 dismiss];
    [self.view endEditing:YES];
 
}
- (void)getAddressData{
    [MBProgressHUD showMessage:nil toView:self.view];
     OrderInfoModel *info=[[OrderInfoModel alloc]init];
     [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list ,id  _Nonnull payments,NSDictionary *contryDic) {
         
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         if ([code intValue]==200) {
    
        
             OrderInfoModel *model=(OrderInfoModel *)address_list;
                NSArray *arr =[NSArray arrayWithArray:(NSArray *)model.address_list];
             
             
             if ( arr.count>0) {
                 for (  OrderInfoModel *model in arr) {
                     if ([model.address_info.address_id  intValue]==[self .selectAddressId intValue]) {
                          address_info=model;
                         break;

                     }
                 }
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
- (void)getData{
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AddCreditCardCell *  cell=[tableView dequeueReusableCellWithIdentifier:@"AddCreditCardCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.BillingAddressSwitch.on=isShowBillingAddressSwitch;
    
    [cell.contryBtn addTarget:self action:@selector(contryPress) forControlEvents:UIControlEventTouchUpInside];
    [cell.stateBtn addTarget:self action:@selector(statePress) forControlEvents:UIControlEventTouchUpInside];
    [cell.dateBtn addTarget:self action:@selector(datePress) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.BillingAddressSwitch addTarget:self action:@selector(billingAddressSwitchChange:) forControlEvents:UIControlEventValueChanged];
    if ( cell.BillingAddressSwitch.on) {
        cell.BillingAddressSwitch.thumbTintColor=Color(@"#ffffff");
        cell.addressView.hidden=NO;
        cell.nameLab.text=[NSString stringWithFormat:@"%@%@   %@",address_info.address_info.last_name,address_info.address_info.first_name,address_info.address_info.telephone];
        cell.addressLab.text=address_info.address;
        
    }
    else
    {
    cell.BillingAddressSwitch.thumbTintColor=Color(@"#666666");
        cell.addressView.hidden=YES;
    }
    
    cell.contry_lab.text=contry;
    cell.state_lab.text=state;
    cell.dateLab.text=expires;
    cell.cartNum_tf.text=  cartNum;
    cell.cvv_tf.text= cvv;
    cell. contry_lab.text=contry;
    cell.address1_tf.text=address1;
    cell.address2_tf.text=address2;
    cell.code_tf.text=code;
    cell.city_tf.text=city;
    cell.state_lab.text=state;
    cell.email_tf.text=email;
    cell.phone_tf.text=phone;
    
    cell.cartNum_tf.delegate=self;
    cell.cvv_tf.delegate=self;
    cell.address1_tf.delegate=self;
    cell.address2_tf.delegate=self;
    cell.code_tf.delegate=self;
    cell.city_tf.delegate=self;
    cell.email_tf.delegate=self;
    cell.phone_tf.delegate=self;
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 720;
    
}
- (void)billingAddressSwitchChange:(UISwitch *)sender{
    if (sender.on) {
        isShowBillingAddressSwitch=YES;
        
    }
    else
    {
        isShowBillingAddressSwitch=NO;
        
    }
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)selectRow:(NSDictionary *)data type:(NSString *)type
{
    if ([type isEqualToString:@"contry"]) {
        
        contry=data[@"value"];
        [self changeContryListConntry:data[@"key"]];
      //  contryCode=data[@"key"];
        
    }
    else
    {
        state=data[@"value"];
       // stateCode=data[@"key"];
    }
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //判断是否是当前输入框
    if (textField.tag==1000) {
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


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    
    switch (textField.tag) {
        case 1000:
            cartNum = textField.text;
            break;
        case 1001:
            cvv=textField.text;
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
        default:
            break;
    }
    
    [self.myTableView performSelectorOnMainThread:@selector(reloadRowsAtIndexPaths:withRowAnimation:) withObject:nil waitUntilDone:NO];
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
       [self.datePicker1 dismiss];
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
- (IBAction)savePress:(id)sender {
    
    if (isShowBillingAddressSwitch==NO) {
        
        NSString *str= [self cherkNUll];
        
        if (![str isEqualToString:@"not null"]) {
            
            [MBProgressHUD showSuccess:@"Someone is empty" toView:self.view];
            return;
        }
        
        BOOL result=  [HelpCommon  validateEmail:email];
        if (result==NO) {
            [MBProgressHUD showSuccess:@"Please enter the correct email address" toView:self.view];
            return;
        }
    }
    else
    {
        if (cartNum.length==0) {
            
            [MBProgressHUD showSuccess:@"Credit Card Number is empty" toView:self.view];
            return;
        }
        if (expires.length==0) {
            
            [MBProgressHUD showSuccess:@"Expires is empty" toView:self.view];
            return;
        }
        if (cvv.length==0) {
            
            [MBProgressHUD showSuccess:@"CVV is empty" toView:self.view];
            return;
        }
    
        
    }
    
    AddCreditCardModel *model=[[AddCreditCardModel alloc]init];
    if (_card_id.length>0) {
        model.card_id=_card_id;
    }
    NSString *cartStr= [cartNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    model.card_number=cartStr;
    model.card_type=@"vista";
    model.expires=expires;
    model.cvv=cvv;
    
     [MBProgressHUD showMessage:nil toView:self.view];
    [model AddCreditCardModelAddCreditCardModelSuccess:^(NSString * _Nonnull codenu, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([codenu intValue]==200) {
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            
             if (isShowBillingAddressSwitch==NO)
             {
                 [dic setValue:email forKey:@"email"];
                 
                 [dic setValue:phone forKey:@"telephone"];
                 [dic setValue:address1 forKey:@"street1"];
                 [dic setValue:address2 forKey:@"street2"];
                 [dic setValue:contry forKey:@"country"];
                 
                 [dic setValue:state forKey:@"state"];
                 [dic setValue:city forKey:@"city"];
                 [dic setValue:code forKey:@"zip"];
                 
                [dic setValue:@"0" forKey:@"isbilling"];
             }
            else
            {

                [dic setValue:address_info.address_info.email forKey:@"email"];

                [dic setValue:address_info.address_info.telephone forKey:@"telephone"];
                [dic setValue:address_info.address_info.street1 forKey:@"street1"];
                [dic setValue:address_info.address_info.street2 forKey:@"street2"];
                [dic setValue:address_info.address_info.country forKey:@"country"];

                [dic setValue:address_info.address_info.state forKey:@"state"];
                [dic setValue:address_info.address_info.city forKey:@"city"];
                [dic setValue:address_info.address_info.zip forKey:@"zip"];
                  [dic setValue:@"1" forKey:@"isbilling"];
            }
            [dic setValue:address_info.address_info.first_name forKey:@"first_name"];
            [dic setValue:address_info.address_info.last_name forKey:@"last_name"];
            
             NSString *cartStr= [cartNum stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            [dic setValue:cartStr forKey:@"cartNum"];
            
            [dic setValue:expires forKey:@"expires"];
            [dic setValue:cvv forKey:@"cvv"];
            
            
           
            for(UIViewController *temp in self.navigationController.viewControllers) {
                if([temp isKindOfClass:[OderInfo class]]){
                    
                    [self.navigationController popToViewController:temp animated:YES];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"AddCreditCard" object:dic];
                    break;
                }
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
- (void)datePress{
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
    
    if ([self compareOneDay:expires withAnotherDay:[self stringFromDate:[NSDate date]]]==-1) {
        [MBProgressHUD showError:@"Expires is wrong" toView:self.view];
        return;
    }
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
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
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/yy"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
- (NSString *)cherkNUll{
    NSArray *arr=[NSArray arrayWithObjects:cartNum,cvv,contry,address1,address2,code,city,state,email,phone,expires, nil];
    for (NSString *str in arr) {
        if (str.length==0) {
            return @"is null";
        }
    }
    return @"not null";
}
@end
