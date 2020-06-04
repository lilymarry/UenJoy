//
//  CategoriesDetailController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesDetailController : UIViewController
@property(strong ,nonatomic)NSString * categories_id;
@property(strong ,nonatomic)NSMutableArray * categoriesTitleArr;

@property(assign ,nonatomic)BOOL isShowCategoriesTitle;
@property(assign ,nonatomic)NSString * type; //首页进入 1 其他页进入可不设置 (为了区分model类型 )
@end

NS_ASSUME_NONNULL_END
