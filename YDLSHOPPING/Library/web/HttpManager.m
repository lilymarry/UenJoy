//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HttpManager.h"
#import "BaseAFNetworkingManager.h"
@interface HttpManager ()

@end

@implementation HttpManager

// 默认请求二进制
// 默认响应是JSON

+ (void)postWithUrl:(NSString *)url
       baseurl:(NSString *)baseurl
      andParameters:(NSDictionary *)params
         andSuccess:(HttpSuccessBlock)success
            andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
 
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodPOST url:baseurl apiPath:url parameters:params progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)getWithUrl:(NSString *)url
           baseurl:(NSString *)baseurl
     andParameters:(NSDictionary *)params
        andSuccess:(HttpSuccessBlock)success
           andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    NSLog(@"sss %@",params);
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodGET url:baseurl apiPath:url parameters:params progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)postUploadMultipleImagesWithUrl:(NSString *)url
                          andImageNames:(NSArray *)images
                             andKeyName:(NSString *)keyName
                          andParameters:(NSDictionary *)params
                             andSuccess:(HttpSuccessBlock)success
                                andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    if (images == nil) {
        images = @[];
    }
    if (keyName == nil) {
        keyName = @"";
    }
 
    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
      NSString *login_token =  [[LoginModel shareInstance]getUserInfo].uinfo.access_token;
     NSString *login_uid=  [[LoginModel shareInstance]getUserInfo].uuid;
     NSLog(@"login_token %@",login_token);
     NSLog(@"login_uid %@",login_uid);
     
     
     NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
     NSLog(@"Tourist_id %@",uid);
     
     if (login_uid.length>0) {
         [manager.requestSerializer setValue:login_token forHTTPHeaderField:@"access-token"];
         [manager.requestSerializer setValue:login_uid forHTTPHeaderField:@"fecshop-uuid"];
         
     }
     else
     {
         
         [manager.requestSerializer setValue:uid forHTTPHeaderField:@"fecshop-uuid"];
     }
     
     
     
     [manager.requestSerializer setValue:@"USD" forHTTPHeaderField:@"fecshop-currency"];
     [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"fecshop-lang"];
     
     NSLog(@"fecshop-currency USD");
     NSLog(@"fecshop-lang en");
    
    

    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
 
        for(int  i = 0; i <images.count; i++)
        {
            NSData * imageData;
            NSString *suffix,*contentType;
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(images[i])) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(images[i]);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(images[i], 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
       
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                       [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
                       NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
        
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@_%d.%@",appendStringToImageName, i,suffix] fileName:[NSString stringWithFormat:@"%@_%d.%@",appendStringToImageName, i,suffix]  mimeType:contentType];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
@end
