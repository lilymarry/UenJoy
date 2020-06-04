//
//  TouristChangecontry.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^TouristChangecontryModelSuccessBlock)(NSString *code,NSString* message,NSDictionary * data);
typedef void(^TouristChangecontryModelFaiulureBlock)(NSError *error);
@interface TouristChangecontry : NSObject

@property(nonatomic,copy )NSString *country;

-(void)TouristChangecontryModelSuccess:(TouristChangecontryModelSuccessBlock)success andFailure:(TouristChangecontryModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
