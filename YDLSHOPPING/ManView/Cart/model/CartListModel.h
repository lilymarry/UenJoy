//
//  CartListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CartListModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CartListModelFaiulureBlock)(NSError *error);
@interface CartListModel : NSObject
@property(nonatomic,strong)CartListModel *data;
@property(nonatomic,strong)CartListModel *cart_info;
@property(nonatomic,copy )NSString *base_coupon_cost;
@property(nonatomic,copy )NSString *base_grand_total;
@property(nonatomic,copy )NSString *base_product_total;
@property(nonatomic,copy )NSString *base_shipping_cost;
@property(nonatomic,copy )NSString *cart_id;
@property(nonatomic,copy )NSString *coupon_code;
@property(nonatomic,copy )NSString *coupon_cost;
@property(nonatomic,copy )NSString *grand_total;
@property(nonatomic,copy )NSString *items_count;
@property(nonatomic,copy )NSString *payment_method;
@property(nonatomic,copy )NSString *product_total;
@property(nonatomic,copy )NSString *product_volume;
@property(nonatomic,copy )NSString *product_volume_weight;
@property(nonatomic,copy )NSString *product_weight;

@property(nonatomic,strong)NSArray *products;
@property(nonatomic,copy )NSString *active ;
@property(nonatomic,copy )NSString *base_product_price;
@property(nonatomic,copy )NSString *base_product_row_price;
@property(nonatomic,strong)NSArray *custom_option;
@property(nonatomic,strong)CartListModel *custom_option_info;
@property(nonatomic,copy )NSString *size;


@property(nonatomic,copy )NSString *custom_option_sku;
@property(nonatomic,copy )NSString *img_url;
@property(nonatomic,copy )NSString *item_id;
@property(nonatomic,copy )NSString *name;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *product_price;
@property(nonatomic,copy )NSString *product_row_price;
@property(nonatomic,copy )NSString *product_row_volume;
@property(nonatomic,copy )NSString *product_row_volume_weight;
@property(nonatomic,copy )NSString *product_row_weigh;
@property(nonatomic,copy )NSString *product_url;

@property(nonatomic,copy )NSString *qty;
@property(nonatomic,copy )NSString *sku ;

@property(nonatomic,strong)CartListModel *spu_options;
@property(nonatomic,copy )NSString *spu_options_str;
@property(nonatomic,copy )NSString *url;
@property(nonatomic,copy )NSString *shipping_cost;
@property(nonatomic,copy )NSString *shipping_method;
@property(nonatomic,copy )NSString *store ;
@property(nonatomic,strong)CartListModel *currency;
@property(nonatomic,copy )NSString *code;
@property(nonatomic,copy )NSString *rate ;
@property(nonatomic,copy )NSString *symbol ;

//@property (assign,nonatomic)BOOL select;

-(void)CartListModelSuccess:(CartListModelSuccessBlock)success andFailure:(CartListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
