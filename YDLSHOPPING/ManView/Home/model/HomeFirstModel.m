//
//  HomeFirstModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HomeFirstModel.h"

@implementation HomeFirstModel
-(void)homeFirstModelSuccess:(HomeFirstModelSuccessBlock)success andFailure:(HomeFirstModelFaiulureBlock)failure
{
    
    [HttpManager getWithUrl:@"/cms/home/index" baseurl:Base_url andParameters:@{}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      //  NSLog(@"AAASSSSS %@",dic);
        [HomeFirstModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"banners":@"HomeFirstModel",@"categoryindex":@"HomeFirstModel"
                    ,@"child":@"HomeFirstModel"
                     ,@"content_products":@"HomeFirstModel"
                      ,@"collection":@"HomeFirstModel"
                     };
        }];
        success(dic[@"code"],dic[@"message"],[HomeFirstModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
