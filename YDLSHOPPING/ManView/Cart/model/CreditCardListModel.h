//
//  CreditCardListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef void(^CreditCardListModelSuccessBlock)(NSString *code,NSString* message, id data);
typedef void(^CreditCardListModelFaiulureBlock)(NSError *error);
@interface CreditCardListModel : NSObject
@property(nonatomic,strong )CreditCardListModel *data;
@property(nonatomic,strong )NSArray *list;
@property(nonatomic,copy )NSString *card_id;
@property(nonatomic,copy )NSString *card_number;
@property(nonatomic,copy )NSString *card_type;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *customer_id;
@property(nonatomic,copy )NSString *expires ;
@property(nonatomic,copy )NSString *updated_at;


-(void)CreditCardListModelSuccess:(CreditCardListModelSuccessBlock)success andFailure:(CreditCardListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
