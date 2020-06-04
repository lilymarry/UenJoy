//
//  AccountTableViewCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.font =font(14);
        [self.contentView addSubview:self.label];
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:self.image];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(60, 0, 300, 50);
    self.image.frame = CGRectMake(18, 17, 16, 16);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
