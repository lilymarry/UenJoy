//
//  SelectAddressTwo.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SelectAddressTwo.h"
#import "SelectAddressTwoCell.h"
#import "SelectAddressTwoContentCell.h"
#import "SelectAddressNoteCell.h"
//#import "AdressListModel.h"
#import "SelectAddressOne.h"
#import "OderInfo.h"
#import "OrderInfoModel.h"
#import "ChangeInfoModel.h"
@interface SelectAddressTwo ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSString *desc;
    NSString * current_shipping_method;
    NSString *current_payment_method;
    NSString *country;
    NSString *countryMoneyCode;
}
@property (strong,nonatomic)UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong)NSIndexPath *lastPath;

@end

@implementation SelectAddressTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Ship To";
     desc=@"";
    [self setupTableView];
    [self getData];
}
- (void)setupTableView {
    //创建底部视图
    
    UIButton *footerBtn = [UIButton new];
    [footerBtn addTarget:self action:@selector(continuePress) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setTitle:@"Continue" forState:0];
    [footerBtn setTitleColor:Color(@"#F5F5F5") forState:0];
    footerBtn.titleLabel.font=font(15);
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
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTwoCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTwoCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressTwoContentCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressTwoContentCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectAddressNoteCell class]) bundle:nil] forCellReuseIdentifier:@"SelectAddressNoteCell"];
    
    
}
- (void)getData{
      [MBProgressHUD showMessage:nil toView:self.view];
    OrderInfoModel *info=[[OrderInfoModel alloc]init];
     info.refresh=@"0";
    [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list ,id  _Nonnull payments,NSDictionary *contryDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
                OrderInfoModel *sumModel=(OrderInfoModel *)data;
            
           
           current_shipping_method= sumModel.data.current_shipping_method;
            current_payment_method=sumModel.data.current_payment_method;
            country=sumModel.data.country;
            
           countryMoneyCode=sumModel.data.currency_info.symbol;
            OrderInfoModel *model=(OrderInfoModel *)address_list;
            self.dataSource =[NSMutableArray arrayWithArray:(NSArray *)model.address_list];
            
         
            BOOL isExit=NO;
            for (int i=0; i<  self.dataSource.count; i++) {
                OrderInfoModel *list= self.dataSource[i];
                if ([list.is_default intValue]==1) {
                    self.lastPath =  [NSIndexPath indexPathForRow:i inSection:1];;
                    [self.myTableView  selectRowAtIndexPath:self.lastPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                    isExit=YES;
                    break;
                    
                }
            }
            if (isExit==NO) {
                self.lastPath =  [NSIndexPath indexPathForRow:0 inSection:1];;
                [self.myTableView  selectRowAtIndexPath:self.lastPath animated:YES scrollPosition:UITableViewScrollPositionNone];
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
- (void)continuePress{
    
   
    if (self.lastPath==nil||self.dataSource.count ==0) {
        [MBProgressHUD showSuccess:@"Receiving address has not been selected" toView:self.view];
        return;
    }
 //   OderInfo *order=[[OderInfo alloc]init];
    OrderInfoModel *model =self.dataSource[self.lastPath.row];
    NSString * address=model.address;
    NSString*userName=[NSString stringWithFormat:@"%@%@   %@",model.address_info.last_name,model.address_info.first_name,model.address_info.telephone];
    self.block(model.address_info.address_id, country, model.address_info.state,userName,address);
//    order.addressModel=model;
//order.current_shipping_method=current_shipping_method;
//    order.current_payment_method=current_payment_method;
//    order.contry=country;
//    order.contryMoenyCode=countryMoneyCode;
   [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return self.dataSource.count;
    }
    else
    {
        return 1;
    }
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 250;
    }
    else if (indexPath.section==1)
    {
        return 121;
    }
    else
    {
        return 383;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        SelectAddressTwoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressTwoCell"];
        [cell.addBtn setTitle:@"+ Add a New Address" forState:UIControlStateNormal];
        [cell.addBtn addTarget:self action:@selector(addAdressPress) forControlEvents:UIControlEventTouchUpInside];
        cell.labView.hidden=YES;
   
        return cell;
    }
     else  if (indexPath.section==1)
     {
         SelectAddressTwoContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressTwoContentCell"];
         OrderInfoModel *model =self.dataSource[indexPath.row];
         cell.subTitleLab.text=[NSString stringWithFormat:@"%@%@   %@",model.address_info.last_name,model.address_info.first_name,model.address_info.telephone];
         cell.titleLab.text=model.address;
     
         if (_lastPath.row==indexPath.row&&_lastPath!=nil) {
             cell.flag_imagView.hidden=NO;
         }
         else
         {
            cell.flag_imagView.hidden=YES;
         }
      
         return cell;
     }
    else
    {
        SelectAddressNoteCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectAddressNoteCell"];
        
        cell.introduceView.hidden=NO;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath row];
    
    
    if (indexPath.section==1) {
        int oldRow =(int)( (_lastPath !=nil)?[_lastPath row]:-1);
        if (newRow != oldRow) {
            SelectAddressTwoContentCell *newcell =(SelectAddressTwoContentCell *)[tableView cellForRowAtIndexPath:indexPath];
            
               newcell.flag_imagView.hidden=NO;
            
            SelectAddressTwoContentCell *oldCell =(SelectAddressTwoContentCell *)[tableView cellForRowAtIndexPath:_lastPath];
            
              oldCell.flag_imagView.hidden=YES;
            _lastPath = indexPath;
            
            
        
        }
    }
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    desc=textView.text;
    [self.myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    return YES;
}
- (void)addAdressPress{
    SelectAddressOne *one =[[SelectAddressOne alloc]init];
    one.AddBlock = ^{
        [self getData];
    };
    [self.navigationController pushViewController:one animated:YES];
}

@end
