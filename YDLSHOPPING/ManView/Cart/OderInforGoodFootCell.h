//
//  OderInforGoodFootCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OderInforGoodFootCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalLab;

@property (weak, nonatomic) IBOutlet UILabel *shipping_costLab;
@property (weak, nonatomic) IBOutlet UIButton *couponBtn;
@property (weak, nonatomic) IBOutlet UITextField *couponTf;

@property (weak, nonatomic) IBOutlet UILabel *discountLab;



@end

NS_ASSUME_NONNULL_END
