//
//  SelectAddress.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SelectAddress.h"
#import "SelectAddressTopCell.h"
#import "GetAddressInfoModel.h"
#import "PickView.h"
#import "ChangeCountryModel.h"
#import "TouristChangecontry.h"
#import "SaveAdressModel.h"
@interface SelectAddress ()
<UITableViewDelegate,UITableViewDataSource,PickViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
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
    
     NSString * contryCode;
     NSString * stateCode;
    
    
}
@property (strong,nonatomic)UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *countryArr;
@property (nonatomic, strong) NSMutableArray *stateArr;
@end

@implementation SelectAddress

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

       
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

       self.countryArr =[NSMutableArray array];
       self.stateArr=[NSMutableArray array];
      
    
   UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       rigthBtn.frame = CGRectMake(0, 0, 80, 50);

       [rigthBtn setTitle:@"save" forState:UIControlStateNormal];
       rigthBtn.titleLabel.font = font(15);
       rigthBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -20);
       [rigthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
       UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
       self.navigationItem.rightBarButtonItem = rightItem;
    [self setupTableView];
    
;
        
             [self getData];
       
    
    
}

- (void)rigthBtnClick{
    [self saveAddressPress];
}
- (void)setupTableView {
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, ScreenHeight-NaviBarAndStatusBarHeight) style:UITableViewStylePlain];
       table.delegate = self;
       table.dataSource = self;
  
    table.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    self.myTableView = table;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    
     [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTopCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTopCell"];
   
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    
    tapGestureRecognizer.cancelsTouchesInView =NO;
    
    [self.myTableView addGestureRecognizer:tapGestureRecognizer];
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
- (void)saveAddressPress{
    
                SaveAdressModel *model=[[SaveAdressModel alloc]init];
        NSInteger index= [self cherkNUll];

                                     if (index!=8000) {

                                         [MBProgressHUD showSuccess:@"Someone is empty" toView:self.view];
                                         
                                         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
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
                    if ([code intValue]==200) {
                        self.block(contryCode,stateCode);
                                              [self.navigationController popViewControllerAnimated:YES];
                    }
                      
                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:message toView:self.view];
                        });
                   
                } andFailure:^(NSError * _Nonnull error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
      }
    
    

#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 557;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

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
    cell.saveBtn.hidden=YES;
        return cell;
  
}
- (void)selectRow:(NSDictionary *)data type:(NSString *)type
{
    if ([type isEqualToString:@"contry"]) {
    
         contry=data[@"value"];
        contryCode=data[@"key"];
        state=@"";
          
        [self changeContryListConntry:data[@"key"]];
    }
    else
    {
        stateCode=data[@"key"];
        state=data[@"value"];
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

- (NSInteger)cherkNUll{
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
@end
