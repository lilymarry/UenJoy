//
//  NotificationTableViewCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview;
@property (nonatomic, copy) NotificationModel *model;
@end

NS_ASSUME_NONNULL_END
