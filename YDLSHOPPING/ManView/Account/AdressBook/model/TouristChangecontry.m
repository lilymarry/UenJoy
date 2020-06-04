//
//  TouristChangecontry.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "TouristChangecontry.h"

@implementation TouristChangecontry
-(void)TouristChangecontryModelSuccess:(TouristChangecontryModelSuccessBlock)success andFailure:(TouristChangecontryModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/cms/home/changecountry" baseurl:Base_url andParameters:@{@"country":_country} andSuccess:^(id Json) {
           NSDictionary * dic = (NSDictionary *)Json;
         success(dic[@"code"],dic[@"message"],dic[@"data"]);
           
       } andFail:^(NSError *error) {
           failure(error);
       }];
}
@end
