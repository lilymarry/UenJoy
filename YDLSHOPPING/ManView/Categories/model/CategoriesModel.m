//
//  CategoriesModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoriesModel.h"

@implementation CategoriesModel
-(void)categoriesModelSuccess:(CategoriesModelSuccessBlock)success andFailure:(CategoriesModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/catalog/category/list" baseurl:Base_url andParameters:@{}  andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;

        [CategoriesModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"CategoriesModel",@"child":@"CategoriesModel"
                     };
        }];
     
    success(dic[@"code"],dic[@"message"],[CategoriesModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
