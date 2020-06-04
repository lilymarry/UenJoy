//
//  SaveAdressModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SaveAdressModel.h"

@implementation SaveAdressModel
-(void)SaveAdressModelSuccess:(SaveAdressModelSuccessBlock)success andFailure:(SaveAdressModellFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.address_id)) {
        [para setValue:self.address_id forKey:@"address_id"];
    }
    if (SWNOTEmptyStr(self.first_name)) {
        [para setValue:self.first_name forKey:@"first_name"];
    }
    if (SWNOTEmptyStr(self.last_name)) {
        [para setValue:self.last_name forKey:@"last_name"];
    }
    
    if (SWNOTEmptyStr(self.email)) {
        [para setValue:self.email forKey:@"email"];
    }
    
    if (SWNOTEmptyStr(self.telephone)) {
        [para setValue:self.telephone forKey:@"telephone"];
    }
    
    if (SWNOTEmptyStr(self.addressCountry)) {
        [para setValue:self.addressCountry forKey:@"addressCountry"];
    }
    
    if (SWNOTEmptyStr(self.addressState)) {
        [para setValue:self.addressState forKey:@"addressState"];
    }
    
    if (SWNOTEmptyStr(self.city)) {
        [para setValue:self.city forKey:@"city"];
    }
    
    if (SWNOTEmptyStr(self.street1)) {
        [para setValue:self.street1 forKey:@"street1"];
    }
    
    if (SWNOTEmptyStr(self.street2)) {
        [para setValue:self.street2 forKey:@"street2"];
    }
    
    if (SWNOTEmptyStr(self.isDefaultActive)) {
        [para setValue:self.isDefaultActive forKey:@"isDefaultActive"];
    }
    if (SWNOTEmptyStr(self.zip)) {
        [para setValue:self.zip forKey:@"zip"];
    }
    
    [HttpManager postWithUrl:@"/customer/address/save" baseurl:Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        success(dic[@"code"],dic[@"message"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
