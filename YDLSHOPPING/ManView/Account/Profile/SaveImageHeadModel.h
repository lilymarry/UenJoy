//
//  SaveImageHeadModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SaveImageHeadModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^SaveImageHeadModelFaiulureBlock)(NSError *error);
@interface SaveImageHeadModel : NSObject

@property(nonatomic,copy )NSArray *imageArr;
@property(nonatomic,strong )SaveImageHeadModel *data;
@property(nonatomic,copy )NSString *img_url;

-(void)SaveImageHeadModelSuccess:(SaveImageHeadModelSuccessBlock)success andFailure:(SaveImageHeadModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
