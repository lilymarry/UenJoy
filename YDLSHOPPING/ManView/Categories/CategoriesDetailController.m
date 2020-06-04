//
//  CategoriesDetailController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoriesDetailController.h"
#import "CategoryDetailCell.h"
#import "CategoriesDetailModel.h"
#import "CategoriesModel.h"
#import "CommodityDetailViewController.h"
#import "CategoryAttributeModel.h"
#import "CategoryAllItemView.h"
#import "itemViewCell.h"
#import "HomeFirstModel.h"
@interface CategoriesDetailController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIScrollView  *scrollView;

    NSInteger  page;
    NSInteger  selectIndex;
    NSString *priceSort;
    NSMutableDictionary *AttributeDic;
   // NSDictionary *priceDic;
   // NSMutableDictionary *materialDic;
   // NSMutableDictionary *colorDic;
    BOOL selectFilter;
    
}
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHHH;
@property (strong, nonatomic)  UIView *lineView;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
//@property (weak, nonatomic) IBOutlet UIButton *materialBtn;
//@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;

@property (nonatomic, strong) NSMutableArray *collectionArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHH;
@property (nonatomic, strong) NSMutableArray *AttributeArr;


//@property (weak, nonatomic) IBOutlet UIView *itemView;
//@property (weak, nonatomic) IBOutlet UICollectionView *itemCollect;

//@property (nonatomic, strong) NSIndexPath *materialIndexPath;
//@property (nonatomic, strong) NSIndexPath *colorIndexPath;



@end

@implementation CategoriesDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    adjustsScrollViewInsets_NO(self.mCollect, self);
    
    if (isIOS10) {
        _topHH.constant=64;
    }
    else
    {
        _topHH.constant=0;
    }
    
    //按钮图片在右侧
    [_priceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _priceBtn.imageView.image.size.width-2, 0, _priceBtn.imageView.image.size.width)];
    [_priceBtn setImageEdgeInsets:UIEdgeInsetsMake(2, _priceBtn.titleLabel.bounds.size.width+10, 0, -_priceBtn.titleLabel.bounds.size.width)];
  
    


    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryDetailCell class]) bundle:nil] forCellWithReuseIdentifier:@"CategoryDetailCell"];
    
    if (_isShowCategoriesTitle) {
        UISwipeGestureRecognizer * recognizer;
        //添加右滑手势：
        recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [_mCollect addGestureRecognizer:recognizer];
        
        //  添加左滑手势：
        recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [_mCollect addGestureRecognizer:recognizer];
        _titleViewHHH.constant=40;
        _titleView.hidden=NO;
    }
    else
    {
        _titleViewHHH.constant=0;
        _titleView.hidden=YES;
    }

    AttributeDic =[NSMutableDictionary dictionary];
    [self getCategoryAttributeModel];
    
      page=1;
      _priceBtn.selected=NO;
      priceSort=@"price-high-to-low";
      
      if (_isShowCategoriesTitle) {
           [self initScrollView];
      }
    
      [self initRefresh];
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
}
- (void)viewWillDisappear:(BOOL)animated {
 self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    
}
- (void)getCategoryAttributeModel{
    CategoryAttributeModel * model=[[CategoryAttributeModel  alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [model CategoryAttributeModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSDictionary*  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if ([code intValue]==200) {
            NSDictionary *dic= data[@"attribute_search_list"];
            NSArray *keyarr=  [dic allKeys];
            self. AttributeArr=[NSMutableArray array];
            for (NSString *key in keyarr) {
                NSMutableDictionary *para=[NSMutableDictionary dictionary];
                [para setValue:key forKey:@"name"];
                NSMutableArray *dataArr1=[NSMutableArray array];
                for (NSString *string in dic[key] ) {
                    NSMutableDictionary *par=[NSMutableDictionary dictionary];
                    [par setValue:string forKey:@"name"];
                    [par setValue:@"0" forKey:@"isSelect"];
                    [dataArr1 addObject:par];
                    
                }
                [para setValue:dataArr1 forKey:@"content"];
                [para setValue:@"0" forKey:@"isExtend"];
                [self. AttributeArr addObject:para];
  
            }
        
        }else
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
-(void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer
{
 if(recognizer.direction ==UISwipeGestureRecognizerDirectionLeft) {
     if (selectIndex>=0&&selectIndex<_categoriesTitleArr.count-1) {
         
         selectIndex++;
         if ([_type isEqualToString:@"1"]) {
             HomeFirstModel *model=    _categoriesTitleArr[ selectIndex];
            _categories_id =model._id;
         }
         else
         {
             CategoriesModel  *model=    _categoriesTitleArr[ selectIndex];
                    _categories_id =model._id;
         }
       
         
         page=1;
         
         [self initScrollView];
         [self getData];
     }
     //   NSLog(@"swipe left");
        
    }if(recognizer.direction ==UISwipeGestureRecognizerDirectionRight) {
        if (selectIndex>0&&selectIndex<=_categoriesTitleArr.count-1) {
            selectIndex--;
            if ([_type isEqualToString:@"1"]) {
                       HomeFirstModel *model=    _categoriesTitleArr[ selectIndex];
                      _categories_id =model._id;
                   }
                   else
                   {
                       CategoriesModel  *model=    _categoriesTitleArr[ selectIndex];
                              _categories_id =model._id;
                   }
            
            page=1;
            
            [self initScrollView];
            [self getData];
            
           
        }

    //    NSLog(@"swipe right");
    }

}

- (void)initRefresh
{
    __block CategoriesDetailController * blockSelf = self;
    blockSelf.mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf getData];
    }];
    [_mCollect.mj_header beginRefreshing];
    blockSelf.mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf getData];
    }];
    
}
- (void)getData{
    CategoriesDetailModel *model=[[CategoriesDetailModel alloc]init];
    model.categoryId=_categories_id;
    model.sortColumn=priceSort;
    model.filterAttrs=AttributeDic;
    model.filterPrice=@"";
    model.p=[NSString stringWithFormat:@"%ld",(long)page];
 
    [MBProgressHUD showMessage:nil toView:self.view];

    [model categoriesDetailModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            CategoriesDetailModel *list= (CategoriesDetailModel *)data;
            if (page ==1) {
                [self.collectionArr removeAllObjects];
                if (list.data.products.count==0) {
                                      [self.mCollect.mj_footer endRefreshingWithNoMoreData];
                               }
                               else
                               {
                                      self.collectionArr =[NSMutableArray arrayWithArray:list.data.products];
                                     [self.mCollect.mj_footer endRefreshing];
                              }
              
            }
            else
            {
                if (list.data.products.count==0) {
                       [self.mCollect.mj_footer endRefreshingWithNoMoreData];
                }
                else
                {
                      [self.collectionArr addObjectsFromArray:list.data.products];
                      [self.mCollect.mj_footer endRefreshing];
               }
              
                
            }
            [self.mCollect reloadData];
            [self.mCollect.mj_header endRefreshing];
       
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
    } andFailure:^(NSError * _Nonnull error) {
        [self.mCollect.mj_header endRefreshing];
        [self.mCollect.mj_footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}


-(void) initScrollView{
    //获取滚动条
    if(!scrollView){
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth ,40)];
        scrollView.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        scrollView.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
         scrollView.bouncesZoom = NO;
        //横竖屏自适应
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
     //   scrollView.backgroundColor=[UIColor yellowColor];
        //添加到当前视图
        [_titleView addSubview:scrollView];
    }else{
        //清除子控件
        for (UIView *view in [scrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (_categoriesTitleArr) {
        
        CGFloat offsetX = 0 , h = 30;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
    
        NSString *idStr;
        
        for (int i=0; i<_categoriesTitleArr.count; i++) {
           
             if ([_type isEqualToString:@"1"]) {
                     HomeFirstModel *  model=   _categoriesTitleArr[i];
                    strTitle=model.name;
                    idStr=model._id;
                   }
                   else
                   {
                     CategoriesModel  *   model=   _categoriesTitleArr[i];
                      strTitle=model.name;
                         idStr=model._id;
                   }
          
           
    
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            CGSize baseSize = CGSizeMake(CGFLOAT_MAX, 30);
                
                    CGSize size=  [HelpCommon stringSystemSize:strTitle size:baseSize fontSize:14];
             
                            
                CGFloat width= size.width+20;
            [btnText setFrame:CGRectMake([self getTitleLeft:i],
                                         5,
                                          width,
                                         h)];
            
            
            [btnText setTitleColor:Color(@"#333333") forState:UIControlStateNormal];
            [btnText setTitleColor:Color(@"#333333") forState:UIControlStateSelected];
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = font(14);
            
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];

            //添加到滚动视图
            [scrollView addSubview:btnText];
            
            
            if ([_categories_id isEqualToString:idStr]) {
                btnText.selected=YES;
                
                _lineView =[[UIView alloc]initWithFrame:CGRectMake(btnText.center.x-15,btnText.center.y+15,30,1)];
                _lineView.backgroundColor=Color(@"#f6aa00");
                
                [scrollView addSubview:_lineView];
                
               [scrollView setContentOffset:CGPointMake(btnText.frame.origin.x, 0) animated:YES];
                
                selectIndex=i;
                
            }
        }
        [scrollView setContentSize:CGSizeMake(offsetX+25*_categoriesTitleArr.count, 0)];

    }
}
-(float) getTitleLeft:(CGFloat) i {
    float left = 0;
    if (i>0) {
           for (int j = 0; j < i; j ++) {
                    if (j==0) {
                        left +=40;
                    }
                    else
                    {
                        
                        NSString *name;
                               if ([_type isEqualToString:@"1"]) {
                                   HomeFirstModel *  model=   _categoriesTitleArr[j];
                                   name=model.name;
                                   
                               }
                               else
                               {
                                   CategoriesModel *model=[_categoriesTitleArr objectAtIndex:j];
                                   name=model.name;
                               }
                              
                               
                               CGSize baseSize = CGSizeMake(CGFLOAT_MAX, 30);
                               CGSize size=  [HelpCommon stringSystemSize:name size:baseSize  fontSize:14];
                               
                               left += size.width+20;
                    }
                       
    }
       
    }
    return left;
}
#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(UIButton *)but
{
    if (but.selected) {
        return;
    }
    else
    {
        but.selected=YES;
        [_lineView setFrame:CGRectMake(but.center.x-15,
                                       but.center.y+15,
                                       30,
                                       1)];
   
        for (UIButton *button in scrollView.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                if (button.tag!=but.tag) {
                    button.selected=NO;
                    
                }
                
            }
        }
        
    }
    
    if ([_type isEqualToString:@"1"]) {
                                      HomeFirstModel *  model=   _categoriesTitleArr[but.tag];
                                     
                                   _categories_id =model._id;
                                    }
                                    else
                                    {
                                       CategoriesModel *model=[_categoriesTitleArr objectAtIndex:but.tag];
                                        _categories_id =model._id;
                                    }

    page=1;
    selectIndex=but.tag;
    

    [self getData];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
          return self.collectionArr.count;
   
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryDetailCell" forIndexPath:indexPath];
    CategoriesDetailModel *model=self.collectionArr[ indexPath.item];
          NSString* encodedString =[model.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
      [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    cell.titleLab.text=model.name;
     
    NSString *str1=[NSString stringWithFormat:@"%@%@",model.special_price.symbol,[NSString stringWithFormat:@"%.2f",[model.special_price.value doubleValue]]];
      NSString *str2=[NSString stringWithFormat:@"%@%@",model.price.symbol,[NSString stringWithFormat:@"%.2f",[model.price.value doubleValue]]];
    
         if ([model.special_price.value doubleValue]==0 ) {
             cell.priceLab.text= str2;
         }
         else if ([model.price.value doubleValue]==0)
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
       
    cell.priceLab.attributedText=AttributedStr;      }
         return cell;
   
}


#pragma mark - CollectionView的item的布局
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
            return CGSizeMake(ScreenWidth/2-6,ScreenWidth/2-6+50+20);
   
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommodityDetailViewController *detail=[[CommodityDetailViewController alloc]init];
    CategoriesDetailModel *model=self.collectionArr[ indexPath.item];
    detail.product_id=model.product_id;
    [self.navigationController pushViewController:detail animated:YES];

}


- (IBAction)pricePress:(id)sender {
    
    _priceBtn.selected=!_priceBtn.selected;
    if (_priceBtn.selected) {
        priceSort=@"price-low-to-high";
      
    }
    else{
        priceSort=@"price-high-to-low";
    }
    page=1;
    [self getData];
    
}

- (IBAction)attributePress:(id)sender {
    
    CategoryAllItemView *view=[[CategoryAllItemView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
     view.dataArr=self.AttributeArr;
  //  view.priceData=priceDic;
    
    view.setBlock = ^(NSArray * _Nonnull data, NSDictionary * _Nonnull para,NSDictionary *priceData,BOOL isfilter) {
        
  
        self.AttributeArr=[NSMutableArray arrayWithArray:data];
        AttributeDic=[NSMutableDictionary dictionaryWithDictionary:para];
      // priceDic=[NSDictionary dictionaryWithDictionary:priceData];
        
       selectFilter=isfilter;
        
       page=1;
        [self getData];
        [self setBtnSelect];
    };
    view.resetBlock = ^{

        [self getCategoryAttributeModel];
       selectFilter=NO;
        AttributeDic=[NSMutableDictionary dictionaryWithDictionary:@{}];
      //  priceDic=@{};
         page=1;
        [self getData];
         [self setBtnSelect];
    };
    [view loadView];
    [self.view.window addSubview:view];
    
}



- (void)setBtnSelect{
    if (selectFilter) {
          [_filterBtn setTitleColor:Color(@"F6AA00") forState:UIControlStateNormal];
    }
    else
    {
          [_filterBtn setTitleColor:Color(@"666666") forState:UIControlStateNormal];
    }
}

@end
