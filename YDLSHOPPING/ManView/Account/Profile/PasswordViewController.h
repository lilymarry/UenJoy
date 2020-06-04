//
//  PasswordViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PasswordlBlock)(void);

@interface PasswordViewController : UIViewController
@property (nonatomic, copy) PasswordlBlock passwordBlock ;
@end

NS_ASSUME_NONNULL_END
