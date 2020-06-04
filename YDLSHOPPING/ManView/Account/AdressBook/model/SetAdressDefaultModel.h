//
//  SetAdressDefaultModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SetAdressDefaultModelSuccessBlock)(NSString *code,NSString* message,id data);
typedef void(^SetAdressDefaultModelFaiulureBlock)(NSError *error);
@interface SetAdressDefaultModel : NSObject

@property(nonatomic,copy )NSString *address_id;

-(void)SetAdressDefaultModelSuccess:(SetAdressDefaultModelSuccessBlock)success andFailure:(SetAdressDefaultModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
