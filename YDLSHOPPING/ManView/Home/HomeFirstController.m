//
//  HomeFirstController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HomeFirstController.h"
#import "HomeFirstTopView.h"
#import "HomeFirstGoodCell.h"
#import "HomeFirest_headerView.h"
#import "HomeFirstModel.h"
#import "SNBannerView.h"
#import "NotificationViewController.h"
#import "HomeFirstMoreCell.h"
#import "CategoriesDetailController.h"
#import "CommodityDetailViewController.h"
#import "SearchViewController.h"
#import "HomeFirstFootView.h"
@interface HomeFirstController ()<UICollectionViewDelegate,UICollectionViewDataSource,SNBannerViewDelegate>
{
    HomeFirstTopView * top;//To
    NSArray *bannerArr;
  
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;
@property(strong ,nonatomic )NSMutableArray *mainData;
@end

@implementation HomeFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavi];
    [self createUI];
     [self getData];
    
}

- (void)setNavi{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIImageView *naviImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 71, 21)];
    naviImageView.contentMode = UIViewContentModeScaleAspectFit;
    naviImageView.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = naviImageView;
    
    UIButton *btnL = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnL addTarget:self action:@selector(goNotification) forControlEvents:UIControlEventTouchUpInside];
    [btnL setImage:[UIImage imageNamed:@"nav_btn_essage" ] forState:UIControlStateNormal];
    UIBarButtonItem *backItemL = [[UIBarButtonItem alloc] initWithCustomView:btnL];
    self.navigationItem.leftBarButtonItem = backItemL;
    
    UIButton *btnR = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnR setImage:[UIImage imageNamed:@"nav_btn_search" ] forState:UIControlStateNormal];
    [btnR addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemR = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = backItemR;
}

- (void)createUI {
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollection.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollection.showsHorizontalScrollIndicator = NO;
    _mCollection.showsVerticalScrollIndicator = NO;
    
    //Header
    [_mCollection registerNib:[UINib nibWithNibName:@"HomeFirest_headerView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFirest_headerView"];
    
     [_mCollection registerNib:[UINib nibWithNibName:@"HomeFirstFootView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeFirstFootView"];
    //Cell
    [_mCollection registerNib:[UINib nibWithNibName:@"HomeFirstGoodCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeFirstGoodCell"];
   
    [_mCollection registerNib:[UINib nibWithNibName:@"HomeFirstMoreCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeFirstMoreCell"];
    
    top = [[HomeFirstTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/3*2+270+282+50+60)];
    __block HomeFirstController * blockSelf = self;
    top.itemBlock = ^(HomeFirstModel * _Nonnull model) {
        CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
         detail.categories_id=model._id;
        detail.isShowCategoriesTitle=YES;
        detail.title=model.name;
        detail.categoriesTitleArr=[NSMutableArray arrayWithArray:model.child];
        detail.type=@"1";
        [blockSelf.navigationController pushViewController:detail animated:YES];
        
    };
    top.titleBlock = ^(NSInteger index) {
        
        if (blockSelf.mainData.count>0) {
            HomeFirstModel *sub= blockSelf.mainData[0];
            NSMutableArray *arr=[NSMutableArray arrayWithArray:sub.child];
        HomeFirstModel *  model   = arr[index];
            CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
                    detail.categories_id=model._id;
                   detail.isShowCategoriesTitle=YES;
            detail.categoriesTitleArr=[NSMutableArray arrayWithArray:arr];
                  detail.type=@"1";
           
            detail.title=sub.name;
          
                 
        [blockSelf.navigationController pushViewController:detail animated:YES];
                     
        }
        
    };
    [_mCollection addSubview:top];
   
}
- (void)getData{
    HomeFirstModel *model=[[HomeFirstModel alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model homeFirstModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            HomeFirstModel *home=(HomeFirstModel *)data;
            //轮播图
           
            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/375*129) delegate:self model:home.data.banners URLAttributeName:@"banner_img_url" placeholderImageName:@"null-picture" currentPageTintColor:[UIColor darkTextColor] pageTintColor:[UIColor lightGrayColor]numLab:YES page:NO];
                                   
            [top.bannerView addSubview:banner];
            
            bannerArr=[NSArray arrayWithArray:home.data.banners];
            top.datas=[NSArray arrayWithArray:home.data.categoryindex];
            
            self.mainData=[NSMutableArray array];
           
            if (home.data.categoryindex.count>0) {
                HomeFirstModel *sub=  home.data.categoryindex[0];

                  top.header1Name.text=sub.name;


               NSString* encodedString =[sub.thumbnail_app stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码

                [ top.header1Image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];

             
                NSMutableArray *arr=[NSMutableArray arrayWithArray:sub.child];

                if (arr.count>0) {
                    HomeFirstModel *model=   arr[0];
                    [arr addObject:model];
                }
                top.titleArr=[NSArray arrayWithArray:arr];
                
                for (int i=0;i< home.data.categoryindex.count; i++) {
                    
                    HomeFirstModel *model=   home.data.categoryindex[i];
                     NSArray *da=   model.content_products;
                    if (da.count>0) {
                        [model.content_products addObject:da[0]];
                    }
                    
                    if (![model.name isEqualToString:@"SALE"]) {
                        [self.mainData addObject:model];
                    }
                }

            }
            top.collectionView.hidden=YES;
              top.collectionViewHHH.constant=0;
            top.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth/375*129+270+40+30+40);
            [self.mCollection reloadData];
          
            
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
#pragma mark UICollectionView
//分区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
          return self.mainData.count;
  
   
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        HomeFirstModel *home=self.mainData[section];
            return home.content_products.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
            return UIEdgeInsetsMake( ScreenWidth/375*129+270+40+30+40, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth/2 - 2.5, ScreenWidth/2 - 2.5 + 24 + 40 + 15 );
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGSize size = {0.01,0.01};
        return size;
    }
   
    else
    {
        CGSize size = {ScreenWidth,80};
        return size;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
 
    if (section==self.mainData.count-1&&self.mainData.count>0) {
         CGSize size = {ScreenWidth,50};
           return size;
    }
    CGSize size = {ScreenWidth,0.01};
    return size;
   
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        HomeFirest_headerView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFirest_headerView" forIndexPath:indexPath];
        HomeFirstModel *home=self.mainData[indexPath.section];
        
          NSString* encodedString =[home.thumbnail_app stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        
        [header.header1Image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
        header.header1Name.text=home.name;
       NSMutableArray *arr=[NSMutableArray arrayWithArray:home.child];

                     if (arr.count>0) {
                         HomeFirstModel *model=   arr[0];
                         [arr addObject:model];
                     }
                   header.titleArr=[NSArray arrayWithArray:arr];
   __block HomeFirstController * blockSelf = self;
   header.titleBlock = ^(NSInteger index) {
       if (blockSelf.mainData.count>0) {
           HomeFirstModel *sub= blockSelf.mainData[indexPath.section];
           NSMutableArray *arr=[NSMutableArray arrayWithArray:sub.child];
       HomeFirstModel *  model   = arr[index];
           CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
                detail.categories_id=model._id;
               detail.isShowCategoriesTitle=YES;
                detail.categoriesTitleArr=[NSMutableArray arrayWithArray:arr];
                detail.type=@"1";
         
                 detail.title=sub.name;
                
       [blockSelf.navigationController pushViewController:detail animated:YES];
                    
       }
       
   };
        reusableview = header;
        
    }
    else
    {
       HomeFirstFootView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeFirstFootView" forIndexPath:indexPath];
         reusableview = header;
    }
    
    return reusableview;
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HomeFirstModel *home=self.mainData[indexPath.section];
    HomeFirstModel *subHome=home.content_products[indexPath.row];
    if (indexPath.row!=home.content_products.count-1) {
        
        HomeFirstGoodCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFirstGoodCell" forIndexPath:indexPath];
        
           NSString* encodedString =[subHome.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        
        [cell.goodImage sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
        
        cell.nameLab.text=subHome.name;
        NSString *str1=[NSString stringWithFormat:@"$%.2f",[subHome.special_price doubleValue]];
        NSString *str2=[NSString stringWithFormat:@"$%.2f",[subHome.price doubleValue]];
        
        
        if ([subHome.special_price doubleValue]==0 ) {
            cell.priceLab.text= str2;
        }
        else if ([subHome.price doubleValue]==0)
        {
            cell.priceLab.text= str1;
        }
        else
        {
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",str1,str2]];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(str1.length+2,str2.length)];
            
            [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length+2,str2.length)];
            [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length+2,str2.length)];
            
            [AttributedStr addAttribute:NSFontAttributeName value:font(12) range:NSMakeRange(str1.length+2,str2.length)];
            
            cell.priceLab.attributedText=AttributedStr;
        }
        return cell;
      
    }
    else
    {
        HomeFirstMoreCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFirstMoreCell" forIndexPath:indexPath];
        cell.nameLab.text=@"More";
        return cell;
 }
   
   
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeFirstModel *home=self.mainData[indexPath.section];
    HomeFirstModel *subHome=home.content_products[indexPath.row];
    if (indexPath.row!=home.content_products.count-1) {
        CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
        
        detail.product_id=subHome._id;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else{
        CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
        detail.categories_id=home._id;

     
        detail.isShowCategoriesTitle=YES;
        detail.categoriesTitleArr=[NSMutableArray arrayWithArray:home.child];
        detail.type=@"1";
        
        
        detail.title=home.name;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
#pragma mark button
- (void)goNotification{
    if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {

         LoginViewController *log = [LoginViewController new];
         YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
         log.isPresent=@"2";
         [[UIApplication sharedApplication] keyWindow].rootViewController=navi;

         return;
     }
    
    NotificationViewController *noti = [NotificationViewController new];
    [self.navigationController pushViewController:noti animated:YES];
}
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index
{
    HomeFirstModel *model=bannerArr[index];
    if ( [model.cat intValue]==2) {
        CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
      
        detail.product_id=model.cid;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if ( [model.cat intValue]==1)
    {
        
        CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
        detail.categories_id=model.cid;
        
        detail.isShowCategoriesTitle=NO;
        
        detail.title=model.title;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else
    {
        self.tabBarController.selectedIndex=1;
    }

}
- (void)goSearch{
    SearchViewController  *search =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
@end
