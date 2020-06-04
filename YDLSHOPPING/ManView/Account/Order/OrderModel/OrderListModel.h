//
//  OrderListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^OrderListModelSuccessBlock)(NSString *code,NSString* message,id data);
typedef void(^OrderListModelFaiulureBlock)(NSError *error);
@interface OrderListModel : NSObject
@property(nonatomic,copy )NSString *p;
@property(nonatomic,copy )NSString *wxRequestOrderStatus;
@property(nonatomic,strong )OrderListModel *data;
@property(nonatomic,strong )NSArray *orderList;
@property(nonatomic,copy )NSString *base_grand_total;
@property(nonatomic,copy )NSString *base_shipping_total;
@property(nonatomic,copy )NSString *base_subtotal;
@property(nonatomic,copy )NSString *base_subtotal_with_discount;
@property(nonatomic,copy )NSString *checkout_method;
@property(nonatomic,copy )NSString *coupon_code;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *currency_symbol;
@property(nonatomic,copy )NSString *customer_address_city;
@property(nonatomic,copy )NSString *customer_address_country_name;
@property(nonatomic,copy )NSString *customer_address_state;
@property(nonatomic,copy )NSString *customer_address_state_name;
@property(nonatomic,copy )NSString *customer_address_street1;
@property(nonatomic,copy )NSString *customer_address_street2;
@property(nonatomic,copy )NSString *customer_address_zip;
@property(nonatomic,copy )NSString *customer_email;
@property(nonatomic,copy )NSString *customer_firstname;
@property(nonatomic,copy )NSString *customer_group;
@property(nonatomic,copy )NSString *customer_id;
@property(nonatomic,copy )NSString *customer_is_guest;
@property(nonatomic,copy )NSString *customer_lastname;
@property(nonatomic,copy )NSString *customer_telephone;
@property(nonatomic,copy )NSString *grand_total;
@property(nonatomic,copy )NSString *increment_id;
@property(nonatomic,copy )NSString *items_count;
@property(nonatomic,copy )NSString *order_currency_code;
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *order_status;
@property(nonatomic,copy )NSString *order_to_base_rate;
@property(nonatomic,copy )NSString *payment_method;
@property(nonatomic,copy )NSString *products;
@property(nonatomic,copy )NSString *shipping_method;
@property(nonatomic,copy )NSString *shipping_total;
@property(nonatomic,copy )NSString *subtotal;
@property(nonatomic,copy )NSString *subtotal_with_discount;
@property(nonatomic,copy )NSString *total_weight;
@property(nonatomic,copy )NSString *tracking_company;
@property(nonatomic,copy )NSString *tracking_number;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,strong )NSArray *item_products;

@property(nonatomic,copy )NSString *base_price;
@property(nonatomic,copy )NSString *base_row_total;
//@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *custom_option_sku;
//@property(nonatomic,copy )NSString *customer_id;
@property(nonatomic,copy )NSString *image;
@property(nonatomic,copy )NSString *item_id;
@property(nonatomic,copy )NSString *name;
//@property(nonatomic,copy )NSString *order_id; ;
@property(nonatomic,copy )NSString *price ;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *qty;
@property(nonatomic,copy )NSString *redirect_ur;
@property(nonatomic,copy )NSString *row_total;
@property(nonatomic,copy )NSString *row_weight;
@property(nonatomic,copy )NSString *sku;
@property(nonatomic,copy )NSString *store ;
@property(nonatomic,copy )NSString *pic;
@property(nonatomic,copy )NSString *weight;

-(void)OrderListModelSuccess:(OrderListModelSuccessBlock)success andFailure:(OrderListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
