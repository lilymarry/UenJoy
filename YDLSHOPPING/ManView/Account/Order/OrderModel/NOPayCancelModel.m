//
//  NOPayCancelModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "NOPayCancelModel.h"

@implementation NOPayCancelModel
-(void)NOPayCancelModelSuccess:(NOPayCancelModelSuccessBlock)success andFailure:(NOPayCancelModelFaiulureBlock)failure
{
    NSString *url;
    if ([_type isEqualToString:@"cancelorder"]) {
        url=@"/customer/order/cancelorder";
    }
    else
    {
        url=@"/customer/orderafter/cancelorderafter";
    }
    [HttpManager postWithUrl:url baseurl:Base_url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
               NSDictionary * dic = (NSDictionary *)Json;
             success(dic[@"code"],dic[@"message"]);
               
           } andFail:^(NSError *error) {
               failure(error);
           }];
}
@end
