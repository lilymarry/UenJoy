//
//  UpdateCartModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^UpdateCartModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^UpdateCartModelFaiulureBlock)(NSError *error);
@interface UpdateCartModel : NSObject

@property(nonatomic,copy )NSString *up_type;
@property(nonatomic,copy )NSString *item_id;

-(void)UpdateCartModelSuccess:(UpdateCartModelSuccessBlock)success andFailure:(UpdateCartModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
