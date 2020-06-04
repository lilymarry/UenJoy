//
//  SearchGoodsModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SearchGoodsModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^SearchGoodsModelFaiulureBlock)(NSError *error);
@interface SearchGoodsModel : NSObject
@property(nonatomic,copy )NSString *q;
@property(nonatomic,copy )NSDictionary *filterAttrs;
@property(nonatomic,copy )NSString *pric;
@property(nonatomic,copy )NSString *p;

@property(nonatomic,strong)SearchGoodsModel *data;
@property(nonatomic,strong)NSArray * products;

@property(nonatomic,copy )NSString *_id;
@property(nonatomic,copy )NSString *image;
@property(nonatomic,copy )NSString *name ;
@property(nonatomic,strong)SearchGoodsModel *price;
@property(nonatomic,copy )NSString *code ;
@property(nonatomic,copy )NSString *symbol;
@property(nonatomic,copy )NSString *value ;
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *review_count;
@property(nonatomic,copy )NSString *reviw_rate_star_average;
@property(nonatomic,copy )NSString *sku;
@property(nonatomic,strong)SearchGoodsModel *special_price;
@property(nonatomic,copy )NSString *url ;

-(void)SearchGoodsModelSuccess:(SearchGoodsModelSuccessBlock)success andFailure:(SearchGoodsModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
