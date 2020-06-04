//
//  SetOrderModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SetOrderModelSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^SetOrderModelFaiulureBlock)(NSError *error);
@interface SetOrderModel : NSObject
@property(nonatomic,copy )NSString *address_id;

@property(nonatomic,copy )NSString *billing;
@property(nonatomic,copy )NSString *shipping_method;
@property(nonatomic,copy )NSString *payment_method;
@property(nonatomic,copy )NSString *contact_email;
@property(nonatomic,copy )NSString *billing_address;
@property(nonatomic,strong )SetOrderModel *data;
@property(nonatomic,copy )NSString *in_id;
@property(nonatomic,copy )NSString *redirectUrl;
@property(nonatomic,copy )NSString *error;


-(void)SetOrderModelSuccess:(SetOrderModelSuccessBlock)success andFailure:(SetOrderModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
