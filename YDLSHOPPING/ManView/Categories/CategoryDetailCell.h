//
//  CategoryDetailCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@end

NS_ASSUME_NONNULL_END
