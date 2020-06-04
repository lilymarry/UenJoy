//
//  RAMReasonView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RAMReasonViewBlock)(NSString *reason);
@interface RAMReasonView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) RAMReasonViewBlock block ;
@end

NS_ASSUME_NONNULL_END
