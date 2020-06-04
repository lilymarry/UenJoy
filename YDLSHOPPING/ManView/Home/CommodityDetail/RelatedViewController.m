//
//  RelatedViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RelatedViewController.h"
#import "CategoryDetailCell.h"
@interface RelatedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic)  UICollectionView *collectionView;
@end

@implementation RelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
       CGFloat tableHeight = ScreenHeight-NaviBarAndStatusBarHeight-54;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, 5,ScreenWidth, tableHeight) collectionViewLayout:collectionLayout];
    self.collectionView=collectionView;
    self.collectionView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
     [ self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryDetailCell class]) bundle:nil] forCellWithReuseIdentifier:@"CategoryDetailCell"];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        CategoryDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryDetailCell" forIndexPath:indexPath];
    
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
}



@end
