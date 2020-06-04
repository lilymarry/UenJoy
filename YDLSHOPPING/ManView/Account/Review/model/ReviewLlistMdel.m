//
//  ReviewLlistMdel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ReviewLlistMdel.h"

@implementation ReviewLlistMdel
-(void)ReviewLlistMdelSuccess:(ReviewLlistMdelSuccessBlock)success andFailure:(ReviewLlistMdelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/productreview/list" baseurl:Base_url andParameters:@{@"return_type":_return_type}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [ReviewLlistMdel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"productList":@"ReviewLlistMdel",@"products":@"ReviewLlistMdel"
                     };
        }];
        
        success(dic[@"code"],dic[@"message"],[ReviewLlistMdel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}


@end
