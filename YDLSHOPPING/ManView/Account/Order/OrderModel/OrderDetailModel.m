//
//  OrderDetailModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel
-(void)OrderDetailModelSuccess:(OrderDetailModelSuccessBlock)success andFailure:(OrderDetailModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/order/view" baseurl:Base_url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
           [OrderDetailModel mj_setupObjectClassInArray:^NSDictionary *{
                      return @{@"products":@"OrderDetailModel"
                               };
                  }];
            success(dic[@"code"],dic[@"message"],[OrderDetailModel mj_objectWithKeyValues:dic]);
            
        } andFail:^(NSError *error) {
            failure(error);
        }];
}
@end
