//
//  ExchangToJsonData.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExchangToJsonData : NSObject

//数组转json
+(NSString*)ArrToJSONString:(NSArray  *)arr;
//字典转json
+(NSString*)dicToJSONString:(NSDictionary  *)arr;
@end

NS_ASSUME_NONNULL_END
