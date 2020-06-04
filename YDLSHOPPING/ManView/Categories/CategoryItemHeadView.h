//
//  CategoryItemHeadView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewOneBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface CategoryItemHeadView : UITableViewHeaderFooterView
@property (nonatomic, strong) ReviewOneBtn *titleButton;
- (void)configWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
