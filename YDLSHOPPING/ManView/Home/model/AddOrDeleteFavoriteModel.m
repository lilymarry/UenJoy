//
//  AddOrDeleteFavoriteModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddOrDeleteFavoriteModel.h"

@implementation AddOrDeleteFavoriteModel
-(void)addOrDeleteFavoriteModelSuccess:(AddOrDeleteFavoriteModelSuccessBlock)success andFailure:(AddOrDeleteFavoriteModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.product_id)) {
        [para setValue:self.product_id forKey:@"product_id"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    
    [HttpManager getWithUrl:@"/catalog/product/favorite" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
    
        success(dic[@"code"],dic[@"message"],[AddOrDeleteFavoriteModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
