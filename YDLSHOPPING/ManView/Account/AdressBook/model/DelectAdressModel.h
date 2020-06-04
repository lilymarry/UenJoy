//
//  DelecttAdressModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DelectAdressModelSuccessBlock)(NSString *code,NSString* message,id data);
typedef void(^DelectAdressModelFaiulureBlock)(NSError *error);
@interface DelectAdressModel : NSObject

@property(nonatomic,copy )NSString *address_id;

-(void)DelectAdressModelSuccess:(DelectAdressModelSuccessBlock)success andFailure:(DelectAdressModelFaiulureBlock)failure;

@end

NS_ASSUME_NONNULL_END
