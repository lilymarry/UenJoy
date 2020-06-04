//
//  AddCouponModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddCouponModel.h"

@implementation AddCouponModel
-(void)AddCouponModelSuccess:(AddCouponModelSuccessBlock)success andFailure:(AddCouponModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/checkout/cart/addcoupon" baseurl:Base_url andParameters:@{@"coupon_code":_coupon_code} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
       
        
        success(dic[@"code"],dic[@"message"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
