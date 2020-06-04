//
//  PayModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PayModelSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^PayModelFaiulureBlock)(NSError *error);
@interface PayModel : NSObject
@property(nonatomic,copy )NSString *in_id;
@property(nonatomic,copy )NSString *stripeToken;
@property(nonatomic,copy )NSString *cmail;
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *client_id;
-(void)PayModelSuccess:(PayModelSuccessBlock)success andFailure:(PayModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
