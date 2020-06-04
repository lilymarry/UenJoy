//
//  OrderListTableViewCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
@class OrderListTableViewCell;

NS_ASSUME_NONNULL_BEGIN
@interface OrderListTableViewCell : UITableViewCell
@property (nonatomic, copy) OrderListModel *dataSoucreDic;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) UIButton *CancelBtn;
@property (nonatomic, strong) UIButton *PayBtn;

+(instancetype)cellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
