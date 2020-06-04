//
//  ProductTopCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ProductTopCell.h"
@interface ProductTopCell()
@property (nonatomic, strong) UIImageView *descImageView;
@property (nonatomic, strong) UILabel *content;
@end
@implementation ProductTopCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        UIImageView *image = [UIImageView new];
        self.descImageView = image;
        [self.contentView addSubview:image];
        
        UILabel *content = [UILabel new];
        content.textColor = Color(@"#333333");
        content.numberOfLines = 0;
        content.font = font(12);
        self.content = content;
        [self.contentView addSubview:content];
        
        [self.descImageView mas_makeConstraints:^(MASConstraintMaker *make){
             make.width.offset(ScreenWidth);
            make.top.equalTo(self.contentView).offset(5);
            make.height.offset(ScreenWidth);
            
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.descImageView.mas_bottom).offset(8);
         
        }];
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.content.mas_bottom).offset(1);
            make.width.offset(ScreenWidth);
            make.height.offset(1);
            make.bottom.offset(1);
            
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
-(void)setProductModel:(ProductDetailModel *)productModel
{
     NSString* encodedString =[productModel.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    
      [self.descImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
      self.content.text=productModel.image_imgdesc;

    
    CGSize baseSize = CGSizeMake(ScreenWidth-24, CGFLOAT_MAX);
    
    CGSize labelsize1  =[HelpCommon stringSystemSize: productModel.image_imgdesc size:baseSize fontSize:12];
    
    self.content.text=productModel.image_imgdesc;
    [self.content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.descImageView.mas_bottom).offset(5);
        make.height.offset(labelsize1.height+5);
    }];
}

@end
