//
//  WishListModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^WishListModelSuccessBlock)(NSString *code,NSString* message,id data);
typedef void(^WishListModelFaiulureBlock)(NSError *error);
@interface WishListModel : NSObject
@property(nonatomic,copy )NSString *p ;
@property(nonnull ,strong) WishListModel * data;
@property(nonatomic,copy )NSString *count ;
@property(nonatomic,copy )NSString *numPerPage;

@property(nonatomic,strong )NSArray *productList;
@property(nonatomic,copy )NSString *imgUrl;
@property(nonatomic,copy )NSString *name;
@property(nonatomic,strong )WishListModel *price_info;
@property(nonatomic,strong )WishListModel *price ;
@property(nonatomic,copy )NSString *code;
@property(nonatomic,copy )NSString *symbol ;
@property(nonatomic,copy )NSString *value ;
@property(nonatomic,strong )WishListModel *special_price;

@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *special_from;

@property(nonatomic,copy )NSString *special_to;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,copy )NSString *url_key;
@property(nonatomic,assign )BOOL  isSelect;
-(void)WishListModelSuccess:(WishListModelSuccessBlock)success andFailure:(WishListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
