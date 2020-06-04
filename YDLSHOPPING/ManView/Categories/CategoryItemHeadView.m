//
//  CategoryItemHeadView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoryItemHeadView.h"
@interface CategoryItemHeadView ()
{
    BOOL isHave;//是否有图
}

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *titleImag;
@property(nonatomic, strong) UIView *lineView;

@end
@implementation CategoryItemHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
   
        self.titleButton = [ReviewOneBtn new];
        [self.contentView addSubview:self.titleButton];
        
        
        self.titleImag = [UIImageView new];
        self.titleImag.image=[UIImage imageNamed:@"黑色上箭头"];
        [self.contentView addSubview:self.titleImag];
        
        
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor=Color(@"#EEEEEE");
        [self.contentView addSubview:self.lineView];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor=Color(@"#333333");
        self.titleLabel.font=font(16);
        [self.contentView addSubview:self.titleLabel];
        
        
        
    }
    return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make){
     //   make.center.equalTo(self.contentView);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.top.offset(0);
    }];
    
    [self.titleImag mas_makeConstraints:^(MASConstraintMaker *make){
      make.centerY.equalTo(self.contentView);
        make.right.offset(-5);
        make.width.offset(13.75);
        make.height.offset(8.1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.titleImag).offset(-5);
        make.left.offset(5);
      
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make){

        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
    
}
- (void)configWithData:(NSDictionary *)data
{
    self.titleLabel.text=data[@"name"];
    if ([data[@"isExtend"] isEqualToString:@"1"]) {
          self.titleImag.image=[UIImage imageNamed:@"黑色上箭头"];
    }
    else
    {
          self.titleImag.image=[UIImage imageNamed:@"灰色下箭头"];
    }
}

@end
