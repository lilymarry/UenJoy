//
//  CollectionListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CollectionListModel.h"

@implementation CollectionListModel
-(void)CollectionListModelSuccess:(CollectionListModelSuccessBlock)success andFailure:(CollectionListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/cms/home/collection" baseurl:Base_url andParameters:@{}  andSuccess:^(id Json) {
           NSDictionary * dic = (NSDictionary *)Json;
           [CollectionListModel mj_setupObjectClassInArray:^NSDictionary *{
               return @{@"collection":@"CollectionListModel",@"content_products":@"CollectionListModel"
                        };
           }];
           success(dic[@"code"],dic[@"message"],[CollectionListModel mj_objectWithKeyValues:dic]);
           
       } andFail:^(NSError *error) {
           failure(error);
       }];
}
@end
