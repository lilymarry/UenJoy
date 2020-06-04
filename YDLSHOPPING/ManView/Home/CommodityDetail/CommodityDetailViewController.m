//
//  CommodityDetailViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import <FSPageContentView.h>
#import <FSSegmentTitleView.h>
#import "ProductViewController.h"
#import "ConbinationViewController.h"
#import "RelatedViewController.h"
#import "ReviewsViewController.h"
#import "ProductDetailModel.h"
#import "AddOrDeleteFavoriteModel.h"
#import "GetFavoriteStateModel.h"
#import "ShareView.h"
#import "CartListModel.h"
@interface CommodityDetailViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
{
    UIButton *  collectBtn;
    
    NSString *isFav;
  
}
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation CommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"#f5f5f5");
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, ScreenWidth, 37) titles:@[@"Product",@"Combination",@"Related",@"Review"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:13];
    self.titleView.selectIndex = 0;
    
    [self.view addSubview:_titleView];
    
    
    collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 44, 44);
    [collectBtn setImage:[UIImage imageNamed:@"未收藏"] forState:UIControlStateNormal];
    [collectBtn setBackgroundColor:[UIColor whiteColor]];
    [collectBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(CGRectGetMaxX(collectBtn.frame), 0, 44, 44);
    [rightBtn2 addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn2 setBackgroundColor:[UIColor clearColor]];
     [rightBtn2 setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
  //  UIBarButtonItem * rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
  //  self.navigationItem.rightBarButtonItems = @[rightItem2,rightItem1];
    
    self.navigationItem.rightBarButtonItem=rightItem1;

    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
              ProductViewController *product=[[ProductViewController alloc]init];
             product.product_id=self.product_id;
           ReviewsViewController*revievs=[[ReviewsViewController alloc]init];
                 revievs.product_id=self.product_id;
           
              [childVCs addObjectsFromArray:@[product,[ConbinationViewController new],[RelatedViewController new],revievs]];
              
              self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight+37, ScreenWidth, ScreenHeight-(NaviBarAndStatusBarHeight+37)) childVCs:childVCs parentVC:self delegate:self];
              self.pageContentView.contentViewCurrentIndex = 0;
             
              [self.view addSubview: self.pageContentView];
    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
            
                                if (uid.length==0) {
                                    [self getFavorite];
                            }
         

}


- (void)getFavorite{
    
    GetFavoriteStateModel *model=[[GetFavoriteStateModel alloc]init];
    model.product_id=_product_id;
  //  [MBProgressHUD showMessage:nil toView:self.view];
    [model getFavoriteStateModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetFavoriteStateModel *model=( GetFavoriteStateModel *)data;
            //(1是2否)。
            isFav=[NSString stringWithFormat:@"%d",[model.data.fav intValue]];
            if ([model.data.fav intValue]==1) {
                
               [collectBtn setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
            }
            else
            {
              [collectBtn setImage:[UIImage imageNamed:@"未收藏"] forState:UIControlStateNormal];
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
#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
}
- (void)collectClick{
if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
    
    LoginViewController *log = [LoginViewController new];
       YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
       log.isPresent=@"2";
       [[UIApplication sharedApplication] keyWindow].rootViewController=navi;

    return;
}
    
    
    AddOrDeleteFavoriteModel *data=[[AddOrDeleteFavoriteModel alloc]init];
    data.product_id=_product_id;
    if ([isFav isEqualToString:@"1"]) {
        data.type=@"del";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [ data addOrDeleteFavoriteModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            [self getFavorite];
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
- (void)shareClick{
    
    ShareView *view=[[ShareView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view.window addSubview:view];
    
}
@end
