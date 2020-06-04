//
//  CartSelectOneModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CartSelectModel.h"

@implementation CartSelectModel
-(void)CartSelectModelSuccess:(CartSelectModelSuccessBlock)success andFailure:(CartSelectModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.item_id)) {
        [para setValue:self.item_id forKey:@"item_id"];
    }
    if (SWNOTEmptyStr(self.checked)) {
        [para setValue:self.checked forKey:@"checked"];
    }
    NSString *url;
    if ([_type isEqualToString:@"one"]) {
        url=@"/checkout/cart/selectone";
    }
    else
    {
      url=@"/checkout/cart/selectall";
        
    }
    [HttpManager getWithUrl:url baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
