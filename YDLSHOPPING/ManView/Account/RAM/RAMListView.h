//
//  RAMListView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMListModel.h"
#import "ReviewLlistMdel.h"
#import "CouponListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^RAMListViewCellBlock)(RAMListModel *model ,NSString *subType);
typedef void(^RAMListViewBtnBlock)(RAMListModel *model ,NSString *reason);

typedef void(^ReviewLlistBtnBlock)(ReviewLlistMdel *model ,NSString *subType,NSString *code);

@interface RAMListView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (nonatomic, copy) RAMListViewCellBlock cellBlock;

@property (nonatomic, copy) RAMListViewBtnBlock btnBlock;
@property (nonatomic, copy) ReviewLlistBtnBlock reviewBtnBlock;

- (void)showModel:(NSArray *)arr andType:(NSString *)thisType subType:(NSString *)subType;
@end

NS_ASSUME_NONNULL_END
