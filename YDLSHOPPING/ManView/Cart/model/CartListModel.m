//
//  CartListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CartListModel.h"

@implementation CartListModel
-(void)CartListModelSuccess:(CartListModelSuccessBlock)success andFailure:(CartListModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/checkout/cart/index" baseurl:Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
                [CartListModel mj_setupObjectClassInArray:^NSDictionary *{
                    return @{@"products":@"CartListModel"
                             };
                }];
        success(dic[@"code"],dic[@"message"],[CartListModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
