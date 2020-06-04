//
//  CategoriesModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CategoriesModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CategoriesModelFaiulureBlock)(NSError *error);
@interface CategoriesModel : NSObject

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)NSArray *child;

@property(nonatomic,copy )NSString *_id;
@property(nonatomic,copy )NSString *level;
@property(nonatomic,copy )NSString *name;
@property(nonatomic,copy )NSString *thumbnail_image;
@property(nonatomic,copy )NSString *thumbnail_imageurl;
@property(nonatomic,assign )BOOL isSelect;
-(void)categoriesModelSuccess:(CategoriesModelSuccessBlock)success andFailure:(CategoriesModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
