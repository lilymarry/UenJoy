//
//  GetFavoriteStateModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "GetFavoriteStateModel.h"

@implementation GetFavoriteStateModel
-(void)getFavoriteStateModelSuccess:(GetFavoriteStateModelSuccessBlock)success andFailure:(GetFavoriteStateModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.product_id)) {
        [para setValue:self.product_id forKey:@"product_id"];
    }
 

    [HttpManager getWithUrl:@"/catalog/product/getfav" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        success(dic[@"code"],dic[@"message"],[GetFavoriteStateModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
