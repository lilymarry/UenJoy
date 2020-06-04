//
//  CreateAccountModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CreateAccountModel.h"

@implementation CreateAccountModel
-(void)CreateAccountModelSuccessBlock:(CreateAccountModelSuccessBlock)success andFailure:(CreateAccountModelFaiulureBlock)failure
{
   NSMutableDictionary *para = [NSMutableDictionary dictionary];
       
       if (SWNOTEmptyStr(self.email)) {
           [para setValue:self.email forKey:@"email"];
       }
      if (SWNOTEmptyStr(self.password)) {
              [para setValue:self.password forKey:@"password"];
          }
    if (SWNOTEmptyStr(self.firstname)) {
        [para setValue:self.firstname forKey:@"firstname"];
    }
    
    if (SWNOTEmptyStr(self.lastname)) {
        [para setValue:self.lastname forKey:@"lastname"];
    }
    if (SWNOTEmptyStr(self.is_subscribed)) {
         [para setValue:self.is_subscribed forKey:@"is_subscribed"];
     }
     
     if (SWNOTEmptyStr(self.captcha)) {
         [para setValue:self.captcha forKey:@"captcha"];
     }
    
    
    [HttpManager postWithUrl:@"/customer/register/account" baseurl:Base_url andParameters:para  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
     success(dic[@"code"],dic[@"message"],[CreateAccountModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
