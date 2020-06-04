//
//  CouponListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CouponListModel.h"

@implementation CouponListModel
-(void)CouponListModelSuccess:(CouponListModelSuccessBlock)success andFailure:(CouponListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/coupon/index" baseurl:Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        [CouponListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"coll":@"CouponListModel",@"coll1":@"CouponListModel"
                ,@"coll2":@"CouponListModel"
                     };
        }];
        
        success(dic[@"code"],dic[@"message"],[CouponListModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
