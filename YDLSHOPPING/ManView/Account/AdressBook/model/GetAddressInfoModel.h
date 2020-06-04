//
//  GetAddressInfoModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetAddressInfoModelSuccessBlock)(NSString *code,NSString* message,NSDictionary * data);
typedef void(^GetAddressInfoModelFaiulureBlock)(NSError *error);
@interface GetAddressInfoModel : NSObject

@property(nonatomic,copy )NSString *address_id;



-(void)GetAddressInfoModelSuccess:(GetAddressInfoModelSuccessBlock)success andFailure:(GetAddressInfoModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
