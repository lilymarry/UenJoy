//
//  DelecttAdressModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "DelectAdressModel.h"

@implementation DelectAdressModel
-(void)DelectAdressModelSuccess:(DelectAdressModelSuccessBlock)success andFailure:(DelectAdressModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/customer/address/remove" baseurl:Base_url andParameters:@{@"address_id":_address_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        success(dic[@"code"],dic[@"message"],[DelectAdressModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
