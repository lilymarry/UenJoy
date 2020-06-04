//
//  ReviewLlistMdel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ReviewLlistMdelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^ReviewLlistMdelFaiulureBlock)(NSError *error);
@interface ReviewLlistMdel : NSObject
@property(nonatomic,copy )NSString *return_type;
@property(nonatomic,strong)ReviewLlistMdel *data;

@property(nonatomic,copy )NSString * activeStatus;
@property(nonatomic,copy )NSString *noActiveStatus;
@property(nonatomic,copy )NSString *    numPerPage;
@property(nonatomic,strong )NSArray *    productList;
@property(nonatomic,copy )NSString *base_grand_total;
@property(nonatomic,copy )NSString *base_payment_fee;
@property(nonatomic,copy )NSString *base_shipping_total;
@property(nonatomic,copy )NSString *base_subtotal;
@property(nonatomic,copy )NSString *base_subtotal_with_discount;
@property(nonatomic,copy )NSString *bill_address_id;
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
@property(nonatomic,strong )NSArray *products ;
@property(nonatomic,copy )NSString *base_price;
@property(nonatomic,copy )NSString *base_row_total;
//@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,strong )NSArray *custom_option;
@property(nonatomic,strong )NSArray *custom_option_info;
@property(nonatomic,copy )NSString *custom_option_sku;
//@property(nonatomic,copy )NSString *customer_id;
//@property(nonatomic,copy )NSString *image ;
@property(nonatomic,copy )NSString *item_id;
@property(nonatomic,copy )NSString *name ;
//@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *price ;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *qty;
@property(nonatomic,copy )NSString *redirect_url;
@property(nonatomic,copy )NSString *row_total;
@property(nonatomic,copy )NSString *row_weight;
@property(nonatomic,copy )NSString *sku ;
@property(nonatomic,copy )NSString *spu ;
@property(nonatomic,strong )NSArray *spu_options;
@property(nonatomic,copy )NSString *store;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,copy )NSString *weight;

@property(nonatomic,copy )NSString *subtotal;

@property(nonatomic,strong)ReviewLlistMdel *review;
@property(nonatomic,strong)ReviewLlistMdel *_id;
@property(nonatomic,copy )NSString *$oid;
@property(nonatomic,copy )NSString *belong_to_order_id;
@property(nonatomic,strong)id  image;
@property(nonatomic,strong)NSArray *gallery;

@property(nonatomic,strong )NSArray *review_imgs;
@property(nonatomic,copy )NSString *image_ifshowdetail;
@property(nonatomic,copy )NSString *image_ifshowindesc;
@property(nonatomic,copy )NSString *image_imgdesc;
@property(nonatomic,copy )NSString *imgstorageurl ;
@property(nonatomic,copy )NSString *is_detail;
@property(nonatomic,copy )NSString *is_thumbnails;
@property(nonatomic,copy )NSString *label;
@property(nonatomic,copy )NSString *sort_order;
@property(nonatomic,copy )NSString *pic;

@property(nonatomic,copy )NSString *ip ;
@property(nonatomic,copy )NSString *lang_code;
//@property(nonatomic,copy )NSString *name ;
//@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *product_spu;
@property(nonatomic,copy )NSString *rate_star;
@property(nonatomic,copy )NSString *review_content;
@property(nonatomic,copy )NSString *review_date;
//@property(nonatomic,copy )NSString *spu ;
@property(nonatomic,copy )NSString *status;
//@property(nonatomic,copy )NSString *store;
@property(nonatomic,copy )NSString *summary;
@property(nonatomic,copy )NSString *url_key;
@property(nonatomic,copy )NSString *user_id;


-(void)ReviewLlistMdelSuccess:(ReviewLlistMdelSuccessBlock)success andFailure:(ReviewLlistMdelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
