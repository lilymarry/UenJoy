//
//  AddCartModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddCartModel.h"

@implementation AddCartModel
-(void)AddCartModelSuccess:(AddCartModelSuccessBlock)success andFailure:(AddCartModelFaiulureBlock)failure
{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.product_id)) {
        [para setValue:self.product_id forKey:@"product_id"];
    }
    if (SWNOTEmptyStr(self.qty)) {
        [para setValue:self.qty forKey:@"qty"];
    }
    
    if (SWNOTEmptyDictionary(self.custom_option)) {
      [para setValue:[ExchangToJsonData dicToJSONString: self.custom_option] forKey:@"custom_option"];
    }
  if (SWNOTEmptyStr(self.buy_now)) {
        [para setValue:self.buy_now forKey:@"buy_now"];
    }
    
    [HttpManager postWithUrl:@"/checkout/cart/add" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;

        success(dic[@"code"],dic[@"message"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
