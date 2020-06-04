//
//  CategoriesDetailModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CategoriesDetailModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CategoriesDetailModelFaiulureBlock)(NSError *error);
@interface CategoriesDetailModel : NSObject

@property(nonatomic,copy )NSString *categoryId;
@property(nonatomic,copy )NSString *sortColumn;
@property(nonatomic,copy )NSDictionary *filterAttrs;
@property(nonatomic,copy )NSString *filterPrice;
@property(nonatomic,copy )NSString *p;

@property(nonatomic,strong )NSArray * products;
@property(nonatomic,strong )CategoriesDetailModel * data;

@property(nonatomic,copy )NSString *_id;
@property(nonatomic,copy )NSString *image;
@property(nonatomic,copy )NSString *name;
@property(nonatomic,strong )CategoriesDetailModel *price ;
@property(nonatomic,copy )NSString * code;
@property(nonatomic,copy )NSString *symbol;
@property(nonatomic,copy )NSString * value;

@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *review_count;
@property(nonatomic,copy )NSString *reviw_rate_star_average;
@property(nonatomic,copy )NSString *sku;
@property(nonatomic,strong )CategoriesDetailModel *special_price ;

@property(nonatomic,copy )NSString *url;

-(void)categoriesDetailModelSuccess:(CategoriesDetailModelSuccessBlock)success andFailure:(CategoriesDetailModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
