//
//  LoginModel.m
//  WuJieManager
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "LoginModel.h"
#import "HttpManager.h"
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"User.data"]
@implementation LoginModel
static LoginModel * login = nil;
+ (instancetype)shareInstance {
    @synchronized(self) {
        if (login == nil)
            login = [[self alloc] init];
    }
    return login;
}
- (User *)getUserInfo {
    User * user = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    return user;
}
- (void)save:(User *)userInfo {
    [NSKeyedArchiver archiveRootObject:userInfo toFile:kFile];
}
- (void)deleteUserInfo {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:kFile]) {
        [defaultManager removeItemAtPath:kFile error:nil];
    }
    
}

-(void)LoginModelSuccessBlock:(LoginModelSuccessBlock)success andFailure:(LoginModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/customer/login/account" baseurl:Base_url andParameters:@{@"email":_email, @"password":_password}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;

       success(dic[@"code"],dic[@"message"],[LoginModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
