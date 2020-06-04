//
//  SelectAddressTwo.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectAddressBlock)(NSString *addressId,NSString *country,NSString *state,   NSString * userName,
    NSString * address);

@interface SelectAddressTwo : UIViewController
@property (nonatomic, copy) SelectAddressBlock block ;
@end

NS_ASSUME_NONNULL_END
