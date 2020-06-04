//
//  NotificationModel.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^NotificationModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^NotificationModelFaiulureBlock)(NSError *error);
@interface NotificationModel : NSObject
@property(nonatomic,copy )NSString *customerid;
@property(nonatomic,copy )NSString *numperpage;
@property(nonatomic,copy )NSString *pagenum;


@property(nonatomic,strong)NotificationModel *data;
@property(nonatomic,strong)NSArray *private_inform;
@property(nonatomic,strong)NotificationModel *_id;
@property(nonatomic,copy )NSString *$oid;
@property(nonatomic,copy )NSString *created_at;
@property(nonatomic,copy )NSString *created_user_id;
@property(nonatomic,copy )NSString *from_side;
@property(nonatomic,copy )NSString *if_read;
@property(nonatomic,copy )NSString *inform_content;
@property(nonatomic,copy )NSString *inform_title;
@property(nonatomic,copy )NSString * status ;
@property(nonatomic,copy )NSString *to_side;
@property(nonatomic,copy )NSString *type;
@property(nonatomic,copy )NSString *updated_at;
@property(nonatomic,strong)NSArray *private_inform2;
@property(nonatomic,strong)NSArray *public_inform;
-(void)notificationModelSuccess:(NotificationModelSuccessBlock)success andFailure:(NotificationModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
