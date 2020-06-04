//
//  CreditCardList.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CreditCardList.h"
#import "CreditCardListAddCell.h"
#import "CreditCardListCell.h"
#import "CreditCardListModel.h"
#import "AddCreditCard.h"
#import "DelectCreditCardModel.h"
@interface CreditCardList ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderInfoModel* address_info;
    
}
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *dataArr;
@end

@implementation CreditCardList

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(self.myTableView, self);
    self.view.backgroundColor = Color(@"F5F5F5");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"Payment Info";
    
    [self setupTableView];
    [self getData];
    [self getAddressData];
    
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
    CreditCardListModel *model=[[CreditCardListModel alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [model CreditCardListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            CreditCardListModel *model=(CreditCardListModel *)data;
            self.dataArr=[NSArray arrayWithArray:model.data.list];
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
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, ScreenHeight-NaviBarAndStatusBarHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    
    table.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    self.myTableView = table;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CreditCardListAddCell class]) bundle:nil] forCellReuseIdentifier:@"CreditCardListAddCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CreditCardListCell class]) bundle:nil] forCellReuseIdentifier:@"CreditCardListCell"];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==2) {
        return self.dataArr.count;
    }
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 185;
    }
    else
    {
        return 122;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        CreditCardListAddCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CreditCardListAddCell"];
        [cell.addCartBtn addTarget:self action:@selector(addCartPress) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if(indexPath.section==1)
    {
        CreditCardListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CreditCardListCell"];
        cell.nameLab.hidden=YES;
        cell.imagV.hidden=NO;
        return cell;
    }
    else
    {
        CreditCardListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CreditCardListCell"];
        CreditCardListModel *model=self.dataArr[indexPath.row];
        cell.nameLab.hidden=NO;
        cell.imagV.hidden=YES;
        cell.nameLab.text=[self getNewBankNumWitOldBankNum:model.card_number];
        return cell;
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
        return YES;
    }
    return NO;
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==2) {
        
        //删除
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            CreditCardListModel *list=self.dataArr[indexPath.row];
            DelectCreditCardModel *model=[[DelectCreditCardModel alloc]init];
            model.card_id =list.card_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [model DelectCreditCardModelAddCreditCardModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
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
            
        }];
        
        return @[deleteRowAction];
    }
    else{
        return nil;
    }
}
- (void)addCartPress{
    AddCreditCard *add=[[AddCreditCard alloc]init];
    add.selectAddressId=_selectAddressId;
    [self.navigationController pushViewController:add animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        
        
        CreditCardListModel *list=self.dataArr[indexPath.row];
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:address_info.address_info.email forKey:@"email"];
        
        [dic setValue:address_info.address_info.telephone forKey:@"telephone"];
        [dic setValue:address_info.address_info.street1 forKey:@"street1"];
        [dic setValue:address_info.address_info.street2 forKey:@"street2"];
        [dic setValue:address_info.address_info.country forKey:@"country"];
        
        [dic setValue:address_info.address_info.state forKey:@"state"];
        [dic setValue:address_info.address_info.city forKey:@"city"];
        [dic setValue:address_info.address_info.zip forKey:@"zip"];
        [dic setValue:@"1" forKey:@"isbilling"];
        
        [dic setValue:address_info.address_info.first_name forKey:@"first_name"];
        [dic setValue:address_info.address_info.last_name forKey:@"last_name"];
        
        
        
        [dic setValue:list.card_number forKey:@"cartNum"];
        
        [dic setValue:list.expires forKey:@"expires"];
        [dic setValue:@"123" forKey:@"cvv"];
        
        self.block(dic);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum{
    NSMutableString *mutableStr;
    if (bankNum.length) {
        mutableStr = [NSMutableString stringWithString:bankNum];
        for (int i = 0 ; i < mutableStr.length; i ++) {
            if (i>2&&i<mutableStr.length - 3) {
                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        NSString *text = mutableStr;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        return newString;
    }
    return bankNum;
}
@end
