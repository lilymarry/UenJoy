//
//  AddOrDeleteFavoriteModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddOrDeleteFavoriteModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^AddOrDeleteFavoriteModelFaiulureBlock)(NSError *error);
@interface AddOrDeleteFavoriteModel : NSObject

@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *type;

@property(nonatomic,strong )AddOrDeleteFavoriteModel *data;
@property(nonatomic,copy )NSString *fav;

-(void)addOrDeleteFavoriteModelSuccess:(AddOrDeleteFavoriteModelSuccessBlock)success andFailure:(AddOrDeleteFavoriteModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
