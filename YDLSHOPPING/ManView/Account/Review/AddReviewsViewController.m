//
//  AddReviewsViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddReviewsViewController.h"
#import "ReviewOneCell.h"
#import "ReviewThreeCell.h"
#import "AddReviewModel.h"
#import "AddPicReviewModel.h"
@interface AddReviewsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
   
    NSString * rateNum;
  
}
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic) NSArray *  imageArr;
@property (strong,nonatomic)  NSString * desc;;
@end

@implementation AddReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      adjustsScrollViewInsets_NO(self.myTableView, self);
    
    self.view.backgroundColor = Color(@"ffffff");
    self.title = @"Add a Review";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    rateNum=@"1";
    [self setMainView];
    
  
}

- (void)setMainView{
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, ScreenHeight-NaviBarAndStatusBarHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    
    table.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    self.myTableView = table;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
      [self.myTableView registerClass:[ReviewOneCell class] forCellReuseIdentifier:NSStringFromClass([ReviewOneCell class])];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewThreeCell class]) bundle:nil] forCellReuseIdentifier:@"ReviewThreeCell"];
    
  

    
}
#pragma mark tableview
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _mainModel.products.count;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0)
    {
        return 120;
    }
    else
    {
        return 441;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        ReviewOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReviewOneCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     //   ReviewLlistMdel *subModel = _mainModel.products[indexPath.row];
        
          NSString* encodedString =[_mainModel.pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        [ cell.image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
        
        cell.title.text=_mainModel.name;
        cell.money.text=[NSString stringWithFormat:@"TOTAL:%@%.2f",_codeSymbol,[_mainModel.price doubleValue]];
        cell.AddBtn.hidden=YES;
        
        
        return cell;
    }
    else
    {
        ReviewThreeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReviewThreeCell"];
      
  
        cell.saveArr=[NSMutableArray arrayWithArray:self.imageArr];
        cell.rateNum=rateNum;
        
        cell.desc=_desc;
       
        cell.threeBlock = ^(NSArray * _Nonnull imageArr, NSString * _Nonnull num,NSString *desc) {
         self. imageArr=[NSArray arrayWithArray:imageArr];
         rateNum=num;
           _desc=desc;
            [self.myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        };
        
        
        [cell loadPicView];
        cell.submitBtn.tag=indexPath.section;
        [cell.submitBtn addTarget:self action:@selector(submitBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    
}
- (void)submitBtnPress:(UIButton *)btn{
 
    
    if (rateNum.length==0) {
            [MBProgressHUD showSuccess:@" No score yet" toView:self.view];
           return;
       }
       if (_desc.length==0) {
           [MBProgressHUD showSuccess:@" Please enter your expectations " toView:self.view];
            return;
       }
       if (self.imageArr.count==0) {
           [MBProgressHUD showSuccess:@" No pictures have been selected yet" toView:self.view];
            return;
       }

        
        AddPicReviewModel *model=[[AddPicReviewModel alloc]init];
         model.FILE=self.imageArr;
        [MBProgressHUD showMessage:nil toView:self.view];

        [model AddPicReviewModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            if ([code intValue]==200) {
                AddPicReviewModel *model=(  AddPicReviewModel *)data;
                [self addContentRelative_path:model.data.relative_path];
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

- (void)addContentRelative_path:(NSString *)relative_path{
     AddReviewModel *mode=[[AddReviewModel alloc]init];
       mode.product_id=_mainModel.product_id;
       mode.order_id=_mainModel.order_id;
     
       mode.rate_star=rateNum;
       mode.name=[[LoginModel shareInstance]getUserInfo].uinfo.nickname;
       
       mode.summary=_desc;
       mode.review_content=_desc;
       
      mode.review_imgs=relative_path;
       [MBProgressHUD showMessage:nil toView:self.view];

       [mode AddReviewModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            [MBProgressHUD showSuccess:message toView:self.view];
           if ([code intValue]==200) {
                 self.block();
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                              [self.navigationController popViewControllerAnimated:YES];
                          });

              
           }
          
           
       } andFailure:^(NSError * _Nonnull error) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           [MBProgressHUD showError:[error localizedDescription] toView:self.view];
       }];
    
}
@end
