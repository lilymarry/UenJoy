//
//  itemViewCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface itemViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *flag_imag;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

NS_ASSUME_NONNULL_END
