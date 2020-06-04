//
//  RAMDetailViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CancellBlock)(void);
@interface RAMDetailViewController : UIViewController
@property(strong ,nonatomic)RAMListModel *list;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, copy) CancellBlock cancellBlock ;
@end

NS_ASSUME_NONNULL_END
