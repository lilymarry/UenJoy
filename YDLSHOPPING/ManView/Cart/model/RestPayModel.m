//
//  RestPayModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RestPayModel.h"

@implementation RestPayModel
-(void)RestPayModelSuccess:(RestPayModelSuccessBlock)success andFailure:(RestPayModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/uenjoypay/paystripe/start" baseurl:Base_url andParameters:@{@"in_id":_in_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
            success(dic[@"code"],dic[@"message"],[RestPayModel mj_objectWithKeyValues:dic]);
        }
        
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"desc":@"description",
             };
}
@end
