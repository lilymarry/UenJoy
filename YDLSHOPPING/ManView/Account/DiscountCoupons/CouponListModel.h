//
//  CouponListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CouponListModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CouponListModelFaiulureBlock)(NSError *error);
@interface CouponListModel : NSObject

@property(nonatomic,strong)CouponListModel *data;
@property(nonatomic,strong)NSArray *coll;
@property(nonatomic,strong)NSArray *coll1;
@property(nonatomic,strong)NSArray *coll2;
@property(nonatomic,copy )NSString *belong_custom_id;
@property(nonatomic,copy )NSString *canusestatus;
@property(nonatomic,copy )NSString *conditions ;
@property(nonatomic,copy )NSString *coupon_code;
@property(nonatomic,copy )NSString *coupon_description;
@property(nonatomic,copy )NSString *coupon_id;
@property(nonatomic,copy )NSString *coupon_name;
@property(nonatomic,copy )NSString *coupon_usage_type;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *created_person;
@property(nonatomic,copy )NSString *discount ;
@property(nonatomic,copy )NSString *distribute_target;
@property(nonatomic,copy )NSString *expiration_date;
@property(nonatomic,copy )NSString *receive_code;
@property(nonatomic,copy )NSString *times_used;
@property(nonatomic,copy )NSString *type;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,copy )NSString *users_per_customer;
@property(nonatomic,copy )NSString *type_tittle;
-(void)CouponListModelSuccess:(CouponListModelSuccessBlock)success andFailure:(CouponListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
