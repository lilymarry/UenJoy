//
//  NOPayCancelModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^NOPayCancelModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^NOPayCancelModelFaiulureBlock)(NSError *error);
@interface NOPayCancelModel : NSObject
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *type;
-(void)NOPayCancelModelSuccess:(NOPayCancelModelSuccessBlock)success andFailure:(NOPayCancelModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
