//
//  OderInforGoodCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OderInforGoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImagView1;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImagView2;

@property (weak, nonatomic) IBOutlet UILabel *itemNumLab;

@property (weak, nonatomic) IBOutlet UILabel *CodeLab;

@property (weak, nonatomic) IBOutlet UILabel *paymentLab;

@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodListBtn;

@property (weak, nonatomic) IBOutlet UIButton *PromoCodebBtn;


@end

NS_ASSUME_NONNULL_END
