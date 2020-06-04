//
//  CategoriesDetailModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoriesDetailModel.h"

@implementation CategoriesDetailModel
-(void)categoriesDetailModelSuccess:(CategoriesDetailModelSuccessBlock)success andFailure:(CategoriesDetailModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.categoryId)) {
        [para setValue:self.categoryId forKey:@"categoryId"];
    }
    if (SWNOTEmptyStr(self.sortColumn)) {
        [para setValue:self.sortColumn forKey:@"sortColumn"];
    }
    
    if (SWNOTEmptyDictionary(self.filterAttrs)) {
        [para setValue:[ExchangToJsonData dicToJSONString:self.filterAttrs] forKey:@"filterAttrs"];
     //    [para setValue:self.filterAttrs  forKey:@"filterAttrs"];
    }
    if (SWNOTEmptyStr(self.filterPrice)) {
        [para setValue:self.filterPrice forKey:@"filterPrice"];
    }
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    [HttpManager getWithUrl:@"/catalog/category/product" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [CategoriesDetailModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"products":@"CategoriesDetailModel"
                     };
        }];
    success(dic[@"code"],dic[@"message"],[CategoriesDetailModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
  
}
@end
