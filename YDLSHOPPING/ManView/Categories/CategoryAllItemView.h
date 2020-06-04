//
//  CategoryAllItemView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CategorySetBlock)(NSArray *data,NSDictionary *para,NSDictionary *priceDic ,BOOL isFilter);
typedef void(^CategoryResetBlock)(void);
@interface CategoryAllItemView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSDictionary *priceData;
@property (nonatomic, copy) CategorySetBlock setBlock ;
@property (nonatomic, copy) CategoryResetBlock resetBlock ;
- (void)loadView;
@end

NS_ASSUME_NONNULL_END
