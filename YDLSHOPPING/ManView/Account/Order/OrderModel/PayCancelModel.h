//
//  PayCancelModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PayCancelModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^PayCancelModelFaiulureBlock)(NSError *error);
@interface PayCancelModel : NSObject
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *detail;
@property(nonatomic,copy )NSString *nickname;
@property(nonatomic,copy )NSString *email;
@property(nonatomic,copy )NSString *subject;
-(void)PayCancelModelSuccess:(PayCancelModelSuccessBlock)success andFailure:(PayCancelModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
