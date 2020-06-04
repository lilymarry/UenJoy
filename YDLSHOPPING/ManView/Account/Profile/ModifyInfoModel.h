//
//  ModifyInfoModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ModifyInfoModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^ModifyInfoModelFaiulureBlock)(NSError *error);
@interface ModifyInfoModel : NSObject
@property(nonatomic,copy )NSString *type;
@property(nonatomic,copy )NSString *nickname;
@property(nonatomic,copy )NSString *newemail;

@property(nonatomic,copy )NSString *current_password;
@property(nonatomic,copy )NSString *password;
@property(nonatomic,copy )NSString *confirmation;


-(void)modifyInfoModelSuccess:(ModifyInfoModelSuccessBlock)success andFailure:(ModifyInfoModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
