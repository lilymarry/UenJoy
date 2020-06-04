//
//  RestPayModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RestPayModelSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^RestPayModelFaiulureBlock)(NSError *error);
@interface RestPayModel : NSObject
@property(nonatomic,copy )NSString *in_id;
@property(nonatomic,strong )RestPayModel *data;
@property(nonatomic,copy )NSString *canpay;
@property(nonatomic,copy )NSString *client_id;
@property(nonatomic,copy )NSString *client_mail;
@property(nonatomic,copy )NSString *desc;
@property(nonatomic,copy )NSString *grand_total;
@property(nonatomic,copy )NSString *grand_total_ori;
@property(nonatomic,copy )NSString *increment_id;
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *payurl;
@property(nonatomic,copy )NSString *public_key;

-(void)RestPayModelSuccess:(RestPayModelSuccessBlock)success andFailure:(RestPayModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
