//
//  OrderDetailViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^NOPayCancellBlock)(void);

@interface OrderDetailViewController : UIViewController
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, copy) NOPayCancellBlock cancellBlock ;
@end

NS_ASSUME_NONNULL_END
