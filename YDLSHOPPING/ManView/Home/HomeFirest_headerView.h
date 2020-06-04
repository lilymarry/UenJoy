//
//  HomeFirest_headerView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFirstModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectTitleBlock)(NSInteger index);
@interface HomeFirest_headerView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *header1Image;
@property (weak, nonatomic) IBOutlet UILabel *header1Name;
@property (weak, nonatomic) IBOutlet UIView *cataView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, copy) SelectTitleBlock titleBlock ;
@end

NS_ASSUME_NONNULL_END
