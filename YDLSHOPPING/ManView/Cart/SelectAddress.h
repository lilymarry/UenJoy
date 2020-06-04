//
//  SelectAddress.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectAddressBlock)(NSString *contry,NSString *state);

@interface SelectAddress : UIViewController
@property (nonatomic, copy) SelectAddressBlock block ;
@end

NS_ASSUME_NONNULL_END
