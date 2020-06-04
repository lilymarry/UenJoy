//
//  AddCouponModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddCouponModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^AddCouponModelFaiulureBlock)(NSError *error);
@interface AddCouponModel : NSObject


@property(nonatomic,copy )NSString *coupon_code;

-(void)AddCouponModelSuccess:(AddCouponModelSuccessBlock)success andFailure:(AddCouponModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
