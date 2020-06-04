//
//  AddReviewsViewController.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewLlistMdel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^AddBlock)(void);
@interface AddReviewsViewController : UIViewController
@property(nonatomic,strong)  ReviewLlistMdel *mainModel;
@property (nonatomic, strong) NSString *codeSymbol;
@property (nonatomic, copy) AddBlock block;
@end

NS_ASSUME_NONNULL_END
