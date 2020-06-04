//
//  OderInforMoneyCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OderInforMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalLab;
@property (weak, nonatomic) IBOutlet UILabel *shipLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLab;
@property (weak, nonatomic) IBOutlet UILabel *discountLab;

@end

NS_ASSUME_NONNULL_END
