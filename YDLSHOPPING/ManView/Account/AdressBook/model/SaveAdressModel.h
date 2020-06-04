//
//  SaveAdressModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SaveAdressModelSuccessBlock)(NSString *code,NSString* message);
typedef void(^SaveAdressModellFaiulureBlock)(NSError *error);
@interface SaveAdressModel : NSObject

@property(nonatomic,copy )NSString *address_id;
@property(nonatomic,copy )NSString *first_name;
@property(nonatomic,copy )NSString *last_name;
@property(nonatomic,copy )NSString *email;
@property(nonatomic,copy )NSString *telephone;
@property(nonatomic,copy )NSString *addressCountry;
@property(nonatomic,copy )NSString *addressState;
@property(nonatomic,copy )NSString *city;
@property(nonatomic,copy )NSString *street1;
@property(nonatomic,copy )NSString *street2;
@property(nonatomic,copy )NSString *isDefaultActive;
@property(nonatomic,copy )NSString *zip;


-(void)SaveAdressModelSuccess:(SaveAdressModelSuccessBlock)success andFailure:(SaveAdressModellFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
