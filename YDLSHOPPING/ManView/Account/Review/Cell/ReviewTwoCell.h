//
//  ReviewTwoCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/9/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewLlistMdel.h"
#import "ReviewOneBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReviewTwoCell : UITableViewCell
@property (nonatomic, strong) ReviewLlistMdel *data;
@property (nonatomic, strong) NSString *codeSymbol;
@property(nonatomic ,strong)ReviewOneBtn*  reviseReview;
@end

NS_ASSUME_NONNULL_END
