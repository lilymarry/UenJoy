//
//  AdressListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AdressListModelSuccessBlock)(NSString *code,NSString* message,id data);
typedef void(^AdressListModelFaiulureBlock)(NSError *error);
@interface AdressListModel : NSObject
@property(nonatomic,strong)AdressListModel *data;
@property(nonatomic,strong)NSArray * addressList ;
@property(nonatomic,copy )NSString *address_id;
@property(nonatomic,copy )NSString * area;
@property(nonatomic,copy )NSString *city;
@property(nonatomic,copy )NSString *company;
@property(nonatomic,copy )NSString *country;
@property(nonatomic,copy )NSString *countryName;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *customer_id;
@property(nonatomic,copy )NSString *email;
@property(nonatomic,copy )NSString *fax ;
@property(nonatomic,copy )NSString *first_name;
@property(nonatomic,copy )NSString *if_bill_address;
@property(nonatomic,copy )NSString *is_default;   // 是否是默认收货地址，1代表是，2代表否
@property(nonatomic,copy )NSString *last_name;
@property(nonatomic,copy )NSString *state ;
@property(nonatomic,copy )NSString *stateName ;
@property(nonatomic,copy )NSString * street1;
@property(nonatomic,copy )NSString *street2;
@property(nonatomic,copy )NSString *telephone ;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,copy )NSString *zip ;


-(void)AdressListModelSuccess:(AdressListModelSuccessBlock)success andFailure:(AdressListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
