//
//  HomeFirstModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^HomeFirstModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^HomeFirstModelFaiulureBlock)(NSError *error);
@interface HomeFirstModel : NSObject
@property(nonatomic,strong)HomeFirstModel *data;
@property(nonatomic,strong)NSArray *banners;
@property(nonatomic,strong)id _id;

@property(nonatomic,copy )NSString *banner_img_url;
@property(nonatomic,copy )NSString *banner_img_url_small;
@property(nonatomic,copy )NSString *banner_index;
@property(nonatomic,copy )NSString *banner_url;
@property(nonatomic,copy )NSString *cat;
@property(nonatomic,copy )NSString *cid;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *created_user_id;
@property(nonatomic,copy )NSString *expiration_date;
@property(nonatomic,copy )NSString *status;
@property(nonatomic,copy )NSString *title ;
@property(nonatomic,copy )NSString *type;
@property(nonatomic,copy )NSString *updated_at;



@property(nonatomic,strong)NSArray *categoryindex;
@property(nonatomic,strong)NSArray *child;

@property(nonatomic,copy )NSString *level;
@property(nonatomic,copy )NSString *name ;
@property(nonatomic,copy )NSString *thumbnail_app;
@property(nonatomic,copy )NSString *thumbnail_image;
@property(nonatomic,copy )NSString *thumbnail_imageurl;



@property(nonatomic,strong)NSMutableArray *content_products;
//@property(nonatomic,copy )NSString *_id;
@property(nonatomic,copy )NSString *image ;
//@property(nonatomic,copy )NSString * name;
@property(nonatomic,copy )NSString * price ;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *review_count;
@property(nonatomic,copy )NSString *reviw_rate_star_average;
@property(nonatomic,copy )NSString *sku ;
@property(nonatomic,copy )NSString *special_price;
@property(nonatomic,copy )NSString * url;

@property(nonatomic,strong)NSArray *collection;
//@property(nonatomic,copy )NSString *level;
//@property(nonatomic,copy )NSString *name ;
//@property(nonatomic,copy )NSString *thumbnail_app;
//@property(nonatomic,copy )NSString *thumbnail_image;
//@property(nonatomic,copy )NSString *thumbnail_imageurl;
//@property(nonatomic,copy )NSString *image;
//@property(nonatomic,copy )NSString *name ;
//@property(nonatomic,copy )NSString *price;
//@property(nonatomic,copy )NSString *product_id;
//@property(nonatomic,copy )NSString *review_count;
//@property(nonatomic,copy )NSString *reviw_rate_star_average;
//@property(nonatomic,copy )NSString *sku;
//@property(nonatomic,copy )NSString *special_price;
//@property(nonatomic,copy )NSString *url ;
//
////@property(nonatomic,copy )NSString *image ;
//
//
//
//@property(nonatomic,strong)NSArray *collection;
//@property(nonatomic,strong)NSArray *functionspace;
//@property(nonatomic,copy )NSString *app_jump_url;
//@property(nonatomic,copy )NSString *cid ;
////@property(nonatomic,copy )NSString *created_at;
////@property(nonatomic,copy )NSString *created_user_id;
//@property(nonatomic,copy )NSString *img ;
//@property(nonatomic,copy )NSString *imglogo;
//@property(nonatomic,copy )NSString *imglogo_small;
////@property(nonatomic,copy )NSString *status ;
////@property(nonatomic,copy )NSString *title ;
//@property(nonatomic,copy )NSString *cat;
//@property(nonatomic,copy )NSString *thumbnail;
-(void)homeFirstModelSuccess:(HomeFirstModelSuccessBlock)success andFailure:(HomeFirstModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
