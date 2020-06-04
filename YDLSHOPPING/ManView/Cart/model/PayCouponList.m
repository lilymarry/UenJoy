//
//  PayCouponList.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "PayCouponList.h"

@implementation PayCouponList
-(void)PayCouponListSuccess:(PayCouponListSuccessBlock)success andFailure:(PayCouponListFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/cms/home/coupon" baseurl:Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
            success(dic[@"code"],dic[@"message"],[PayCouponList mj_objectWithKeyValues:dic]);
        }
        
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
