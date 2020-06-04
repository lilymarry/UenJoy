//
//  ChangeCountryModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChangeCountryModelSuccessBlock)(NSString *code,NSString* message,NSDictionary * data);
typedef void(^ChangeCountryModelFaiulureBlock)(NSError *error);
@interface ChangeCountryModel : NSObject

@property(nonatomic,copy )NSString *country;

-(void)ChangeCountryModelSuccess:(ChangeCountryModelSuccessBlock)success andFailure:(ChangeCountryModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
