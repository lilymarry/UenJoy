//
//  WishListTableViewCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WishListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *flag_image;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UILabel *oldmoney;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, strong) UIButton *wish_icImage;
@property (nonatomic, strong) UIView *lineView;
+(instancetype)cellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
