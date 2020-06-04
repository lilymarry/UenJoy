//
//  CategoriesViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/5.
//  Copyright © 2019 sunjiayu. All rights reserved.
//
#import "CategoriesViewController.h"
#import "CategoryTableViewCell.h"
#import "NotificationViewController.h"
#import "CategoriesModel.h"
#import "CategoryRightCell.h"
#import "CategoriesDetailController.h"
#import "SearchViewController.h"
@interface CategoriesViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *topImageUrl;
   // NSString *categories_id;
    NSString *detailTitle;
    NSArray *imageArr;
    NSInteger imageIndex;
   
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionArr;


@end

@implementation CategoriesViewController

-(NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setNavi];
    [self setMainView];
    [self getData];
    imageArr=@[@"sofa",@"pic_beds",@"chair",@"table",@"storage",@"bath",@"garden",@"kids",@"appliance",@"lifestyle",@"BI",@"sale"];
    imageIndex=0;
}
- (void)getData{
    CategoriesModel *model=[[CategoriesModel alloc]init] ;
     [MBProgressHUD showMessage:nil toView:self.view];
    [model categoriesModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
        
        CategoriesModel *model=(CategoriesModel *)data;
        self.dataSource =[NSMutableArray arrayWithArray:  model.data];
        if (self.dataSource.count>0) {
          
            CategoriesModel *Submodel=self.dataSource[0];
            self.collectionArr =[NSMutableArray arrayWithArray:Submodel.child];
             Submodel.isSelect=YES;
            detailTitle=Submodel.name;
             topImageUrl=Submodel.thumbnail_imageurl;
           // categories_id=Submodel._id;
        }
        [self.tableview reloadData];
        [self.collectionView reloadData];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setNavi{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImageView *naviImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 71, 21)];
    naviImageView.contentMode = UIViewContentModeScaleAspectFit;
    naviImageView.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = naviImageView;
    
    UIButton *btnL = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnL setImage:[UIImage imageNamed:@"nav_btn_essage" ] forState:UIControlStateNormal];
    [btnL addTarget:self action:@selector(goMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemL = [[UIBarButtonItem alloc] initWithCustomView:btnL];
    self.navigationItem.leftBarButtonItem = backItemL;
    
    UIButton *btnR = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnR setImage:[UIImage imageNamed:@"nav_btn_search" ] forState:UIControlStateNormal];
      [btnR addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItemR = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = backItemR;
}

- (void)setMainView{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NaviBarAndStatusBarHeight, 90*AUTOLAYOUT_WIDTH_SCALE, ScreenHeight-TabBarHeight-NaviBarAndStatusBarHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.backgroundColor = Color(@"#f5f5f5");
    tableview.delegate = self;
    tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableview.dataSource = self;
    tableview.tableFooterView = [UIView new];
    [tableview registerClass:[CategoryTableViewCell class] forCellReuseIdentifier:@"categoryCell"];
    
    adjustsScrollViewInsets_NO(self.tableview, self);

    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];

    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 90*AUTOLAYOUT_WIDTH_SCALE, NaviBarAndStatusBarHeight,ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE, ScreenHeight-TabBarHeight-NaviBarAndStatusBarHeight) collectionViewLayout:collectionLayout];
    self.collectionView=collectionView;
    self.collectionView.backgroundColor =[UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    

    
      [_collectionView registerNib:[UINib nibWithNibName:@"CategoryRightCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryRightCell"];
  
       [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
  
}



#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42*AUTOLAYOUT_WIDTH_SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    cell.backgroundColor = Color(@"f5f5f5");
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CategoriesModel *model=self.dataSource[indexPath.row];
    cell.titleText.text =model.name;
    if(model.isSelect==YES ){
        cell.titleText.textColor = Color(@"#F6AA00");
        cell.contentView.backgroundColor = Color(@"#ffffff");
    }else{
        cell.titleText.textColor = Color(@"#333333");
        cell.contentView.backgroundColor = Color(@"#f5f5f5");
    }
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CategoriesModel *model=self.dataSource[indexPath.row];
    self.collectionArr =[NSMutableArray arrayWithArray:model.child];
    topImageUrl=model.thumbnail_imageurl;
    [self cherkArrNotSelect];
    model.isSelect=YES;
    
  //  categories_id=model._id;
    detailTitle=model.name;
    imageIndex=indexPath.row;
    [self.tableview reloadData];
    
    [self.collectionView reloadData];
}
#pragma mark UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArr.count-1;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryRightCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryRightCell" forIndexPath:indexPath];
   CategoriesModel*get=  self.collectionArr[indexPath.item+1];
   cell.titleLab.text=get.name;
    NSString* encodedString =[get.thumbnail_imageurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码

    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    return cell;
}
#pragma mark - CollectionView的item的布局
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
        return CGSizeMake((ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE)/2-8,(ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE)/2-8+50);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
       CategoriesModel*get=  self.collectionArr[indexPath.item+1];
    detail.categories_id=get._id;;
    detail.isShowCategoriesTitle=YES;
    
    detail.categoriesTitleArr=  self.collectionArr;
    detail.title=detailTitle;
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
  
    CGSize size = {ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE,(ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE)*196/552};
        return size;
}

#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
            
        }
        headerView.backgroundColor = [UIColor whiteColor];
        for(UIView *subView in headerView.subviews ) {
            [subView removeFromSuperview];
        }
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE-20, (ScreenWidth- 90*AUTOLAYOUT_WIDTH_SCALE-20)*196/552)];
        [headerView addSubview:imageView];
      
       //   NSString* encodedString =[topImageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
       //  [imageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    
        imageView.image=[UIImage imageNamed:imageArr[imageIndex]];
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTopIamge)];
        
        [imageView addGestureRecognizer:tap];
        return headerView;
    }
    return nil;
   
}
- (void)cherkArrNotSelect{
    
    for (CategoriesModel *model in self.dataSource) {
        if (model.isSelect) {
            model.isSelect=NO;
        }
    }
}
- (void)tapTopIamge{
 
    if (self.collectionArr.count==0) {
        return;
    }
       CategoriesDetailController *detail=[[CategoriesDetailController alloc]init];
        CategoriesModel*get=  self.collectionArr[0];
      detail.categories_id=get._id;
      detail.isShowCategoriesTitle=YES;
      
      detail.categoriesTitleArr=  self.collectionArr;
      detail.title=detailTitle;
      [self.navigationController pushViewController:detail animated:YES];
}
-(void)goMessage{
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
- (void)goSearch{
    SearchViewController  *search =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
@end

