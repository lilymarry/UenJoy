//
//  ChangeCountryModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ChangeCountryModel.h"

@implementation ChangeCountryModel
-(void)ChangeCountryModelSuccess:(ChangeCountryModelSuccessBlock)success andFailure:(ChangeCountryModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/address/changecountry" baseurl:Base_url andParameters:@{@"country":_country} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      success(dic[@"code"],dic[@"message"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
