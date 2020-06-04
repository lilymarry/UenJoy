//
//  TwoCell.h
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/20.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoCell : UITableViewCell
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *onLab;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *codeLab;
@property (nonatomic, strong) UIButton *CopyBtn;
@property (nonatomic, strong) UIImageView *flagImagV;
@end

NS_ASSUME_NONNULL_END
