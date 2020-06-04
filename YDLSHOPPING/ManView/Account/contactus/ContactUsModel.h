//
//  ContactUsModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ContactUsModelSuccessBlock)(NSString *code,NSString* message,id data);
typedef void(^ContactUsModelFaiulureBlock)(NSError *error);
@interface ContactUsModel : NSObject

@property(nonatomic,copy )NSString *customer_name;
@property(nonatomic,copy )NSString * customer_email;
@property(nonatomic,copy )NSString *title;
@property(nonatomic,copy )NSString *content;

-(void)ContactUsModelSuccess:(ContactUsModelSuccessBlock)success andFailure:(ContactUsModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
