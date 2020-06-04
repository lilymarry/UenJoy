//
//  PayCouponList.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PayCouponListSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^PayCouponListFaiulureBlock)(NSError *error);
@interface PayCouponList : NSObject
@property(nonatomic,copy )NSString *card_id;

-(void)PayCouponListSuccess:(PayCouponListSuccessBlock)success andFailure:(PayCouponListFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
