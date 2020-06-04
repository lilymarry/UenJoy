//
//  GetAddressInfoModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "GetAddressInfoModel.h"

@implementation GetAddressInfoModel
-(void)GetAddressInfoModelSuccess:(GetAddressInfoModelSuccessBlock)success andFailure:(GetAddressInfoModelFaiulureBlock)failure
{
  //  @"address_id":_address_id
    [HttpManager getWithUrl:@"/customer/address/edit" baseurl:Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        NSDictionary *data= dic[@"data"];
      success(dic[@"code"],dic[@"message"],data[@"address"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
