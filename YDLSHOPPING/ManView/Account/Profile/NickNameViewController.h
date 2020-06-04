//
//  NickNameViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ChangeNickNameBlock)(void);
@interface NickNameViewController : UIViewController
@property (nonatomic, strong) NSString *name ;
@property (nonatomic, copy) ChangeNickNameBlock nameBlock ;
@end

NS_ASSUME_NONNULL_END
