//
//  HomeFirstTopView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HomeFirstTopView.h"
#import "ELCVFlowLayout.h"

#import "HomeCollectionCell.h"
#import "itemCollectionView.h"
@interface HomeFirstTopView ()
{
    UIScrollView  *scrollView;
     UIScrollView  *itemScrollView;
}
@end

@implementation HomeFirstTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"HomeFirstTopView" owner:self options:nil];
        [self addSubview:_thisView];
    //    ELCVFlowLayout * mFlowLayout = [[ELCVFlowLayout alloc]init];
      
     //   mFlowLayout.itemSize = CGSizeMake(ScreenWidth/4, 135);//设置单元格的宽和高
      
        
     //   [_itemCollection setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
     //   _itemCollection.showsHorizontalScrollIndicator = NO;
        
    //    [HomeItemCell xibWithCollectionView:_itemCollection];
        
       
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)setDatas:(NSArray *)datas{
   
    _datas= [NSArray arrayWithArray:[self cherkThreeDataWithArr:datas]];
    [self intiItemScrollView];
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr=titleArr;
    [self initScrollView];
}
//每两组数据合成一个数组,放在一个大数组中
-(NSArray *)cherkThreeDataWithArr:(NSArray *)data
{
    NSMutableArray *arr = [NSMutableArray  arrayWithArray:data];
 
    //分组并动态管理数组
    NSMutableArray *bigArr = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *smallArr  = nil;
    for (int i = 0; i < [arr count]; i++) {
        if (i % 2 == 0) {
            smallArr = [[NSMutableArray alloc] initWithCapacity:1];
            [bigArr addObject:smallArr];

        }
        [smallArr addObject:[arr objectAtIndex:i]];
    }

    return bigArr;
}

-(void) intiItemScrollView
{
    //获取滚动条
    if(!itemScrollView){
        itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth ,270)];
        itemScrollView.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        itemScrollView.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
         itemScrollView.bouncesZoom = NO;
        //横竖屏自适应
        itemScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //  scrollView.backgroundColor=[UIColor redColor];
        //添加到当前视图
        [self.itemCollection addSubview:itemScrollView];
                   
             
        
        
    }else{
        //清除子控件
        for (UIView *view in [itemScrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (self.datas) {
        
        CGFloat width = ScreenWidth/4 ;
        
   
        for (int i=0; i<self.datas.count; i++) {
            
          
            itemCollectionView *view = [[itemCollectionView alloc] initWithFrame:CGRectMake(width*i, 0, width, 270)];
            NSArray *arr=self.datas[i];
                      
                      if (arr.count>0) {
                            HomeFirstModel *model=arr[0];
                         
                            NSString* encodedString =[model.thumbnail_app stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
                             [view.imgeView1 sd_setImageWithURL:[NSURL URLWithString:encodedString]
                                          placeholderImage:[UIImage imageNamed:@"null-picture"]];
                           view.lab1.text = model.name;
                          
                          NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:i];
                          view.btn1.indexPath=index;
                          [view.btn1 addTarget:self action:@selector(btnPess:) forControlEvents:UIControlEventTouchUpInside];
                          if (arr.count==1) {
                              view.view2.hidden=YES;
                          }
                          else
                          {  HomeFirstModel *model=arr[1];
                              view.view2.hidden=NO;
                              NSString* encodedString =[model.thumbnail_app stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
                                                         [view.imgeView2 sd_setImageWithURL:[NSURL URLWithString:encodedString]
                                                                      placeholderImage:[UIImage imageNamed:@"null-picture"]];
                                                       view.lab2.text = model.name;
                              NSIndexPath *index=[NSIndexPath indexPathForRow:1 inSection:i];
                                                   view.btn2.indexPath=index;
                                 [view.btn2 addTarget:self action:@selector(btnPess:) forControlEvents:UIControlEventTouchUpInside];
                          }
                      }
            [itemScrollView addSubview:view];
           
        }
        if (ScreenWidth>(self.datas.count+1)*width) {
             [itemScrollView setContentSize:CGSizeMake(ScreenWidth, 0)];
        }
        else
        {
             [itemScrollView setContentSize:CGSizeMake((self.datas.count)*width, 0)];
        }
    }
}
-(void) initScrollView{
    //获取滚动条
    if(!scrollView){
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-80 ,31)];
        scrollView.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        scrollView.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
         scrollView.bouncesZoom = NO;
        //横竖屏自适应
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //  scrollView.backgroundColor=[UIColor redColor];
        //添加到当前视图
        [self.cataView addSubview:scrollView];
                   
             UIButton *     btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnText setFrame:CGRectMake(ScreenWidth-80,
                                               0,
                                                80,
                                               30)];
                  
                  btnText.backgroundColor=[UIColor clearColor];
                  
                  [btnText setTitle:@"More" forState:UIControlStateNormal];
                  btnText.titleLabel.font = font(12);
                  
                
                  btnText.userInteractionEnabled = YES;
                  
                  btnText.tag=9000;
                  [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];


                        [btnText setTitleColor:Color(@"#F69C00") forState:UIControlStateNormal];
                      
                      [btnText setImage:[UIImage imageNamed:@"btn_home_more"] forState:UIControlStateNormal];
                      [btnText setTitleEdgeInsets:UIEdgeInsetsMake(0, - btnText.imageView.image.size.width-2, 0, btnText.imageView.image.size.width)];
                         [btnText setImageEdgeInsets:UIEdgeInsetsMake(2, btnText.titleLabel.bounds.size.width, 0, -btnText.titleLabel.bounds.size.width)];
                 
        [self.cataView addSubview:btnText];
        
        
    }else{
        //清除子控件
        for (UIView *view in [scrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (self.titleArr) {
        
        CGFloat offsetX = 0 , h = 30;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
    
        
        for (int i=1; i<self.titleArr.count; i++) {
            HomeFirstModel *model=self.titleArr[i];
           strTitle=model.name;
                     
            CGSize baseSize = CGSizeMake(CGFLOAT_MAX, 30);
            CGSize size=  [HelpCommon stringSystemSize:model.name size:baseSize fontSize:12];
                                 
            CGFloat width= size.width+20;
                 
             
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
         
            [btnText setFrame:CGRectMake([self getTitleLeft:i],
                                         0,
                                          width,
                                         h)];
            
          
     
            btnText.backgroundColor=[UIColor clearColor];
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = font(12);
            
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];

            //添加到滚动视图
         
            
            if (i!=self.titleArr.count-1) {
                
                [btnText setTitleColor:Color(@"#333333") forState:UIControlStateNormal];
                          UIView *line=[[UIView alloc]initWithFrame:CGRectMake(btnText.frame.size.width-1, 8, 1, btnText.frame.size.height-16)];
                          line.backgroundColor=Color(@"#666666");
                          [btnText addSubview:line];
                   [scrollView addSubview:btnText];
                     
            }
        }
        [scrollView setContentSize:CGSizeMake(offsetX, 0)];

    }
}
-(float) getTitleLeft:(CGFloat) i {
   float left = 0;
            for (int j = 1; j < i; j ++) {

                    HomeFirstModel *model=[self.titleArr objectAtIndex:j];
                
                CGSize baseSize = CGSizeMake(CGFLOAT_MAX, 30);
                
           
                           
             CGSize size=  [HelpCommon stringSystemSize:model.name size:baseSize fontSize:12];
 
                left += size.width+20;
        }
        return left;
}
#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(UIButton *)but
{
    NSInteger index;
    if (but.tag==self.titleArr.count-1) {
        index=0;
    }
    else
    {
        index=but.tag;
    }
    if (but.tag==9000) {
         index=0;
    }

    self.titleBlock(index);
}
- (void)btnPess:(ReviewOneBtn *)btn{
       NSArray *arr = self.datas[btn.indexPath.section];
      HomeFirstModel *model = arr[btn.indexPath.row];
       self.itemBlock(model);
    
}

/*
#pragma mark 返回值决定UICollectionView分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return 5;
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeCollectionCell cellIdentifier] forIndexPath:indexPath];

        return cell;
    }

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
*/



@end
