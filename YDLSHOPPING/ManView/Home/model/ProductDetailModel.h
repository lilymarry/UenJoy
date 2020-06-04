//
//  ProductDetailModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ProductDetailModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^ProductDetailModelFaiulureBlock)(NSError *error);
@interface ProductDetailModel : NSObject

@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,strong)ProductDetailModel *data;
@property(nonatomic,strong)NSArray * Combine;
@property(nonatomic,strong)ProductDetailModel * product ;
@property(nonatomic,copy )NSString *_id;
@property(nonatomic,strong )NSArray *custom_option;
@property(nonatomic,copy )NSString * desc;
@property(nonatomic,strong)NSArray *image_detail;

@property(nonatomic,copy )NSString *meta_title;
@property(nonatomic,copy )NSString *name ;
@property(nonatomic,strong)NSArray *options ;
@property(nonatomic,strong)ProductDetailModel * price_info;
@property(nonatomic,strong)ProductDetailModel * price;
@property(nonatomic,copy )NSString *code ;
@property(nonatomic,copy )NSString *symbol ;
@property(nonatomic,copy )NSString * value ;

@property(nonatomic,strong)ProductDetailModel * special_price;
@property(nonatomic,strong)NSArray *thumbnail_img;
@property(nonatomic,copy )NSString *image_imgdesc ;
@property(nonatomic,copy )NSString *image ;
@property(nonatomic,strong)ProductDetailModel * productReview;
@property(nonatomic,strong)NSArray *coll;


@property(nonatomic,copy )NSString *belong_to_order_id;
@property(nonatomic,copy )NSString *ifamazonreview;
@property(nonatomic,copy )NSString *ip ;
@property(nonatomic,copy )NSString *lang_code;
//@property(nonatomic,copy )NSString *name;
//@property(nonatomic,copy )NSString *product_id; ;
@property(nonatomic,copy )NSString *product_spu;
@property(nonatomic,copy )NSString *rate_star;
@property(nonatomic,copy )NSString *review_content;
@property(nonatomic,copy )NSString *review_date;
@property(nonatomic,copy )NSString *review_date_str;
@property(nonatomic,copy )NSString *review_imgs;
@property(nonatomic,copy )NSString *status ;
@property(nonatomic,copy )NSString *store;
@property(nonatomic,copy )NSString *summary ;
@property(nonatomic,copy )NSString *user_id;
@property(nonatomic,copy )NSString *noActiveStatus ;
@property(nonatomic,copy )NSString *review_count ;
@property(nonatomic,copy )NSString * spu ;
@property(nonatomic,strong)NSArray *groupAttrArrNew;
@property(nonatomic,copy )NSString *key ;
@property(nonatomic,copy )NSString * main_image ;
@property(nonatomic,strong)NSArray *long_img;
-(void)productDetailModelSuccess:(ProductDetailModelSuccessBlock)success andFailure:(ProductDetailModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
