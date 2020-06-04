//
//  CategoryAttributeModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CategoryAttributeModelSuccessBlock)(NSString *code,NSString* message  ,NSDictionary * data);
typedef void(^CategoryAttributeModelFaiulureBlock)(NSError *error);
@interface CategoryAttributeModel : NSObject

-(void)CategoryAttributeModelSuccess:(CategoryAttributeModelSuccessBlock)success andFailure:(CategoryAttributeModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
