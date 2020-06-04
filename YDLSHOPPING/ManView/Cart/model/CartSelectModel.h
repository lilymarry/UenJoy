//
//  CartSelectOneModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CartSelectModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^CartSelectModelFaiulureBlock)(NSError *error);
@interface CartSelectModel : NSObject
@property(nonatomic,copy )NSString *type;

@property(nonatomic,copy )NSString *item_id;
@property(nonatomic,copy )NSString *checked;

-(void)CartSelectModelSuccess:(CartSelectModelSuccessBlock)success andFailure:(CartSelectModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
