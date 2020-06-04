//
//  RAMReasonModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RAMReasonModelSuccessBlock)(NSDictionary * data);
typedef void(^RAMReasonModelFaiulureBlock)(NSError *error);
@interface RAMReasonModel : NSObject

-(void)RAMReasonModelSuccess:(RAMReasonModelSuccessBlock)success andFailure:(RAMReasonModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
