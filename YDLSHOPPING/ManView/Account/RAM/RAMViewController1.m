//
//  RAMViewController1.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RAMViewController1.h"
#import "RAMListView.h"
#import "SNPageView.h"
#import "RAMListModel.h"
#import "RAMDetailViewController.h"
#import "PayCancelModel.h"
#import "ReviewLlistMdel.h"
#import "AddReviewsViewController.h"
#import "CouponListModel.h"
@interface RAMViewController1 ()
{
    RAMListView * listView;
    NSInteger  page;
    NSString *subType;
    NSMutableArray * arr;//列表
}
@end

@implementation RAMViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color(@"f5f5f5");
    if ([self.type isEqualToString:@"RAM"]) {
        self.title = @"RAM";
    }
    else  if ([self.type isEqualToString:@"discount"]) {
        self.title =  @"My Discount Coupons";;
    }
    else  {
        self.title = @"Review";
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenWidth, ScreenHeight - 64.5) p_style:PageViewStyleLine];
    if ([self.type isEqualToString:@"RAM"]) {
        pageView.subViews = @[[RAMListView class],[RAMListView class],[RAMListView class]];
        pageView.titles = @[@"No Application",@"Applying",@"Completed"];;
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/3;
        pageView.goundNormalColor = [UIColor whiteColor];
    }
    else  if ([self.type isEqualToString:@"discount"]) {
        pageView.subViews = @[[RAMListView class],[RAMListView class],[RAMListView class]];
        pageView.titles = @[@"Available",@"Applied",@"Expired"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/3;
        pageView.goundNormalColor =  [UIColor whiteColor];
        //Color(@"f5f5f5");
    }
    else  {
        pageView.subViews = @[[RAMListView class],[RAMListView class]];
        pageView.titles =  @[@"Add Review",@"Reviewed"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/2;
        pageView.goundNormalColor = [UIColor whiteColor];
    }
    pageView.titleSelectedFont = font(15);
    pageView.titleNormalFont=font(15);
    
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    
    __block RAMViewController1 * blockSelf = self;
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
          [arr removeAllObjects];
        if (index == 0) {
            listView = subView;
            subType=@"1";
            
        } else if (index == 1) {
            listView = subView;
            subType=@"2";
            
        } else if (index == 2) {
           listView = subView;
            subType=@"3";
            
        }
        if ([self.type isEqualToString:@"RAM"]) {
          
               page = 1;
            [blockSelf initRefresh];
            [blockSelf showModel];
        }
        
        else  {
            
            [blockSelf showModel];
        }
        
        
       listView.cellBlock = ^(RAMListModel * _Nonnull model, NSString * _Nonnull subType) {
            RAMDetailViewController *detail =[[RAMDetailViewController alloc]init];
            detail.list=model;
            detail.flag=[subType isEqualToString:@"2"] ? 1:2;
            detail.cancellBlock = ^{
                page = 1;
                [blockSelf initRefresh];
                [blockSelf showModel];
            };
            [blockSelf.navigationController pushViewController:detail animated:YES];
            
        };
         listView.btnBlock = ^(RAMListModel * _Nonnull model, NSString * _Nonnull reason) {
            
            PayCancelModel *pay=[[PayCancelModel alloc]init];
            pay.order_id=model.order_id;
            pay.detail=reason;
            pay.nickname= [[LoginModel shareInstance]getUserInfo].uinfo.nickname;
            pay.email= [[LoginModel shareInstance]getUserInfo].uinfo.email;
            [MBProgressHUD showMessage:nil toView:blockSelf.view];
            [pay PayCancelModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
                [MBProgressHUD hideAllHUDsForView:blockSelf.view animated:YES];
                [MBProgressHUD showSuccess:message toView:blockSelf.view];
                if ([code intValue]==200) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        page = 1;
                        [blockSelf initRefresh];
                        [blockSelf showModel];
                    });
                }
                
            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:blockSelf.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:blockSelf.view];
                
            }];
        };
        
       listView.reviewBtnBlock = ^(ReviewLlistMdel * _Nonnull model, NSString * _Nonnull subType ,NSString *code) {
            AddReviewsViewController *add=[[AddReviewsViewController alloc]init];
           add.codeSymbol=code;
            add.mainModel=model;
            add.block = ^{
                [blockSelf showModel];
            };
            [blockSelf.navigationController pushViewController:add animated:YES];
        };
        
    }];
    
}
- (void)initRefresh
{
    __block RAMViewController1 * blockSelf = self;
    listView.mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    listView.mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    
    if ([self.type isEqualToString:@"RAM"]) {
        RAMListModel * list = [[RAMListModel alloc] init];
        list.type = subType;
        list.p=[NSString stringWithFormat:@"%ld",(long)page];
        [MBProgressHUD showMessage:nil toView:self.view];
        
        [list RAMListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            RAMListModel * list = (RAMListModel *)data;
            
            if (page == 1) {
                
                if (list.data.coll.count>0) {
                  arr = [NSMutableArray arrayWithArray:list.data.coll];
                    [listView.mTable.mj_footer endRefreshing];
                }
                else
                {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
                
            } else {
                if (list.data.coll.count>0) {
                    [arr addObjectsFromArray:list.data.coll];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showModel:arr andType:@"RAM" subType:subType];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    }
    else  if ([self.type isEqualToString:@"discount"]) {
        CouponListModel *model=[[CouponListModel alloc]init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [model CouponListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==200) {
                CouponListModel *model =(   CouponListModel *) data;
                if ([subType isEqualToString:@"1"]) {
                    [listView showModel:model.data.coll andType:@"discount" subType:subType];
                }
                else if ([subType isEqualToString:@"2"])
                {
                    [listView showModel:model.data.coll1 andType:@"discount" subType:subType];
                }
                else
                {
                    [listView showModel:model.data.coll2 andType:@"discount" subType:subType];
                }
                [listView.mTable reloadData];
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
    
    else {
        ReviewLlistMdel *model=[[ReviewLlistMdel alloc]init];
        model.return_type= subType;
        [MBProgressHUD showMessage:nil toView:self.view];
        [model ReviewLlistMdelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==200) {
                ReviewLlistMdel *model =(   ReviewLlistMdel *) data;
               arr = [NSMutableArray arrayWithArray:model.data.productList];
      
    [listView showModel:arr andType:@"review" subType:subType];
                
                [listView.mTable reloadData];
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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}


@end
