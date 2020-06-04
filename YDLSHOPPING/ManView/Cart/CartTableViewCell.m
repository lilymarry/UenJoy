//
//  CartTableViewCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CartTableViewCell.h"

//16进制RGB的颜色转换
#define LZColorFromHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CartTableViewCell ()

@end
@implementation CartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
    }
    return self;
}
#pragma mark - 布局主视图
-(void)setupMainView {
    
    //选中按钮
  self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [  self.selectBtn setImage:[UIImage imageNamed:@"wish_sel_nor"] forState:UIControlStateNormal];
    [  self.selectBtn setImage:[UIImage imageNamed:@"wish_sel_pre"] forState:UIControlStateSelected];
  
    [self addSubview:  self.selectBtn];
    [  self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.centerY.equalTo(self.contentView);
        make.height.offset(30);
        make.width.offset(30);
    }];

    
    //照片背景
    UIView *imageBgView = [[UIView alloc]init];
    imageBgView.backgroundColor = LZColorFromHex(0xF3F3F3);
    [self addSubview:imageBgView];
    [imageBgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(  self.selectBtn.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
        make.height.offset(90);
        make.width.offset(90);
    }];
    
    //显示照片
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"default_pic_1"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageBgView addSubview:imageView];
    self.lzImageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(0);
        make.top.offset(0);
        make.height.offset(90);
        make.width.offset(90);
    }];
    
    //商品名
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.font =font(15);
    nameLabel.numberOfLines=2;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(imageBgView.mas_right).offset(12);
        make.top.equalTo(imageView.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
    }];
    self.nameLabel = nameLabel;
    
    //尺寸
    UILabel* sizeLabel = [[UILabel alloc]init];
    sizeLabel.textColor = Color(@"#999999");
    sizeLabel.font =font(12);
    [self addSubview:sizeLabel];
    self.sizeLabel = sizeLabel;
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(nameLabel.mas_left).offset(0);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
    }];
    
    //价格
    UILabel* priceLabel = [[UILabel alloc]init];
    priceLabel.font = [UIFont boldSystemFontOfSize:15];

    priceLabel.textColor = Color(@"#ED5151");
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(nameLabel.mas_left).offset(0);
        make.bottom.equalTo(imageView.mas_bottom).offset(0);
    }];
    
    
    //数量加按钮
   self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [self.addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [self addSubview: self.addBtn];
    [ self.addBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.bottom.equalTo(imageView.mas_bottom).offset(0);
        make.height.offset(23);
        make.width.offset(25);
    }];
    
    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"1";
    numberLabel.font = font(14);

    [self addSubview:numberLabel];
    self.numberLabel = numberLabel;
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo( self.addBtn.mas_left).offset(-13);
        make.centerY.equalTo( self.addBtn);
    }];
    
    //数量减按钮
   self.cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [self.cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [self addSubview:self.cutBtn];
    [self.cutBtn mas_makeConstraints:^(MASConstraintMaker *make){
      make.right.equalTo(numberLabel.mas_left).offset(-13);
        make.centerY.equalTo(self.addBtn);
        make.height.offset(23);
        make.width.offset(25);
    }];
    
    
    UIView* line = [[UIView alloc]init];
    line.backgroundColor=[UIColor groupTableViewBackgroundColor] ;

       [self addSubview:line];
  
       [line mas_makeConstraints:^(MASConstraintMaker *make){
           make.right.equalTo( self.contentView).offset(-5);
             make.left.equalTo( self.contentView).offset(5);
           make.bottom.equalTo( self.contentView).offset(-1);
           make.height.offset(1);
       }];
}



@end
