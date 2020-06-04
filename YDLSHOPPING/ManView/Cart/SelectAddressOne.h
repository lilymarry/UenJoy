//
//  SelectAddressOne.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectAddressOneSuccessBlock)(void);
@interface SelectAddressOne : UIViewController
@property (nonatomic, copy) SelectAddressOneSuccessBlock AddBlock;

@property (nonatomic, strong) NSString * type;//由下单进入1 

@end

NS_ASSUME_NONNULL_END
