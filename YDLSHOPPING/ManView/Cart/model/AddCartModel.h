//
//  AddCartModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddCartModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^AddCartModelFaiulureBlock)(NSError *error);
@interface AddCartModel : NSObject
@property(nonatomic,copy )NSDictionary *custom_option;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *qty;
@property(nonatomic,copy )NSString *buy_now;
-(void)AddCartModelSuccess:(AddCartModelSuccessBlock)success andFailure:(AddCartModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
