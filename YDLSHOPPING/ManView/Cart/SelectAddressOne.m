//
//  SelectAddressOne.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SelectAddressOne.h"
#import "SelectAddressTopCell.h"

#import "AddAddressCell.h"
#import "GetAddressInfoModel.h"
#import "PickView.h"
#import "ChangeCountryModel.h"
#import "SaveAdressModel.h"
#import "SelectAddressNoteCell.h"
#import "SelectAddressTwo.h"

@interface SelectAddressOne ()<UITableViewDelegate,UITableViewDataSource,PickViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
  //  NSString *contryCode;
  //  NSString *stateCode;
    
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
    
    NSString *desc;
    
}
@property (strong,nonatomic)UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *countryArr;
@property (nonatomic, strong) NSMutableArray *stateArr;
@end

@implementation SelectAddressOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];

    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Ship To";
    
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
    
    desc=@"";
  
    
    self.countryArr =[NSMutableArray array];
    self.stateArr=[NSMutableArray array];
    [self getData];
    
}
- (void)setupTableView {
    //创建底部视图
  
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(continuePress) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Continue" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];
    footerBtn.titleLabel.font = font(15);

    [footerBtn setBackgroundColor:Color(@"#F6AA00")];
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
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddAddressCell class]) bundle:nil] forCellReuseIdentifier:@"AddAddressCell"];
    
     [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTopCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTopCell"];
      [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressNoteCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressNoteCell"];
  
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    
    tapGestureRecognizer.cancelsTouchesInView =NO;
    
    [self.myTableView addGestureRecognizer:tapGestureRecognizer];
}
- (void)continuePress{
   
        SaveAdressModel *model=[[SaveAdressModel alloc]init];
    
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
    
        model.first_name=firstName;
        model.last_name=lastName;
        model.addressCountry=contry;
        
        model.street1=address1;
        model.street2=address2;
        model.zip=code;
        model.city=city;
        
        model.addressState=state;
        
        model.email=email;
        model.telephone=phone;
        
        model.isDefaultActive=@"2";
        [MBProgressHUD showMessage:nil toView:self.view];
        [model SaveAdressModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if ([code intValue]==200) {
                if ( [self.type isEqualToString:@"1"])
                {
                       SelectAddressTwo *two=[[SelectAddressTwo alloc]init];
                        [self.navigationController pushViewController:two animated:YES];
                }
               
          else
          {
              self.AddBlock();
              [self.navigationController popViewControllerAnimated:YES];
          }
                
             
            }
            else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showSuccess:message toView:self.view];
                });
            }
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    
}
- (void)keyboardHide
{
    [self.view endEditing:YES];
    
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
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section==0)
    {
        return 557;
    }
    else
    {
        return 383;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        SelectAddressTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressTopCell"];
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
        return cell;
    }
 
  else
  {
       SelectAddressNoteCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressNoteCell"];
      cell.introduceView.hidden=YES;
      if (desc.length >0) {
          cell.desc_lab.hidden=YES;
      }
      else
      {
         cell.desc_lab.hidden=NO;
      }
      cell.desc_txt.text=desc;
      cell.desc_txt.delegate=self;
      
     
      return  cell;
  }
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
    
      //  stateCode=data[@"key"];
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
        default:
            break;
    }

    [self.myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    desc=textView.text;
    [self.myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    return YES;
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

- (NSString *)cherkNUll{
      NSArray *arr=[NSArray arrayWithObjects:firstName,lastName,contry,address1,code,city,state,email,phone, nil];

     for (NSString *str in arr) {
         if (str.length==0) {
             return @"is null";
         }
     }
     if (arr.count==0) {
          return @"is null";
     }
     return @"not null";
}
@end
