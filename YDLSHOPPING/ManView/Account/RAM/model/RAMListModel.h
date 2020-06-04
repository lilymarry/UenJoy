//
//  RAMListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RAMListModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^RAMListModelFaiulureBlock)(NSError *error);
@interface RAMListModel : NSObject
@property(nonatomic,copy )NSString *p;
@property(nonatomic,copy )NSString *type;
@property(nonatomic,strong)RAMListModel *data;
@property(nonatomic,strong )NSArray * coll;

@property(nonatomic,copy )NSString *base_grand_total;
@property(nonatomic,copy )NSString *base_payment_fee;
@property(nonatomic,copy )NSString *base_shipping_total;
@property(nonatomic,copy )NSString *base_subtotal;
@property(nonatomic,copy )NSString *base_subtotal_with_discount;
@property(nonatomic,copy )NSString *bill_address_city;
@property(nonatomic,copy )NSString *bill_address_country;
@property(nonatomic,copy )NSString *bill_address_id;
@property(nonatomic,copy )NSString *bill_address_state;
@property(nonatomic,copy )NSString *bill_address_street1;
@property(nonatomic,copy )NSString *bill_address_street2;
@property(nonatomic,copy )NSString *bill_address_zip;
@property(nonatomic,copy )NSString *bill_email;
@property(nonatomic,copy )NSString *bill_firstname;
@property(nonatomic,copy )NSString *bill_lastname;
@property(nonatomic,copy )NSString *bill_telephone;
@property(nonatomic,copy )NSString *build ;
@property(nonatomic,copy )NSString *charset ;
@property(nonatomic,copy )NSString *checkout_method;
@property(nonatomic,copy )NSString *correlation_id;
@property(nonatomic,copy )NSString *coupon_code;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *currency_symbol;
@property(nonatomic,copy )NSString *customer_address_city;
@property(nonatomic,copy )NSString *customer_address_country;
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
@property(nonatomic,copy )NSString *delivery_time;
@property(nonatomic,copy )NSString *grand_total;
@property(nonatomic,copy )NSString *if_is_return_stock;
@property(nonatomic,copy )NSString *if_return_goods_status;
@property(nonatomic,copy )NSString *increment_id;
@property(nonatomic,copy )NSString *ipn_track_id;
@property(nonatomic,copy )NSString *is_changed;
@property(nonatomic,copy )NSString *items_count;
@property(nonatomic,copy )NSString *order_currency_code;
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *order_remark;
@property(nonatomic,copy )NSString *order_shipping_status;
@property(nonatomic,copy )NSString *order_status;
@property(nonatomic,copy )NSString *order_to_base_rate;
@property(nonatomic,copy )NSString *payer_id;
@property(nonatomic,copy )NSString *payment_fee;
@property(nonatomic,copy )NSString *payment_method;
@property(nonatomic,copy )NSString *payment_token;
@property(nonatomic,copy )NSString *payment_type;
@property(nonatomic,copy )NSString *paypal_order_datetime;
@property(nonatomic,strong )NSArray *products;
@property(nonatomic,copy )NSString *base_price;
@property(nonatomic,copy )NSString *base_row_total;
//@property(nonatomic,copy )NSString *created_at;
       
@property(nonatomic,copy )NSString *custom_option_sku;
//@property(nonatomic,copy )NSString *customer_id;
@property(nonatomic,copy )NSString *image ;
@property(nonatomic,copy )NSString *item_id;
@property(nonatomic,copy )NSString *name ;
//@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *price ;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *qty;
@property(nonatomic,copy )NSString *redirect_url;
@property(nonatomic,copy )NSString *row_total;
@property(nonatomic,copy )NSString *row_weight;
@property(nonatomic,copy )NSString *sku;
@property(nonatomic,copy )NSString *spu_options;
@property(nonatomic,copy )NSString *store;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,copy )NSString *weight ;
@property(nonatomic,copy )NSString *protection_eligibility;
@property(nonatomic,copy )NSString *protection_eligibility_type;
@property(nonatomic,copy )NSString *receiver_id;
@property(nonatomic,copy )NSString *remote_ip;
@property(nonatomic,strong )NSArray *returnmsg ;
@property(nonatomic,copy )NSString *application_no;
@property(nonatomic,copy )NSString *application_time;
//@property(nonatomic,copy )NSString *created_at;
//@property(nonatomic,copy )NSString *customer_id;
@property(nonatomic,copy )NSString *customer_name;
@property(nonatomic,copy )NSString *deal_time;
@property(nonatomic,copy )NSString *email ;
//@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *return_desc;
@property(nonatomic,copy )NSString *return_title;
//@property(nonatomic,copy )NSString * type ;
@property(nonatomic,copy )NSString *secure_merchant_account_id;
@property(nonatomic,copy )NSString *shipping_method;
@property(nonatomic,copy )NSString *shipping_total;
//@property(nonatomic,copy )NSString *store ;
@property(nonatomic,copy )NSString *subtotal;
@property(nonatomic,copy )NSString *subtotal_with_discount;
@property(nonatomic,copy )NSString *theme_type;
@property(nonatomic,copy )NSString *total_weight;
@property(nonatomic,copy )NSString *tracking_company;
@property(nonatomic,copy )NSString *tracking_number;
@property(nonatomic,copy )NSString *txn_id;
@property(nonatomic,copy )NSString *txn_type;
//@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,copy )NSString *verify_sign;
@property(nonatomic,copy )NSString *version;

-(void)RAMListModelSuccess:(RAMListModelSuccessBlock)success andFailure:(RAMListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
