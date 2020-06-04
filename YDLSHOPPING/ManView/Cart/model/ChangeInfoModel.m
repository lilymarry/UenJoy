//
//  ChangeInfoModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ChangeInfoModel.h"

@implementation ChangeInfoModel
-(void)ChangeInfoModelSuccess:(ChangeInfoModelSuccessBlock)success andFailure:(ChangeInfoModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.country)) {
        [para setValue:self.country forKey:@"country"];
    }
    if (SWNOTEmptyStr(self.address_id)) {
        [para setValue:self.address_id forKey:@"address_id"];
    }
    
    if (SWNOTEmptyStr(self.state)) {
        [para setValue:self.state forKey:@"state"];
    }
    if (SWNOTEmptyStr(self.shipping_method)) {
        [para setValue:self.shipping_method forKey:@"shipping_method"];
    }
    [HttpManager getWithUrl:@"/checkout/onepage/getshippingandcartinfo" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
       
       
        [ChangeInfoModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"products":@"ChangeInfoModel",@"gallery":@"ChangeInfoModel",@"shippings":@"ChangeInfoModel"
                     };
        }]; success(dic[@"code"],dic[@"message"],[ChangeInfoModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
