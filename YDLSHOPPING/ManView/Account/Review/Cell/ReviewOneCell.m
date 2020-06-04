//
//  OneCell.m
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/20.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "ReviewOneCell.h"
@interface ReviewOneCell()

@end
@implementation ReviewOneCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        UIImageView *image = [UIImageView new];
        self.image = image;
        [self.contentView addSubview:image];
        
        UILabel *title = [UILabel new];
        title.textColor = Color(@"#333333");
        title.font =  font(14);
        self.title = title;
        [self.contentView addSubview:title];

        UILabel *money = [UILabel new];
        money.textColor = Color(@"#333333");
        money.font = [UIFont boldSystemFontOfSize:15];;
        self.money = money;
        [self.contentView addSubview:money];
        
        ReviewOneBtn *button = [ReviewOneBtn new];
        self.AddBtn = button;
        [button setTitle:@"Add review" forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:0];
        button.titleLabel.font = font(12);
        [button setBackgroundColor:Color(@"#F6AA00")];
        [self.contentView addSubview:button];
        
        UIView *line = [UIView new];
        [line setBackgroundColor:Color(@"f5f5f5")];
        [self.contentView addSubview:line];
        
    
        
        [self.image mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.contentView).offset(16);
            make.height.offset(60);
            make.width.offset(60);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.image.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.contentView).offset(16);
        }];
        
        [self.money mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.title);
            make.bottom.equalTo(self.image.mas_bottom);
        }];
        
        [self.AddBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.title.mas_bottom).offset(20);
            make.height.offset(30);
            make.width.offset(100);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.offset(1);
            
        }];
        self.image.image = [UIImage imageNamed:@"home_collection_pic_"];
        self.title.text = @"Hydra wood square bedside table wood asdfsadf asdf asdf asd asdf adsf ";
        self.money.text = @"TOTAL:$23.00";
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)setData:(NSDictionary *)data{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//-(void)setFrame:(CGRect)frame
//{
////    frame.origin.x =12;
////    frame.size.width -=frame.origin.x * 2;
//    frame.size.height -= 15;
//    [super setFrame:frame];
//}

@end
