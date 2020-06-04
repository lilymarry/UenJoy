//
//  ReviewOneCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewOneBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReviewOneCell : UITableViewCell
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) ReviewOneBtn *AddBtn;
@end

NS_ASSUME_NONNULL_END
