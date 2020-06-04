//
//  ReviewsCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReviewsCell : UITableViewCell
@property(nonatomic,strong) ProductDetailModel *model;
@end

NS_ASSUME_NONNULL_END
