//
//  WishListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "WishListModel.h"

@implementation WishListModel
-(void)WishListModelSuccess:(WishListModelSuccessBlock)success andFailure:(WishListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"customer/productfavorite/index" baseurl:Base_url andParameters:@{@"p":_p}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        [WishListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"productList":@"WishListModel"
                     };
        }];
        success(dic[@"code"],dic[@"message"],[WishListModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
