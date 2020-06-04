//
//  DelectCreditCardModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^DelectCreditCardModelSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^DelectCreditCardModelFaiulureBlock)(NSError *error);
@interface DelectCreditCardModel : NSObject
@property(nonatomic,copy )NSString *card_id;

-(void)DelectCreditCardModelAddCreditCardModelSuccess:(DelectCreditCardModelSuccessBlock)success andFailure:(DelectCreditCardModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
