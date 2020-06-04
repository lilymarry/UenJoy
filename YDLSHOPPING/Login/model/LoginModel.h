//
//  LoginModel.h
//  WuJieManager
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^LoginModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^LoginModelFaiulureBlock)(NSError *error);
@interface LoginModel : NSObject
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *email;
@property (nonatomic, strong) User * data;

-(void)LoginModelSuccessBlock:(LoginModelSuccessBlock)success andFailure:(LoginModelFaiulureBlock)failure;
+ (instancetype)shareInstance;
//保存登陆用户信息
- (void)save:(User *)userInfo;
//获取已保存用户信息
- (User *)getUserInfo;
//删除用户信息
- (void)deleteUserInfo;
@end

NS_ASSUME_NONNULL_END
