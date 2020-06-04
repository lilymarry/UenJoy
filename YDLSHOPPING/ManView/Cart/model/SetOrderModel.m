//
//  SetOrderModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SetOrderModel.h"

@implementation SetOrderModel
-(void)SetOrderModelSuccess:(SetOrderModelSuccessBlock)success andFailure:(SetOrderModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.address_id)) {
        [para setValue:self.address_id forKey:@"address_id"];
    }
    if (SWNOTEmptyStr(self.billing)) {
      [para setValue:self.billing forKey:@"billing"];
  }
    if (SWNOTEmptyStr(self.shipping_method)) {
           [para setValue:self.shipping_method forKey:@"shipping_method"];
       }
       if (SWNOTEmptyStr(self.payment_method)) {
           [para setValue:self.payment_method forKey:@"payment_method"];
       }
    
    
    if (SWNOTEmptyStr(self.contact_email)) {
        [para setValue:self.contact_email forKey:@"contact_email"];
    }
   if (SWNOTEmptyStr(self.billing_address)) {
         [para setValue:self.billing_address forKey:@"billing_address"];
     }
    
    [HttpManager postWithUrl:@"/checkout/onepage/submitorder" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
    success(dic[@"code"],dic[@"message"],[SetOrderModel mj_objectWithKeyValues:dic]);
        }
        
    
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
