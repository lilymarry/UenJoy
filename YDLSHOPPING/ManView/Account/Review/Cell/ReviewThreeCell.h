//
//  ReviewThreeCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReviewThreeCellBlock)(NSArray *imageArr,NSString *num,NSString *descStr);

@interface ReviewThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, copy) ReviewThreeCellBlock threeBlock;
@property (nonatomic, strong)  NSMutableArray *saveArr;
@property (nonatomic, strong)  NSString *rateNum;
@property (nonatomic, strong)  NSString *desc;
- (void)loadPicView;
@end

NS_ASSUME_NONNULL_END
