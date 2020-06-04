//
//  AddPicReviewModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddPicReviewModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^AddPicReviewModelFaiulureBlock)(NSError *error);
@interface AddPicReviewModel : NSObject

@property(nonatomic,copy )NSArray *FILE;
@property(nonatomic,strong )AddPicReviewModel *data;
@property(nonatomic,copy )NSString *relative_path;
-(void)AddPicReviewModelSuccess:(AddPicReviewModelSuccessBlock)success andFailure:(AddPicReviewModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
