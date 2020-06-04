//
//  User.h
//  SuperiorAcme
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface User : NSObject
@property(nonatomic,strong )User *data;

@property(nonatomic,strong)User *uinfo ;
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *uuid ;
@property(nonatomic,copy)NSString *access_token_created_at;
@property(nonatomic,copy)NSString *allowance ;
@property(nonatomic,copy)NSString *allowance_updated_at;
@property(nonatomic,copy)NSString *auth_key;
@property(nonatomic,copy)NSString *birth_date;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString * email;
@property(nonatomic,copy)NSString *facebookid;
@property(nonatomic,copy)NSString *favorite_product_count;
@property(nonatomic,copy)NSString *firstname;
@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *is_subscribed;
@property(nonatomic,copy)NSString *lastname;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *order_change;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *password_hash;
@property(nonatomic,copy)NSString *password_reset_token;
@property(nonatomic,copy)NSString *receive_code;
@property(nonatomic,copy)NSString *review_change;
@property(nonatomic,copy)NSString *share_code;
@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *type ;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *userimg;
@property(nonatomic,copy)NSString *wx_openid;
@property(nonatomic,copy)NSString *wx_session_key;

@end
