//
//  ReviewsCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ReviewsCell.h"
@interface ReviewsCell()
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *rateLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong)UIView *starview;
@property (nonatomic, strong)UIView *imageview;
@end
@implementation ReviewsCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *image = [UIImageView new];
        image.image=[UIImage imageNamed:@"profile-User Head"];
        self.headImage = image;
        [self.contentView addSubview:image];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.contentView).offset(15);
            make.height.offset(35);
            make.width.offset(35);
        }];
        
        UILabel *name = [UILabel new];
        name.textColor = Color(@"#342C2A");
        name.font = font(14);
        self.nameLab = name;
        self.nameLab.text=@"By LI Yann";
        [self.contentView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.headImage.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.headImage.mas_top);
            make.height.offset(20);
        }];
        
        UILabel *time = [UILabel new];
        time.textColor = Color(@"#999999");
        time.font = font(13);
        self.timeLab = time;
        self.timeLab.text=@"Mar 15 / 2019";
        [self.contentView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.nameLab.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
             make.top.equalTo(name.mas_bottom).offset(5);
             make.height.offset(20);
        }];
      
        UIView *starview=[UIView new];
        starview.backgroundColor=[UIColor whiteColor];
        self.starview=starview;
          [self.contentView addSubview:starview];
         [starview mas_makeConstraints:^(MASConstraintMaker *make){
          make.left.equalTo(self.headImage.mas_right).offset(15);
           make.top.equalTo(self.timeLab.mas_bottom).offset(10);
            make.height.offset(20);
           make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
     
        UILabel *title = [UILabel new];
        title.textColor = Color(@"#666666");
        title.font =font(11);
        title.numberOfLines = 0;
        self.title = title;
       
        [self.contentView addSubview:title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.headImage.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(starview.mas_bottom).offset(10);
            
            
        }];
        
        UIView *imageiew=[UIView new];
        imageiew.backgroundColor=[UIColor whiteColor];
        self.imageview=imageiew;
        [self.contentView addSubview:imageiew];
        [imageiew mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.headImage.mas_right).offset(15);
            make.top.equalTo(self.title.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imageiew.mas_bottom).offset(10);
            make.width.offset(ScreenWidth);
            make.height.offset(1);
            make.bottom.offset(5);

        }];
        
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ProductDetailModel *)model{
    
    
    self.nameLab.text=model.name;

   
    self.dateLab.text= [HelpCommon timeWithTimeIntervalString:model.review_date andFormatter:@"YYYY-MM-dd"];

    for (UIView *view in self.starview.subviews ) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < 5; i++){
        
        NSInteger x = 5;
        UIImageView * imageView = [[UIImageView alloc]init];
        
        if ( i<=[model.rate_star intValue]-1) {
            imageView.image = [UIImage imageNamed:@"reviewed-heart-solid"];
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"reviewed-heart-empty"];
        }
        
        [self.starview addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.offset(0);
            make.width.offset(18);
            make.height.offset(15);
            make.left.equalTo(self.timeLab.mas_left).offset((x + 18)*i );
        }];
    }

    
    CGSize baseSize = CGSizeMake(ScreenWidth-24, CGFLOAT_MAX);
    
    CGSize labelsize1  = [HelpCommon stringSystemSize:model.review_content size:baseSize fontSize:11];
    
    //设置行间距
    NSMutableParagraphStyle *rightLabelPragraphStyle = [NSMutableParagraphStyle new];
    rightLabelPragraphStyle.lineSpacing = 10 - (self.title.font.lineHeight - self.title.font.pointSize);
    NSMutableDictionary *RightLabelAttribute = [NSMutableDictionary dictionary];
    [RightLabelAttribute setObject:rightLabelPragraphStyle forKey:NSParagraphStyleAttributeName];
    self.title.attributedText = [[NSAttributedString alloc] initWithString:model.review_content attributes:RightLabelAttribute];
    
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.starview.mas_bottom).offset(10);
        
      make.height.offset(labelsize1.height+10);
    }];
    for (UIView *view in self.imageview.subviews ) {
        [view removeFromSuperview];
    }
    
    
    NSArray *arr= [model.review_imgs componentsSeparatedByString:@","];
  
    int margin = (ScreenWidth-(80*3)-65-10)/2;//间隙
    if (margin>30) {
        margin=30;
    }
    int width = 80;//格子的宽
    int height = 80;//格子的高
  
    int offest=0;
  
    for (int i = 0; i <arr.count; i++) {
        
        int row=i/3;
        int col=i%3;
          UIImageView *imageV=[[UIImageView alloc]init];
      NSString* encodedString =[arr[i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];

        imageV.backgroundColor = [UIColor redColor];
        [self.imageview addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(col*(width+margin));
         make.top.offset(row*(height+margin));
            make.height.offset(height);
            make.width.offset(width);
        }];
       
    }
    int row=(int)arr.count/3;
    offest=(height+margin)*(row+1)+10;
    [self.imageview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.title.mas_bottom).offset(10);
        
        make.height.offset(offest);
    }];
    
    [self layoutIfNeeded];
}

@end
