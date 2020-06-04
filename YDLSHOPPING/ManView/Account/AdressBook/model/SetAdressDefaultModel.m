//
//  SetAdressDefaultModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SetAdressDefaultModel.h"

@implementation SetAdressDefaultModel
-(void)SetAdressDefaultModelSuccess:(SetAdressDefaultModelSuccessBlock)success andFailure:(SetAdressDefaultModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/customer/address/changedefaul" baseurl:Base_url andParameters:@{@"address_id":_address_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
       
        success(dic[@"code"],dic[@"message"],[SetAdressDefaultModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
