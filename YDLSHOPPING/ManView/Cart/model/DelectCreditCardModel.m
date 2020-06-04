//
//  DelectCreditCardModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "DelectCreditCardModel.h"

@implementation DelectCreditCardModel
-(void)DelectCreditCardModelAddCreditCardModelSuccess:(DelectCreditCardModelSuccessBlock)success andFailure:(DelectCreditCardModelFaiulureBlock)failure
{
    
    [HttpManager postWithUrl:@"customer/creditcard/remove" baseurl:Base_url andParameters:@{@"card_id":_card_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
            success(dic[@"code"],dic[@"message"],[DelectCreditCardModel mj_objectWithKeyValues:dic]);
        }
        
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
