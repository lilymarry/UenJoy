//
//  ModifyInfoModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ModifyInfoModel.h"

@implementation ModifyInfoModel
-(void)modifyInfoModelSuccess:(ModifyInfoModelSuccessBlock)success andFailure:(ModifyInfoModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSString *url;
    if ([_type isEqualToString:@"savename"]) {
        url=@"/customer/account/savename";
        if (SWNOTEmptyStr(self.nickname)) {
            [para setValue:self.nickname forKey:@"nickname"];
        }
        
    }
    
    if ([_type isEqualToString:@"savemail"]) {
        url=@"/customer/account/savemail";
        if (SWNOTEmptyStr(self.newemail)) {
            [para setValue:self.newemail forKey:@"newemail"];
        }
        
    }

    if ([_type isEqualToString:@"savepwd"]) {
        url=@"/customer/account/savepwd";
        if (SWNOTEmptyStr(self.current_password)) {
            [para setValue:self.current_password forKey:@"current_password"];
        }
        if (SWNOTEmptyStr(self.password)) {
            [para setValue:self.password forKey:@"password"];
        }
        if (SWNOTEmptyStr(self.confirmation)) {
            [para setValue:self.confirmation forKey:@"confirmation"];
        }
    }
    
    [HttpManager postWithUrl:url baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
