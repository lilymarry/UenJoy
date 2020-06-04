//
//  AddShippingAddressViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddShippingAddressViewController.h"
#import "AddAddressCell.h"
#import "GetAddressInfoModel.h"
#import "PickView.h"
#import "ChangeCountryModel.h"
#import "SaveAdressModel.h"
@interface AddShippingAddressViewController ()<UITableViewDelegate,UITableViewDataSource,PickViewDelegate,UITextFieldDelegate>
{
    NSString *contryCode;
    NSString *stateCode;
}
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *countryArr;
@property (nonatomic, strong) NSMutableArray *stateArr;
@end

@implementation AddShippingAddressViewController
-(NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Add Shipping Address";
    
    [self setMainView];
    
    if (_address_id.length==0) {
        self.dataSource=[NSMutableArray arrayWithObjects:
                         @{@"title":@"First Name*",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"Last Name*",@"subTitle":@""}.mutableCopy,
                         @{ @"title":@"Country*",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"Address Line1*",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"Address Line2(optional)",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"Zip Code*",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"City*",@"subTitle":@""}.mutableCopy,
                         @{ @"title":@"State*",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"Email Adress*",@"subTitle":@""}.mutableCopy,
                         @{@"title":@"Phone*",@"subTitle":@""}.mutableCopy,
                         
                         nil];
    }
    else
    {
        self.dataSource=[NSMutableArray arrayWithObjects:
                         @{@"title":@"First Name*",@"subTitle":_mainModel.first_name}.mutableCopy,
                         @{@"title":@"Last Name*",@"subTitle":_mainModel.last_name}.mutableCopy,
                         @{ @"title":@"Country*",@"subTitle":_mainModel.countryName}.mutableCopy,
                         @{@"title":@"Address Line1*",@"subTitle":_mainModel.street1}.mutableCopy,
                         @{@"title":@"Address Line2(optional)",@"subTitle":_mainModel.street2}.mutableCopy,
                         @{@"title":@"Zip Code*",@"subTitle":_mainModel.zip}.mutableCopy,
                         @{@"title":@"City*",@"subTitle":_mainModel.city}.mutableCopy,
                         @{ @"title":@"State*",@"subTitle":_mainModel.stateName}.mutableCopy,
                         @{@"title":@"Email Adress*",@"subTitle":_mainModel.email}.mutableCopy,
                         @{@"title":@"Phone*",@"subTitle":_mainModel.telephone}.mutableCopy,
                         
                         nil];
        
      stateCode=_mainModel.state;
      contryCode=_mainModel.country;
    }
    
    self.countryArr =[NSMutableArray array];
    self.stateArr=[NSMutableArray array];
    [self getData];
    
    
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
- (void)setMainView{
    UITableView *tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = Color(@"#F5F5F5");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsMultipleSelectionDuringEditing = YES;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddAddressCell class]) bundle:nil] forCellReuseIdentifier:@"AddAddressCell"];
    
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(10);
        make.height.offset(ScreenHeight);
        make.width.offset(ScreenWidth);
    }];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    UIButton *footerBtn = [UIButton new];
    [footerBtn setTitle:@"Save" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];
    footerBtn.titleLabel.font = font(15);
    [footerBtn setBackgroundColor:Color(@"#F6AA00")];
    [footerBtn addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
        make.height.offset(40);
        make.center.equalTo(footerView);
    }];
    tableView.tableFooterView = footerView;
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    
    tapGestureRecognizer.cancelsTouchesInView =NO;
    
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAddressCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
    cell.numTf.delegate=self;
    cell.numTf.tag=indexPath.row;
    cell.titleLab.text=self.dataSource[indexPath.row][@"title"];
    if ([cell.titleLab.text isEqualToString:@"Country*"]||[cell.titleLab.text isEqualToString:@"State*"]) {
        cell.numTf.hidden=YES;
        cell.subTitle.hidden=NO;
        cell.flagImaView.hidden=NO;
        NSString *str =self.dataSource[indexPath.row][@"subTitle"];
        if (str.length==0) {
            cell.subTitle.text=@"Please choose in here";
        }
        else
        {
            cell.subTitle.text=str;
        }
    }
    else
    {
        cell.numTf.hidden=NO;
        cell.subTitle.hidden=YES;
        cell.flagImaView.hidden=YES;
        cell.numTf.text=self.dataSource[indexPath.row][@"subTitle"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddAddressCell *cell=  [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.titleLab.text isEqualToString:@"Country*"]) {
        //   [cell.numTf resignFirstResponder];
        
        PickView *pick =[[PickView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [pick loadPick:self.countryArr andType:@"contry"];
        pick.delegate=self;
        
        [self.view.window addSubview:pick];
        
    }
    if ([cell.titleLab.text isEqualToString:@"State*"]) {
        //  [cell.numTf resignFirstResponder];
        PickView *pick =[[PickView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [pick loadPick:self.stateArr andType:@"state"];
        pick.delegate=self;
        
        [self.view.window addSubview:pick];
        
    }
}

- (void)selectRow:(NSDictionary *)data type:(NSString *)type
{
    if ([type isEqualToString:@"contry"]) {
        self.dataSource[2][@"subTitle"] = data[@"value"];
        
        [self changeContryListConntry:data[@"key"]];
        contryCode=data[@"key"];
         self.dataSource[7][@"subTitle"] = @"";
        
    }
    else
    {
        self.dataSource[7][@"subTitle"] = data[@"value"];
        stateCode=data[@"key"];
    }
    [self.tableView reloadData];
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
- (void)submitPress{
    SaveAdressModel *model=[[SaveAdressModel alloc]init];
    if (_address_id.length>0) {
        model.address_id=_address_id;
    }
    NSString *str= [self cherkNUll];
    
    if (![str isEqualToString:@"not null"]) {
      
             NSString *messge=  [NSString stringWithFormat:@"%@ cannot be empty",str];
                   [MBProgressHUD showSuccess:messge toView:self.view];
                   return;
     
       
    }
    
    BOOL result=  [HelpCommon  validateEmail:self.dataSource[8][@"subTitle"] ];
    if (result==NO) {
          [MBProgressHUD showSuccess:@"Please enter the correct email address" toView:self.view];
        return;
    }
    
    model.first_name=self.dataSource[0][@"subTitle"];
    model.last_name=self.dataSource[1][@"subTitle"];
    model.addressCountry=contryCode;
    
    model.street1=self.dataSource[3][@"subTitle"];
    model.street2=self.dataSource[4][@"subTitle"];
    model.zip=self.dataSource[5][@"subTitle"];
    model.city=self.dataSource[6][@"subTitle"];
    
    model.addressState=stateCode;
    
    model.email=self.dataSource[8][@"subTitle"];
    model.telephone=self.dataSource[9][@"subTitle"];
    
    model.isDefaultActive=@"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model SaveAdressModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            self.AddBlock();
            [self.navigationController popViewControllerAnimated:YES];
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
- (NSString *)cherkNUll{
    
    for (NSDictionary *dic in self.dataSource) {
        if ([dic[@"subTitle"] length]==0 &&(![dic[@"title"] isEqualToString:@"Address Line2(optional)"])) {
            return dic[@"title"];
            break;
        }
    }
    return @"not null";
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:textField.tag inSection:0];
    
    
    self.dataSource[index.row][@"subTitle"] = textField.text;
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    return YES;
}
@end
