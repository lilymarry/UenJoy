//
//  AddPicReviewModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddPicReviewModel.h"

@implementation AddPicReviewModel
-(void)AddPicReviewModelSuccess:(AddPicReviewModelSuccessBlock)success andFailure:(AddPicReviewModelFaiulureBlock)failure
{
    [HttpManager postUploadMultipleImagesWithUrl:@"/customer/productreview/upload" andImageNames:self.FILE andKeyName:@"FILE" andParameters:@{}  andSuccess:^(id Json) {
           NSDictionary * dic = (NSDictionary *)Json;
       success(dic[@"code"],dic[@"message"],[AddPicReviewModel mj_objectWithKeyValues:dic]);
           
       } andFail:^(NSError *error) {
           failure(error);
       }];
}
@end
