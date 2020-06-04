//
//  NotificationModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel
-(void)notificationModelSuccess:(NotificationModelSuccessBlock)success andFailure:(NotificationModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/customer/inform/index" baseurl:Base_url andParameters:@{@"pagenum":_pagenum, @"numperpage":_numperpage,@"customerid":_customerid}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [NotificationModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"private_inform":@"NotificationModel",@"private_inform2":@"NotificationModel"
                     ,@"public_inform":@"NotificationModel"
                     };
        }];
        success(dic[@"code"],dic[@"message"],[NotificationModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
