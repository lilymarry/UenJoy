//
//  OderInforGoodContentCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OderInforGoodContentCell : UITableViewCell
//显示照片
@property (nonatomic,strong)IBOutlet UIImageView *lzImageView;
//商品名
@property (nonatomic,strong)IBOutlet UILabel *nameLabel;
//尺寸
@property (nonatomic,strong)IBOutlet UILabel *sizeLabel;

//价格
@property (nonatomic,strong)IBOutlet UILabel *priceLabel;
//数量
@property (nonatomic,strong)IBOutlet UILabel *numberLabel;
@end

NS_ASSUME_NONNULL_END
