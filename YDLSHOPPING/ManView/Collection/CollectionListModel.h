//
//  CollectionListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CollectionListModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CollectionListModelFaiulureBlock)(NSError *error);
@interface CollectionListModel : NSObject
@property(nonatomic,strong)CollectionListModel *data;
@property(nonatomic,strong)NSArray *collection;
@property(nonatomic,copy )NSString *collection_desc;
@property(nonatomic,copy )NSString *collection_img;
@property(nonatomic,strong )NSArray *collection_imgs;
@property(nonatomic,strong )NSArray *collection_imgs_small;
@property(nonatomic,copy )NSString *collection_index;
@property(nonatomic,copy )NSString *collection_sku;
@property(nonatomic,copy )NSString *collection_title;
@property(nonatomic,copy )NSString *collection_url;
@property(nonatomic,copy )NSString *collection_video;
@property(nonatomic,strong)NSArray *content_products;
@property(nonatomic,copy )NSString *_id;
@property(nonatomic,copy )NSString *image;
@property(nonatomic,copy )NSString *name;
@property(nonatomic,copy )NSString *price ;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *review_count;
@property(nonatomic,copy )NSString *reviw_rate_star_average;
@property(nonatomic,copy )NSString *sku;
@property(nonatomic,copy )NSString *special_price;
@property(nonatomic,copy )NSString *url ;
@property(nonatomic,copy )NSString *count ;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *created_user_id;
@property(nonatomic,copy )NSString *expiration_date;
//@property(nonatomic,copy )NSString *price ;
@property(nonatomic,copy )NSString *status ;
@property(nonatomic,copy )NSString *updated_at;
-(void)CollectionListModelSuccess:(CollectionListModelSuccessBlock)success andFailure:(CollectionListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
