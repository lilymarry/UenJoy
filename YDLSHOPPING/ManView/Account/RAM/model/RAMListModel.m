//
//  RAMListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RAMListModel.h"

@implementation RAMListModel
-(void)RAMListModelSuccess:(RAMListModelSuccessBlock)success andFailure:(RAMListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"customer/orderafter/list" baseurl:Base_url andParameters:@{@"p":_p,@"type":_type}  andSuccess:^(id Json) {
           NSDictionary * dic = (NSDictionary *)Json;
      
          [RAMListModel mj_setupObjectClassInArray:^NSDictionary *{
                      return @{@"coll":@"RAMListModel",
                               @"products":@"RAMListModel",
                               @"returnmsg":@"RAMListModel"
                               };
                  }];
                  
                  success(dic[@"code"],dic[@"message"],[RAMListModel mj_objectWithKeyValues:dic]);
           
       } andFail:^(NSError *error) {
           failure(error);
       }];
}
@end
