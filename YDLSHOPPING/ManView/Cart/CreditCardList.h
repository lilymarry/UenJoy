//
//  CreditCardList.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CreditCardListBlock)(NSDictionary *data);
@interface CreditCardList : UIViewController
@property(nonatomic ,strong)NSString *selectAddressId;
@property (nonatomic, copy) CreditCardListBlock block ;
@end

NS_ASSUME_NONNULL_END
