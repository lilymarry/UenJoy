//
//  AddShippingAddressViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^AddAddressSuccessBlock)(void);

@interface AddShippingAddressViewController : UIViewController
@property(strong ,nonatomic)NSString *address_id;
@property(strong ,nonatomic)AdressListModel *mainModel;
@property (nonatomic, copy) AddAddressSuccessBlock AddBlock ;
@end

NS_ASSUME_NONNULL_END
