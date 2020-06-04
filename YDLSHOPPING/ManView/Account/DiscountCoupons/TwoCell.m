//
//  OneCell.m
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/20.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "TwoCell.h"
@interface TwoCell()

@property (nonatomic, strong) UIView *backView;

@end
@implementation TwoCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=Color(@"F5F5F5");
        
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 5;
        self.backView=backView;
        [self.contentView addSubview:backView];
        
        UILabel *moneyLab = [UILabel new];
        moneyLab.font =  [UIFont boldSystemFontOfSize:24];
        moneyLab.textColor = Color(@"#999999");
        self.moneyLab = moneyLab;
        [backView addSubview:moneyLab];
        
        UILabel *onLab = [UILabel new];
        onLab.textColor = Color(@"#999999");
        onLab.font =  [UIFont boldSystemFontOfSize:13];
        self.onLab.text = @"OFF";
        self.onLab = onLab;
        [backView addSubview:onLab];
        
        UILabel *timeLab = [UILabel new];
        timeLab.textColor = Color(@"#999999");
        timeLab.font =font(10);
        self.timeLab = timeLab;
        [backView addSubview:timeLab];
        
        UIView *line = [UIView new];
        self.line = line;
        line.backgroundColor = Color(@"#CDDDDA");
        [backView addSubview:line];
        
        UILabel *contentLab = [UILabel new];
        contentLab.textColor = Color(@"#999999");
        self.contentLab = contentLab;
        contentLab.font =  [UIFont boldSystemFontOfSize:14];
        [backView addSubview:contentLab];
        
        UILabel *codeLab = [UILabel new];
        codeLab.textColor = Color(@"#999999");
        codeLab.font =font(12);
        codeLab.backgroundColor = Color(@"f5f5f5");
        codeLab.textAlignment = NSTextAlignmentCenter;
        self.codeLab = codeLab;
        [backView addSubview:codeLab];
        
        UIButton *copyBtn = [UIButton new];
        self.CopyBtn = copyBtn;
        [copyBtn setTitle:@"COPY" forState:0];
        [copyBtn setTitleColor:[UIColor whiteColor] forState:0];
        [copyBtn setBackgroundColor:Color(@"#CCCCCC")];
        copyBtn.titleLabel.font =font(12);
        [backView addSubview:copyBtn];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"coupon-applied"];
        self.flagImagV=imageView;
        [backView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(backView.mas_right).offset(0);
            make.top.equalTo(backView).offset(0);
            make.height.offset(60);
            make.width.offset(60);
        }];
        
       
     
        self.timeLab.text = @"2019.06.03-2019.09.03";
        self.contentLab.text = @"For a purchase over $500";
        self.codeLab.text = @"1236548afajfhah";
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.top.offset(12);
        make.right.offset(-12);
        make.bottom.offset(-6);
    }];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.backView).offset(27);
        make.top.equalTo(self.backView).offset(26);
    }];
    [self.onLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.moneyLab.mas_right).offset(2);
        make.bottom.equalTo(self.moneyLab.mas_bottom).offset(-3);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.backView).offset(10);
        make.top.equalTo(self.moneyLab.mas_bottom).offset(10);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.timeLab.mas_right).offset(10);
        make.centerY.equalTo(self.backView);
        make.height.offset(64);
        make.width.offset(1);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.line).offset(20);
        make.top.equalTo(self.backView).offset(25);
    }];
    [self.codeLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.contentLab);
        make.top.equalTo(self.contentLab.mas_bottom).offset(13);
        make.height.offset(30);
        make.width.offset(130);
    }];
    [self.CopyBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.codeLab.mas_right).offset(0);
        make.height.offset(30);
        make.width.offset(70);
        make.centerY.equalTo(self.codeLab);
    }];
}

- (void)setData:(NSDictionary *)data{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
