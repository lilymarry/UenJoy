//
//  CategoryAttributeModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoryAttributeModel.h"

@implementation CategoryAttributeModel
-(void)CategoryAttributeModelSuccess:(CategoryAttributeModelSuccessBlock)success andFailure:(CategoryAttributeModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/catalog/category/attribute" baseurl:Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
//        [CategoriesDetailModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"products":@"CategoriesDetailModel"
//                     };
//        }];
        
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
