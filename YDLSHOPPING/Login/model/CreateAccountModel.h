//
//  CreateAccountModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CreateAccountModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CreateAccountModelFaiulureBlock)(NSError *error);
@interface CreateAccountModel : NSObject
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *firstname;
@property(nonatomic,copy)NSString *lastname;
@property(nonatomic,copy)NSString *is_subscribed;
@property(nonatomic,copy)NSString *captcha;
-(void)CreateAccountModelSuccessBlock:(CreateAccountModelSuccessBlock)success andFailure:(CreateAccountModelFaiulureBlock)failure;

@end

NS_ASSUME_NONNULL_END
