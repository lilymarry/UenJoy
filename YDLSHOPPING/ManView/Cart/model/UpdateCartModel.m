//
//  UpdateCartModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "UpdateCartModel.h"

@implementation UpdateCartModel

-(void)UpdateCartModelSuccess:(UpdateCartModelSuccessBlock)success andFailure:(UpdateCartModelFaiulureBlock)failure

{
    [HttpManager postWithUrl:@"/checkout/cart/updateinfo" baseurl:Base_url andParameters:@{@"up_type":_up_type,@"item_id":_item_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      success(dic[@"code"],dic[@"message"],[UpdateCartModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
