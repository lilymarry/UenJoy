//
//  ContactUsModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ContactUsModel.h"

@implementation ContactUsModel
-(void)ContactUsModelSuccess:(ContactUsModelSuccessBlock)success andFailure:(ContactUsModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
           if (SWNOTEmptyStr(self.customer_name)) {
               [para setValue:self.customer_name forKey:@"customer_name"];
           }
           if (SWNOTEmptyStr(self.customer_email)) {
                        [para setValue:self.customer_email forKey:@"customer_email"];
                    }
    if (SWNOTEmptyStr(self.title)) {
                 [para setValue:self.title forKey:@"title"];
             }
    if (SWNOTEmptyStr(self.content)) {
                 [para setValue:self.content forKey:@"content"];
             }
    
     
    
    [HttpManager postWithUrl:@"/customer/account/contactus" baseurl:Base_url andParameters:para  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
      
        success(dic[@"code"],dic[@"message"],[ContactUsModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
