//
//  PayModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel
-(void)PayModelSuccess:(PayModelSuccessBlock)success andFailure:(PayModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/uenjoypay/paystripe/paycharge" baseurl:Base_url andParameters:@{@"in_id":_in_id,@"stripeToken":_stripeToken,@"cmail":_cmail,@"order_id":_order_id,@"client_id":_client_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
            success(dic[@"code"],dic[@"message"],[PayModel mj_objectWithKeyValues:dic]);
        }
        
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
