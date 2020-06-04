//
//  HomeFirstTopView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFirstModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectItemBlock)(HomeFirstModel *model);
typedef void(^SelectCollectBlock)(HomeFirstModel *model);
typedef void(^SelectTitleBlock)(NSInteger index);

@interface HomeFirstTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *itemCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHHH;

@property (nonatomic, copy) SelectItemBlock itemBlock ;
@property (nonatomic, copy) SelectCollectBlock colletBlock ;
@property (nonatomic, copy) SelectTitleBlock titleBlock ;
@property (weak, nonatomic) IBOutlet UIImageView *header1Image;
@property (weak, nonatomic) IBOutlet UILabel *header1Name;

@property (weak, nonatomic) IBOutlet UIView *cataView;

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSArray *titleArr;

@end

NS_ASSUME_NONNULL_END
