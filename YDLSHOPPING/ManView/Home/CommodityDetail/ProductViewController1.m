//
//  ProductViewController1.m
//  YDLSHOPPING
//
//  Created by mac on 2020/1/20.
//  Copyright © 2020 sunjiayu. All rights reserved.
//

#import "ProductViewController1.h"
#import "ProductTopCell.h"
#import "AddCartModel.h"
#import "SelectProductAttributeView.h"
#import "ProductTopCell.h"
#import "CartListModel.h"
#import "CartViewController.h"
#import "OderInfoNewTwo.h"
#import "OderInfoNew.h"
#import "OrderInfoModel.h"
@interface ProductViewController1 ()<UITableViewDelegate,UITableViewDataSource>
{
    SelectProductAttributeView *buy;
    NSString *buyNumStr;
    
    NSString * overAgein;//是否选择完购物车跳转   1选择规格 2.立即购买 3.加入购物车
}
@property (nonatomic, strong) UILabel *flagView;
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation ProductViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = Color(@"f5f5f5");
    [self setupMainView];
    // Do any additional setup after loading the view.
}
- (void)setupMainView{
      UIView *bottomView = [UIView new];
      bottomView.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:bottomView];
      [bottomView mas_makeConstraints:^(MASConstraintMaker *make){
          make.bottom.offset(0);
          make.width.offset(ScreenWidth);
          make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
      }];
      UIButton *cartBtn = [UIButton new];
      [cartBtn setImage:[UIImage imageNamed:@"details_ic_cart"] forState:0];
      [cartBtn addTarget:self action:@selector(cartListPress) forControlEvents:UIControlEventTouchUpInside];
      [bottomView addSubview:cartBtn];
      [cartBtn mas_makeConstraints:^(MASConstraintMaker *make){
          make.left.offset(0);
          make.top.offset(0);
          make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
          make.width.offset(ScreenWidth-(290*AUTOLAYOUT_WIDTH_SCALE));
      }];
      
      UILabel *flagView=[UILabel new];
      flagView.backgroundColor=[UIColor redColor];
      flagView.layer.masksToBounds = YES;
      flagView.layer.cornerRadius = 7;
      flagView.textAlignment=NSTextAlignmentCenter;
      flagView.font=[UIFont systemFontOfSize:8];
      flagView.textColor=[UIColor whiteColor];
      self.flagView=flagView;
     
      [cartBtn addSubview:flagView];
      [flagView mas_makeConstraints:^(MASConstraintMaker *make){
          make.centerX.equalTo(cartBtn).offset(+15);
          make.top.offset(10);
          make.height.offset(14);
          make.width.offset(14);
      }];
      
      
      UIButton *orderBtn = [UIButton new];
      [orderBtn setTitle:@"Order Now" forState:0];
      [orderBtn setBackgroundColor:[UIColor blackColor]];
      orderBtn.titleLabel.font = font(16);
      orderBtn.titleLabel.textColor = [UIColor whiteColor];
      [orderBtn addTarget:self action:@selector(orderNowPress) forControlEvents:UIControlEventTouchUpInside];
      [bottomView addSubview:orderBtn];
      [orderBtn mas_makeConstraints:^(MASConstraintMaker *make){
          make.left.equalTo(cartBtn.mas_right).offset(0);
          make.top.offset(0);
          make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
          make.width.offset(145*AUTOLAYOUT_WIDTH_SCALE);
      }];
      UIButton *AddBtn = [UIButton new];
      [AddBtn setTitle:@"Add To Cart" forState:0];
      [AddBtn setBackgroundColor:Color(@"#F6AA00")];
      AddBtn.titleLabel.font = font(16);
      AddBtn.titleLabel.textColor = Color(@"#ffffff");
      [AddBtn addTarget:self action:@selector(cartPress) forControlEvents:UIControlEventTouchUpInside];
      [bottomView addSubview:AddBtn];
      [AddBtn mas_makeConstraints:^(MASConstraintMaker *make){
          make.left.equalTo(orderBtn.mas_right).offset(0);
          make.top.offset(0);
          make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
          make.width.offset(145*AUTOLAYOUT_WIDTH_SCALE);
      }];
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
      self.tableView = tableview;
      tableview.estimatedRowHeight = 94;
      tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
      tableview.backgroundColor = Color(@"#F5F5F5");
    tableview.delegate = self;
     tableview.dataSource = self;
      tableview.scrollEnabled=NO;
    tableview.backgroundColor=[UIColor yellowColor];
      tableview.rowHeight = UITableViewAutomaticDimension;
      [tableview registerClass:[ProductTopCell class] forCellReuseIdentifier:@"ProductTopCell"];
      [self.view addSubview:tableview];
      
      [tableview mas_makeConstraints:^(MASConstraintMaker *make){
          make.top.offset(0);
          make.width.offset(ScreenWidth);
         make.bottom.offset(-50*AUTOLAYOUT_WIDTH_SCALE);
          
      }];
    
    [self getData];
}
- (void)getData{
    ProductDetailModel *model=[[ProductDetailModel alloc]init];
    model.product_id=_product_id;
//    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model productDetailModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        
        if ([code intValue]==200) {
            ProductDetailModel *model=(  ProductDetailModel *)data;
               self.productModel=model.data.product;
            
               [self.tableView reloadData];
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
    if (_productModel.long_img.count>0) {
        return  _productModel.long_img.count;
    }
    else
    {
        return   _productModel.thumbnail_img.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductTopCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_productModel.long_img.count>0) {
        cell.productModel=_productModel.long_img[indexPath.row];
    }
    else
    {
        cell.productModel=_productModel.thumbnail_img[indexPath.row];
    }
    
    
    return cell;
    
}
- (void)cartListPress{
    BOOL isExit=NO;
    for(UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:[CartViewController class]]){
            isExit=YES;
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
    
    if (isExit==NO) {
        CartViewController *cart=[[CartViewController alloc]init];
        cart.ishiddenTabBarController=YES;//隐藏tabbar
        [self.navigationController pushViewController:cart animated:YES];
        
    }
    
}
- (void)cartPress{
    overAgein = @"2";//加入购物车
    if (buyNumStr == nil) {
        [self selectProductAttributeView];
        return;
    }
    [self addCart];
    
}

- (void)choiceTypeBtnClick{
    
    overAgein = @"1";
    [self selectProductAttributeView];
}

- (void)orderNowPress{
    overAgein = @"3";//立即购买
    if (buyNumStr == nil) {
        [self selectProductAttributeView];
        return;
    }
    [self setOrder];
}
- (void)selectProductAttributeView{
    buy=[[SelectProductAttributeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    NSString* encodedString =[_productModel.main_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    
    [buy.goodImaView  sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
 //   buy.priceLab.text=self.moneyNewLab.text;
    buy.num=buyNumStr;
    __block ProductViewController1 * blockSelf = self;
    
    buy.numBlock = ^(NSString * _Nonnull num,NSString *type) {
        buyNumStr=num;
  //      blockSelf.SelectDetailLab.text=[NSString stringWithFormat:@"Quantity x%@",num];
        
        if ([blockSelf->overAgein isEqualToString:@"2"]) {
            [blockSelf addCart];
        }
        if ([blockSelf->overAgein isEqualToString:@"3"]) {
            [blockSelf setOrder];
        }
    };
    buy.cancelBlock = ^{
        //   buyNumStr=nil;
    };
    [self.view.window addSubview:buy];
    
    
}
- (void)setOrder{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    
    if (uid.length>0) {
        [self addCartToNetWithType:@"setOrder" ];
    }
    else
    {
        if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
            LoginViewController *log = [LoginViewController new];
            YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
            
            log.isPresent=@"2";
            [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
        }
        else
        {
            [self addCartToNetWithType:@"setOrder" ];
        }
    }
    
}
- (void)addCart{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    
    if (uid.length>0) {
        [self addCartToNetWithType:@"addCart" ];
    }
    else
    {
        if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
            LoginViewController *log = [LoginViewController new];
            YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
            
            log.isPresent=@"2";
            [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
        }
        else
        {
            [self addCartToNetWithType:@"addCart" ];
        }
    }
    
}
- (void)addCartToNetWithType:(NSString *)type{
    AddCartModel *model=[[AddCartModel alloc]init];
    model.product_id=_product_id;
    model.qty=buyNumStr;
    
    if ([type isEqualToString:@"setOrder"]) {
        model.buy_now=@"1";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model AddCartModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            
            if ([type isEqualToString:@"addCart"]) {
                
             //   [self getCartNum];
            }
            else
            {
                
                NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
                
                if (uid.length>0) {
                    
                    OderInfoNew  *one=[[OderInfoNew alloc]init];
                    [self.navigationController pushViewController:one animated:YES];
                }
                else
                {
                    
                    [MBProgressHUD showMessage:nil toView:self.view];
                    OrderInfoModel *info=[[OrderInfoModel alloc]init];
                    info.refresh=@"0";
                    [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list  ,id  _Nonnull payments,NSDictionary *contryDic) {
                        
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        if ([code intValue]==200) {
                            OrderInfoModel *model=(OrderInfoModel *)address_list;
                            
                            NSArray *arr=(NSArray *)model.address_list;
                            if (arr.count>0) {
                                OderInfoNewTwo *one=[[OderInfoNewTwo alloc]init];
                                [self.navigationController pushViewController:one animated:YES];
                            }
                            else
                            {
                                OderInfoNew  *one=[[OderInfoNew alloc]init];
                                [self.navigationController pushViewController:one animated:YES];
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
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:message toView:self.view];
        });
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        
    }];
}

@end
