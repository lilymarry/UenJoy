//
//  ExchangToJsonData.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ExchangToJsonData.h"

@implementation ExchangToJsonData
//数组转json

+(NSString*)ArrToJSONString:(NSArray  *)arr{
    
    NSError*error =nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                        
                                                       options:kNilOptions
                        
                                                         error:&error];
    
    
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                            
                                                 encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}

//字典转json

+ (NSString*)dicToJSONString:(NSDictionary  *)arr
{
    NSError*error =nil;
    NSData*jsonData =nil;
    if(!self) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [arr enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,id  _Nonnull obj,BOOL*_Nonnull stop) {
        NSString*keyString =nil;
        NSString*valueString =nil;
        
        if ([key isKindOfClass:[NSString class]]) {
            
            keyString = key;
            
        }else{
            
            keyString = [NSString stringWithFormat:@"%@",key];
            
        }
        
        
        
        if ([obj isKindOfClass:[NSString class]]) {
            
            valueString = obj;
            
        }else{
            
            valueString = [NSString stringWithFormat:@"%@",obj];
            
        }
        
        
        
        [dict setObject:valueString forKey:keyString];
        
    }];
    
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    
    if([jsonData length] == 0 || error !=nil) {
        
        return nil;
        
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
    
    
}
@end
