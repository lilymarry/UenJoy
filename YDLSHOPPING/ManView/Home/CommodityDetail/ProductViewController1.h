//
//  ProductViewController1.h
//  YDLSHOPPING
//
//  Created by mac on 2020/1/20.
//  Copyright © 2020 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductViewController1 : UIViewController
@property(strong ,nonatomic)NSString * product_id;
@property(strong ,nonatomic)ProductDetailModel* productModel;
@end

NS_ASSUME_NONNULL_END
