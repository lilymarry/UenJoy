//
//  RAMReasonModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RAMReasonModel.h"

@implementation RAMReasonModel
-(void)RAMReasonModelSuccess:(RAMReasonModelSuccessBlock)success andFailure:(RAMReasonModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/customer/account/getrma" baseurl:Base_url andParameters:@{}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
