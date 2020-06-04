//
//  OrderInfoModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OrderInfoModel.h"

@implementation OrderInfoModel
-(void)OrderInfoModelSuccess:(OrderInfoModelSuccessBlock)success andFailure:(OrderInfoModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/checkout/onepage/index" baseurl:Base_url andParameters:@{
        @"refresh":_refresh
    } andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        @try {
               NSDictionary *data=dic[@"data"][@"address_list"];
               
                  NSMutableDictionary *d=[NSMutableDictionary dictionary];
                 if ([data isKindOfClass:[NSDictionary class]]&&data.count>0) {
                     NSArray *arr=   [data allValues];
                     [d setValue:arr forKey:@"address_list"];
                     
                 }
                 NSDictionary *payData=dic[@"data"][@"payments"];
                 
                 NSMutableDictionary *d1=[NSMutableDictionary dictionary];
                    if ([payData isKindOfClass:[NSDictionary class]]&&payData.count>0) {
                        
                        NSArray *arr=   [payData allValues];
                        [d1 setValue:arr forKey:@"payments"];
                        
                    }
            NSDictionary *contry=dic[@"data"][@"countryArr"];
            [OrderInfoModel mj_setupObjectClassInArray:^NSDictionary *{
                    return @{@"address_list":@"OrderInfoModel",@"products":@"OrderInfoModel",@"custom_option":@"OrderInfoModel",@"gallery":@"OrderInfoModel"
                             ,@"shippings":@"OrderInfoModel"
                             ,@"payments":@"OrderInfoModel"
                             };
                }];
                success(dic[@"code"],dic[@"message"],[OrderInfoModel mj_objectWithKeyValues:dic],[OrderInfoModel mj_objectWithKeyValues:d],[OrderInfoModel mj_objectWithKeyValues:d1],contry);
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
     
    
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
