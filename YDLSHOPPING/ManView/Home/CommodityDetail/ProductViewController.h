//
//  ProductViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductViewController : UIViewController
@property(strong ,nonatomic)NSString * product_id;
@property(strong ,nonatomic)ProductDetailModel* productModel;


@end

NS_ASSUME_NONNULL_END

