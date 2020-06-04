//
//  OrderListModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel
-(void)OrderListModelSuccess:(OrderListModelSuccessBlock)success andFailure:(OrderListModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/order/index" baseurl:Base_url andParameters:@{@"p":_p,@"wxRequestOrderStatus":_wxRequestOrderStatus} andSuccess:^(id Json) {
         NSDictionary * dic = (NSDictionary *)Json;
        [OrderListModel mj_setupObjectClassInArray:^NSDictionary *{
                   return @{@"orderList":@"OrderListModel",@"item_products":@"OrderListModel"
                            };
               }];
         success(dic[@"code"],dic[@"message"],[OrderListModel mj_objectWithKeyValues:dic]);
         
     } andFail:^(NSError *error) {
         failure(error);
     }];
}
@end
