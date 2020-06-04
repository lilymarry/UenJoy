//
//  HomeCollectionCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionCell : UICollectionViewCell
+(void)xibWithCollectionView:(UICollectionView *)collectionView;
+(NSString *)cellIdentifier;
@end

NS_ASSUME_NONNULL_END
