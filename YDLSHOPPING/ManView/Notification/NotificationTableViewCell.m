//
//  NotificationTableViewCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "NotificationTableViewCell.h"
@interface NotificationTableViewCell()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@end
@implementation NotificationTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview{
    static NSString *ID=@"notificationCell";
    NotificationTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[NotificationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *title = [UILabel new];
        title.textColor = Color(@"#333333");
        title.font = [UIFont boldSystemFontOfSize:15];
        self.title = title;
        [self.contentView addSubview:title];
        
        UILabel *content = [UILabel new];
        content.textColor = Color(@"#333333");
        content.numberOfLines = 0;
        content.font = font(14);
        self.content = content;
        [self.contentView addSubview:content];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView).offset(20);
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.title.mas_bottom).offset(8);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setModel:(NotificationModel *)model{
    _model=model;
    self.title.text=model.inform_title;
    self.content.text=model.inform_content;
    
}
@end
