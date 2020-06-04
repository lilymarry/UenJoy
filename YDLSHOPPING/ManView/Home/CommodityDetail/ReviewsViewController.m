//
//  ReviewsViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ReviewsViewController.h"
#import "ReviewsCell.h"
#import "CartListModel.h"
@interface ReviewsViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UILabel *flagView;
@end

@implementation ReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
 
    
}
- (void)getCartNum{
    CartListModel *model=[[CartListModel alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model CartListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      
        if ([code intValue]==200) {
            CartListModel *model= (CartListModel *)data;
            if (model.data.cart_info.products.count>0) {
                
                NSArray *arr=model.data.cart_info.products;
                NSInteger index=0;
                for (  CartListModel *submodel in arr) {
                    index= [submodel.qty intValue]+index;
                }
            
                self.flagView.hidden=NO;
                if (index >99) {
                      self.flagView.text= @".";
                 }
                 else
                 {
                     self.flagView.text=[NSString stringWithFormat:@"%ld",(long)index] ;
                }
            }
            else
            {
                self.flagView.hidden=YES;
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
- (void)getData{
    ProductDetailModel *model=[[ProductDetailModel alloc]init];
    model.product_id=_product_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model productDetailModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
          ProductDetailModel *model=(  ProductDetailModel *)data;
            self.dataArr=[NSArray arrayWithArray:model.data.productReview.coll];
          
           [self setUpMainView];
       
           
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
- (void)setUpMainView{
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.offset(5);
        make.height.offset(95);
        
    }];
    UIImageView *imageView;
    for (int i = 0; i < 5; i++){
        NSInteger x = 5;
       imageView = [[UIImageView alloc]init];
    
            imageView.image = [UIImage imageNamed:@"reviewed-heart-solid"];
  
        [view1 addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.offset(15);
            make.width.offset(18);
            make.height.offset(15);
            make.left.offset((x + 18)*i + 10);
        }];
    }
    
    UILabel *num = [UILabel new];
    num.textColor = Color(@"#333333");
    num.font = font(12);
    num.text=@"5.0";
    num.numberOfLines = 0;
    
    [view1 addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make){
          make.centerY.equalTo(imageView);
    make.left.equalTo(imageView.mas_right).offset(15);
        
        make.height.offset(14);
    }];
    
    UILabel *Reviews = [UILabel new];
    Reviews.textColor = Color(@"#333333");
    Reviews.font = font(14);
    Reviews.text=@"Customer Reviews";
    Reviews.numberOfLines = 0;
    
    [view1 addSubview:Reviews];
    [Reviews mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(imageView);
        make.right.equalTo(view1.mas_right).offset(-10);
        
        make.height.offset(14);
    }];
    
    UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sortBtn.layer.borderWidth = 1;
    sortBtn.layer.borderColor =Color(@"#CCCCCC").CGColor;
    sortBtn.backgroundColor=Color(@"F5F5F5");
    [view1 addSubview:sortBtn];
    [sortBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.height.offset(30);
        
         make.right.offset(-10);
        make.left.offset(10);
    }];
    
    
     UIImageView * imageFlag=[UIImageView new];
    imageFlag.image=[UIImage imageNamed:@"灰色下箭头"];
    [sortBtn addSubview:imageFlag];
     [imageFlag mas_makeConstraints:^(MASConstraintMaker *make){
         make.right.offset(-9.5);
        make.height.offset(7.2);
        make.width.offset(12);
        make.centerY.equalTo(sortBtn);
    }];
    
    UILabel *sortLab = [UILabel new];
    sortLab.textColor = Color(@"#AAAAAA");
    sortLab.font = font(12);
    sortLab.text=@"Default sort";
    sortLab.numberOfLines = 0;
    
    [sortBtn addSubview:sortLab];
    [sortLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(imageFlag).offset(-10);
        make.centerY.equalTo(sortBtn);
        make.left.offset(10);
        
        
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = Color(@"F5F5F5");
    [view1 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make){
    make.bottom.equalTo(view1.mas_bottom).offset(-1);
        make.width.offset(ScreenWidth);
      
        make.height.offset(1);
        
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.offset(0);
        make.width.offset(ScreenWidth);
         make.height.offset(0);
       // make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
    }];
    UIButton *cartBtn = [UIButton new];
    [cartBtn setImage:[UIImage imageNamed:@"details_ic_cart"] forState:0];
    [bottomView addSubview:cartBtn];
    [cartBtn addTarget:self action:@selector(cartList) forControlEvents:UIControlEventTouchUpInside];
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
     //  flagView.hidden=YES;
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
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
   // tableview.tableFooterView = [UIView new];
  //  tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableview.bounds.size.width, 15)];
  //  self.tableView = tableview;
    tableview.estimatedRowHeight = 94;  //在iOS10中，estimatedRowHeight必须要有一个值，否则就会页面默认44
  //  tableview.estimatedSectionHeaderHeight = 38;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor =[UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.emptyDataSetSource = self;
    tableview.emptyDataSetDelegate = self;
   tableview.rowHeight = UITableViewAutomaticDimension;
   [tableview registerClass:[ReviewsCell class] forCellReuseIdentifier:@"ReviewsCell"];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view1.mas_bottom).offset(1);
        make.bottom.equalTo(bottomView.mas_top).offset(-1);
      
        make.width.offset(ScreenWidth);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        ReviewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReviewsCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArr[indexPath.row];
        return cell;
  
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"Reviews_pic"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"Hello, be the first person to evaluate.";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName:Color(@"#666666")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100.0;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}
- (void)cartList{

}
- (void)cartPress{

 
}

- (void)choiceTypeBtnClick{

}

- (void)orderNowPress{

}
- (void)selectProductAttributeView{
 
    
}
- (void)setOrder{
   NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    NSLog(@"Tourist_id %@",uid);
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

 
}
- (void)addCartToNetWithType:(NSString *)type{
 
}
@end
