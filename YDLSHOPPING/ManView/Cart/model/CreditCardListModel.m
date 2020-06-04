//
//  CreditCardListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CreditCardListModel.h"

@implementation CreditCardListModel
-(void)CreditCardListModelSuccess:(CreditCardListModelSuccessBlock)success andFailure:(CreditCardListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/creditcard/index" baseurl:Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
           
            [CreditCardListModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"list":@"CreditCardListModel"
                         };
            }];success(dic[@"code"],dic[@"message"],[CreditCardListModel mj_objectWithKeyValues:dic]);
        }
        
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
