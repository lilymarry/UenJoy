//
//  ProductDetailModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel
-(void)productDetailModelSuccess:(ProductDetailModelSuccessBlock)success andFailure:(ProductDetailModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/catalog/product/index" baseurl:Base_url andParameters:@{@"product_id":_product_id}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [ProductDetailModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"Combine":@"ProductDetailModel",@"custom_option":@"ProductDetailModel"
                     ,@"options":@"ProductDetailModel"
                     ,@"coll":@"ProductDetailModel",@"thumbnail_img":@"ProductDetailModel"
                     ,@"groupAttrArrNew":@"ProductDetailModel"
                      ,@"long_img":@"ProductDetailModel"
                     };
        }];
        success(dic[@"code"],dic[@"message"],[ProductDetailModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"desc":@"description",
             };
}
@end
