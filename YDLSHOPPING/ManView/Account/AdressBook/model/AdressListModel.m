//
//  AdressListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AdressListModel.h"

@implementation AdressListModel
-(void)AdressListModelSuccess:(AdressListModelSuccessBlock)success andFailure:(AdressListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/address/index" baseurl:Base_url andParameters:@{}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      
        [AdressListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"addressList":@"AdressListModel"
                     };
        }];
        success(dic[@"code"],dic[@"message"],[AdressListModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
