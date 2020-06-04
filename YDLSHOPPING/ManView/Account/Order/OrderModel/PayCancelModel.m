//
//  PayCancelModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "PayCancelModel.h"

@implementation PayCancelModel
-(void)PayCancelModelSuccess:(PayCancelModelSuccessBlock)success andFailure:(PayCancelModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
      
      if (SWNOTEmptyStr(self.order_id)) {
          [para setValue:self.order_id forKey:@"order_id"];
      }

    if (SWNOTEmptyStr(self.subject)) {
        [para setValue:self.subject forKey:@"subject"];
    }
    
    if (SWNOTEmptyStr(self.detail)) {
        [para setValue:self.detail forKey:@"detail"];
    }
    if (SWNOTEmptyStr(self.nickname)) {
        [para setValue:self.nickname forKey:@"nickname"];
    }
    if (SWNOTEmptyStr(self.email)) {
        [para setValue:self.email forKey:@"email"];
    }
    [HttpManager postWithUrl:@"/customer/order/cancelorder2" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
          success(dic[@"code"],dic[@"message"]);
            
        } andFail:^(NSError *error) {
            failure(error);
        }];
}
@end
