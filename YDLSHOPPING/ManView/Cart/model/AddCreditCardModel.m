//
//  AddCreditCardModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddCreditCardModel.h"

@implementation AddCreditCardModel
-(void)AddCreditCardModelAddCreditCardModelSuccess:(AddCreditCardModelSuccessBlock)success andFailure:(AddCreditCardModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.card_id)) {
        [para setValue:self.card_id forKey:@"card_id"];
    }
    if (SWNOTEmptyStr(self.card_number)) {
        [para setValue:self.card_number forKey:@"card_number"];
    }
    
    if (SWNOTEmptyStr(self.card_type)) {
        [para setValue:self.card_type forKey:@"card_type"];
    }
    if (SWNOTEmptyStr(self.expires)) {
        [para setValue:self.expires forKey:@"expires"];
    }
    if (SWNOTEmptyStr(self.cvv)) {
        [para setValue:self.cvv forKey:@"cvv"];
    }
    [HttpManager postWithUrl:@"/customer/creditcard/save" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        if ([dic isKindOfClass:[NSDictionary class]]&& dic.count>0) {
            success(dic[@"code"],dic[@"message"],[AddCreditCardModel mj_objectWithKeyValues:dic]);
        }
        
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
