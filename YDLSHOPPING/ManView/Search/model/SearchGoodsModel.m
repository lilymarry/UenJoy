//
//  SearchGoodsModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SearchGoodsModel.h"

@implementation SearchGoodsModel
-(void)SearchGoodsModelSuccess:(SearchGoodsModelSuccessBlock)success andFailure:(SearchGoodsModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
       
       if (SWNOTEmptyStr(self.q)) {
           [para setValue:self.q forKey:@"q"];
       }
//       if (SWNOTEmptyStr(self.pric)) {
//           [para setValue:self.pric forKey:@"price"];
//       }
       
       if (SWNOTEmptyDictionary(self.filterAttrs)) {
           [para setValue:[ExchangToJsonData dicToJSONString:self.filterAttrs] forKey:@"filterAttrs"];
       
       }
     
       if (SWNOTEmptyStr(self.p)) {
           [para setValue:self.p forKey:@"p"];
       }
  
    
       [HttpManager getWithUrl:@"/catalogsearch/index/product" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
           NSDictionary * dic = (NSDictionary *)Json;
           [SearchGoodsModel mj_setupObjectClassInArray:^NSDictionary *{
               return @{@"products":@"SearchGoodsModel"
                        };
           }];
       success(dic[@"code"],dic[@"message"],[SearchGoodsModel mj_objectWithKeyValues:dic]);
           
       } andFail:^(NSError *error) {
           failure(error);
       }];
    
}

@end
