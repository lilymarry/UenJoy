//
//  GetFavoriteStateModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetFavoriteStateModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^GetFavoriteStateModelFaiulureBlock)(NSError *error);
@interface GetFavoriteStateModel : NSObject

@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,strong )GetFavoriteStateModel *data;
@property(nonatomic,copy )NSString *fav;
-(void)getFavoriteStateModelSuccess:(GetFavoriteStateModelSuccessBlock)success andFailure:(GetFavoriteStateModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
