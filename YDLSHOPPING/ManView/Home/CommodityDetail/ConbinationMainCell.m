//
//  ConbinationMainCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ConbinationMainCell.h"
#import "ConbinationViewCell.h"
@interface ConbinationMainCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic)IBOutlet UICollectionView *mColect;
@end


@implementation ConbinationMainCell





- (void)awakeFromNib {
    [super awakeFromNib];
    self.mColect.delegate=self;
    self.mColect.dataSource=self;
    
    self.mColect.scrollEnabled=NO;
    [_mColect registerNib:[UINib nibWithNibName:NSStringFromClass([ConbinationViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"ConbinationViewCell"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        ConbinationViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConbinationViewCell" forIndexPath:indexPath];
        return cell;
}


#pragma mark - CollectionView的item的布局
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake((ScreenWidth-17)/3-10,(ScreenWidth-17)/3+50-10);
 
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
@end
