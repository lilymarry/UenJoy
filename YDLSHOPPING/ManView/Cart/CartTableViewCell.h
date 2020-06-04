//
//  CartTableViewCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartTableViewCell : UITableViewCell
@property(nonatomic ,strong)UIButton *cutBtn;
@property(nonatomic ,strong)UIButton *addBtn;
@property(nonatomic ,strong)UIButton* selectBtn;

//显示照片
@property (nonatomic,strong) UIImageView *lzImageView;
//商品名
@property (nonatomic,strong) UILabel *nameLabel;
//尺寸
@property (nonatomic,strong) UILabel *sizeLabel;
//时间
@property (nonatomic,strong) UILabel *dateLabel;
//价格
@property (nonatomic,strong) UILabel *priceLabel;
//数量
@property (nonatomic,strong)UILabel *numberLabel;

@end

NS_ASSUME_NONNULL_END
