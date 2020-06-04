//
//  SearchViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/20.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchNavView.h"
#import "SaveSearchHistory.h"
#import "UIButton+buttonFrame.h"
#import "SearchGoodsModel.h"
#import "CategoryDetailCell.h"
#import "CommodityDetailViewController.h"
#import "CategoryAttributeModel.h"
#import "CategoryAllItemView.h"
@interface SearchViewController ()<UITextFieldDelegate,UICollectionViewDelegate, UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    
    SearchNavView *   navView ;
  
    NSString * selectIndex;
     NSInteger  page;
    
     NSString *priceSort;
  //  NSDictionary *priceDic;
    NSMutableDictionary *AttributeDic;
    BOOL selectFilter;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet UIView *historyBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHH;

@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
//搜索历史
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) NSMutableArray *collectionArr;
@property (nonatomic, strong) NSMutableArray *AttributeArr;
@end

@implementation SearchViewController

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
    
    navView = [[SearchNavView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth-150, 44)];
    navView.content_tf.delegate=self;
    self.navigationItem.titleView = navView;
    
    UIButton *btnR = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btnR  setTitle:@"cancel" forState:UIControlStateNormal];
    [btnR addTarget:self action:@selector(cancelPress) forControlEvents:UIControlEventTouchUpInside];
    btnR.titleLabel.font=font(15);
    [btnR setTitleColor:Color(@"#333333") forState:UIControlStateNormal];
    UIBarButtonItem *backItemR = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = backItemR;
    
    _historyBackView.hidden=NO;
    self.historyArray = [[SaveSearchHistory sharedStore] getSearchHistoryArrayFromLocal];
    [self updateHistoryList];
    
    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryDetailCell class]) bundle:nil] forCellWithReuseIdentifier:@"CategoryDetailCell"];
    
    _mCollect.emptyDataSetSource = self;
     _mCollect.emptyDataSetDelegate = self;
      [self initRefresh];
    
    //按钮图片在右侧
       [_priceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _priceBtn.imageView.image.size.width-2, 0, _priceBtn.imageView.image.size.width)];
       [_priceBtn setImageEdgeInsets:UIEdgeInsetsMake(2, _priceBtn.titleLabel.bounds.size.width+10, 0, -_priceBtn.titleLabel.bounds.size.width)];
    
    _priceBtn.selected=NO;
    priceSort=@"price-high-to-low";
    
    [self getCategoryAttributeModel];
}

- (void)updateHistoryList {
    
    for (UIView *view in self.historyView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    CGSize orgxy=CGSizeMake(10, 20);
    for (int i=0; i<self.historyArray.count; i++) {
        UIButton *btn=[UIButton  buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = Color(@"F5F5F5");
        btn.tag = i;
        btn.titleLabel.font = font(12);
        [btn setTitleColor:Color(@"333333") forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", self.historyArray[i]] forState:UIControlStateNormal];
        orgxy=[btn nextOrgin:orgxy];//适配
        [btn addTarget:self action:@selector(tagDidCLick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILongPressGestureRecognizer * longPress=  [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(btnLong:)];
        [btn addGestureRecognizer:longPress];
        
        [self.historyView addSubview:btn];
        
        if ([selectIndex intValue]==i && selectIndex!=nil) {
            UILabel *lab  = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width - 5,-5, 10, 10)];
            
            [lab.layer setMasksToBounds:YES];
            lab.layer.cornerRadius = lab.frame.size.width/2;;
            lab.text=@"x";
            lab.textColor=[UIColor whiteColor];
            lab.font=[UIFont systemFontOfSize:10];
            lab.backgroundColor=[UIColor redColor];
            lab.textAlignment=NSTextAlignmentCenter;
            lab.backgroundColor=Color(@"999999");
            lab.tag = i;
            
            [btn addSubview:lab];
        }
    }
    
}
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognize
{
    if (gestureRecognize.state == UIGestureRecognizerStateEnded)
    {
        return; // 解决长按响应两次
    }
    if ([gestureRecognize state] == UIGestureRecognizerStateBegan) {
        
        selectIndex=[NSString stringWithFormat:@"%d",(int)gestureRecognize.view.tag];
        
        [self updateHistoryList];
        
    }
}
-(void)tagDidCLick:(UIButton *)sender
{
    NSString *text =  sender.titleLabel.text;
    if ([selectIndex isEqualToString: [NSString stringWithFormat:@"%d",(int)sender.tag]] &&selectIndex!=nil) {
        //删除
        if ([self.historyArray containsObject:text]) {
            [self.historyArray removeObject:text];
        }
        [[SaveSearchHistory sharedStore] saveSearchHistoryArrayToLocal:self.historyArray];
        selectIndex=nil;
        [self updateHistoryList];
    }
    
    else
    {
        //筛选
        navView.content_tf.text=text;
        _historyBackView.hidden=YES;
        page = 1;
        [self getData];
        
    }
    
}

- (void)addHistoryString:(NSString *)historyString {
    
    if ([self.historyArray containsObject:historyString]) {
        [self.historyArray removeObject:historyString];
    }
    [self.historyArray insertObject:historyString atIndex:0];
    [[SaveSearchHistory sharedStore] saveSearchHistoryArrayToLocal:self.historyArray];
    [self updateHistoryList];
    
}
- (void)cancelPress{
    _historyBackView.hidden=NO;
}
- (IBAction)deletePress:(id)sender{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Are you sure  want to delete these records" preferredStyle:UIAlertControllerStyleAlert];
       [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.historyArray = [NSMutableArray new];
        [[SaveSearchHistory sharedStore] saveSearchHistoryArrayToLocal:self.historyArray];
        [self updateHistoryList];
    }
       ]];
       [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length==0) {
         return;
     }
    [self addHistoryString:textField.text];
    navView.content_tf.text=textField.text;
    _historyBackView.hidden=YES;
    page = 1;
    [self getData];
}
#pragma mark 数据加载
- (void)initRefresh
{
    __block SearchViewController * blockSelf = self;
    blockSelf.mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       page = 1;
        [blockSelf getData];
    }];
 
    blockSelf.mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf getData];
    }];
    
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
- (void)getData{
    if (navView.content_tf.text.length==0) {
        [self.mCollect reloadData];
        [self.mCollect.mj_header endRefreshing];
        [self.mCollect.mj_footer endRefreshing];
        return;
    }
       SearchGoodsModel *model=[[SearchGoodsModel alloc]init];
       model.q=navView.content_tf.text;
       model.filterAttrs=AttributeDic;
       model.pric=priceSort;
       model.p=[NSString stringWithFormat:@"%ld",(long)page];
       [MBProgressHUD showMessage:nil toView:self.view];

       [model SearchGoodsModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           if ([code intValue]==200) {
          
               SearchGoodsModel *list= (SearchGoodsModel *)data;
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
#pragma mark - CollectionViewdelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

          return self.collectionArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    CategoryDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryDetailCell" forIndexPath:indexPath];
    SearchGoodsModel *model=self.collectionArr[ indexPath.item];
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
       
    cell.priceLab.attributedText=AttributedStr; }
         return cell;
   
}

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
    SearchGoodsModel *model=self.collectionArr[ indexPath.item];
    detail.product_id=model.product_id;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 按钮点击
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
 //   view.priceData=priceDic;
    
    view.setBlock = ^(NSArray * _Nonnull data, NSDictionary * _Nonnull para,NSDictionary *priceData,BOOL isfilter) {
        
        self.AttributeArr=[NSMutableArray arrayWithArray:data];
        AttributeDic=[NSMutableDictionary dictionaryWithDictionary:para];
      //  priceDic=[NSDictionary dictionaryWithDictionary:priceData];
        selectFilter=isfilter;
       page=1;
        [self getData];
         [self setBtnSelect];
    };
    view.resetBlock = ^{

        [self getCategoryAttributeModel];
        AttributeDic=[NSMutableDictionary dictionaryWithDictionary:@{}];
        selectFilter=NO;
     //   priceDic=@{};
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

#pragma mark -空数据页代理
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"pic_nosearch"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title =[NSString stringWithFormat:@"Sorry, there are no\"%@\" related items.",navView.content_tf.text];
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName:Color(@"#666666")
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

@end
