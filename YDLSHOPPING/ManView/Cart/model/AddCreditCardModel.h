//
//  AddCreditCardModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddCreditCardModelSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^AddCreditCardModelFaiulureBlock)(NSError *error);
@interface AddCreditCardModel : NSObject
@property(nonatomic,copy )NSString *card_id;
@property(nonatomic,copy )NSString *card_number;
@property(nonatomic,copy )NSString *card_type;
@property(nonatomic,copy )NSString *expires;
@property(nonatomic,copy )NSString *cvv;
-(void)AddCreditCardModelAddCreditCardModelSuccess:(AddCreditCardModelSuccessBlock)success andFailure:(AddCreditCardModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
