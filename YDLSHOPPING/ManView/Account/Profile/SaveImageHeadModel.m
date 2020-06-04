//
//  SaveImageHeadModel.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SaveImageHeadModel.h"

@implementation SaveImageHeadModel
-(void)SaveImageHeadModelSuccess:(SaveImageHeadModelSuccessBlock)success andFailure:(SaveImageHeadModelFaiulureBlock)failure
{
    [HttpManager postUploadMultipleImagesWithUrl:@"/customer/account/imageupload" andImageNames:self.imageArr andKeyName:@"FILE" andParameters:@{}  andSuccess:^(id Json) {
           NSDictionary * dic = (NSDictionary *)Json;
      success(dic[@"code"],dic[@"message"],[SaveImageHeadModel mj_objectWithKeyValues:dic]);
           
       } andFail:^(NSError *error) {
           failure(error);
       }];
}
@end
