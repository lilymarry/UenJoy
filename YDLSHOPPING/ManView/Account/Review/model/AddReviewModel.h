//
//  AddReviewModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddReviewModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^AddReviewModelFaiulureBlock)(NSError *error);
@interface AddReviewModel : NSObject
@property(nonatomic,copy )NSString *product_id;
@property(nonatomic,copy )NSString *order_id;
@property(nonatomic,copy )NSString *rate_star;
@property(nonatomic,copy )NSString *name;
@property(nonatomic,copy )NSString *summary;
@property(nonatomic,copy )NSString *review_content;
@property(nonatomic,copy )NSString *review_imgs;

-(void)AddReviewModelSuccess:(AddReviewModelSuccessBlock)success andFailure:(AddReviewModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
