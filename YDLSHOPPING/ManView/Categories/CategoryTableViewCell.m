//
//  CategoryTableViewCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleText = [[UILabel alloc] init];
        self.titleText.numberOfLines=0;
     self.titleText.textAlignment=NSTextAlignmentCenter;
        self.titleText.font =font(12*AUTOLAYOUT_WIDTH_SCALE);
        [self.contentView addSubview:self.titleText];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.titleText mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(self.contentView);
        make.width.offset(self.contentView.frame.size.width-4);
        make.left.offset(2);
     
        
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
