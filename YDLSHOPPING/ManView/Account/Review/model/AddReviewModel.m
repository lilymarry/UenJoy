//
//  AddReviewModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddReviewModel.h"

@implementation AddReviewModel
-(void)AddReviewModelSuccess:(AddReviewModelSuccessBlock)success andFailure:(AddReviewModelFaiulureBlock)failure
{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
         
         if (SWNOTEmptyStr(self.order_id)) {
             [para setValue:self.order_id forKey:@"order_id"];
         }

       if (SWNOTEmptyStr(self.product_id)) {
           [para setValue:self.product_id forKey:@"product_id"];
       }
       
       if (SWNOTEmptyStr(self.rate_star)) {
           [para setValue:self.rate_star forKey:@"rate_star"];
       }
       if (SWNOTEmptyStr(self.name)) {
           [para setValue:self.name forKey:@"name"];
       }
       if (SWNOTEmptyStr(self.summary)) {
           [para setValue:self.summary forKey:@"summary"];
       }
    if (SWNOTEmptyStr(self.review_content)) {
             [para setValue:self.review_content forKey:@"review_content"];
         }
    if (SWNOTEmptyStr(self.review_imgs)) {
              [para setValue:self.review_imgs forKey:@"review_imgs"];
          }
 [HttpManager postWithUrl:@"/customer/productreview/add" baseurl:Base_url andParameters:para  andSuccess:^(id Json) {
       NSDictionary * dic = (NSDictionary *)Json;
     success(dic[@"code"],dic[@"message"],[AddReviewModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
//    [HttpManager postUploadMultipleImagesWithUrl:@"/customer/productreview/add" andImageNames:self.review_imgs andKeyName:@"review_imgs" andParameters:@{@"product_id":_product_id,@"order_id":_order_id,@"rate_star":_rate_star,@"name":_name,@"summary":_summary,@"review_content":_review_content}  andSuccess:^(id Json) {
//        NSDictionary * dic = (NSDictionary *)Json;
//
//        success(dic[@"code"],dic[@"message"],[AddReviewModel mj_objectWithKeyValues:dic]);
//
//    } andFail:^(NSError *error) {
//        failure(error);
//    }];
    
}
@end
