//
//  SelectPicView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SelectPicViewDelegate <NSObject>

- (void)removeImageView:(int)index andType:(NSString *) type;
- (void)showImageView:(int)index andType:(NSString *) type ;


@end

@interface SelectPicView : UIView
@property (nonatomic, weak) id<SelectPicViewDelegate> delegate;

@property (nonatomic, strong) NSString *typeStr;
- (void)refresPictureView:(NSArray *)lists;
@end

NS_ASSUME_NONNULL_END
