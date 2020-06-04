//
//  OneCell.m
//  OnlyViewControllerLink
//
//  Created by 朱伟阁 on 2019/7/20.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "ReviewTwoCell.h"


@interface ReviewTwoCell()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIButton *AddBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) UILabel *rateLab;
@property (nonatomic, strong) UILabel *dateLab;
@end
@implementation ReviewTwoCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *image = [UIImageView new];
        self.image = image;
        [self.contentView addSubview:image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.contentView).offset(15);
            make.height.offset(60);
            make.width.offset(60);
        }];
        
        UILabel *title = [UILabel new];
        title.textColor = Color(@"#333333");
        title.font =font(14);
        title.numberOfLines = 0;
        self.title = title;
        [self.contentView addSubview:title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.image.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.image.mas_top);
        }];
        
        UILabel *money = [UILabel new];
        money.textColor = Color(@"#333333");
        money.font =  [UIFont boldSystemFontOfSize:12];
        self.money = money;
        [self.contentView addSubview:money];
        [self.money mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.title);
            make.top.equalTo(self.title.mas_bottom);
         //   make.bottom.equalTo(self.image.mas_bottom);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = Color(@"#CDDDDA");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(money.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.offset(1);
        }];
        
        UILabel *content = [UILabel new];
        self.content = content;
        content.textColor = Color(@"333333");
        content.font = font(12);
        content.numberOfLines = 0;
        [self.contentView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(line.mas_bottom).offset(8);
        }];
        
        UIScrollView *scrollView = [UIScrollView new];
        self.scrollView = scrollView;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(content.mas_bottom).offset(17);
            make.height.offset(110);
            make.width.offset(ScreenWidth);
        }];
        
        UILabel *rateLab = [UILabel new];
        rateLab.text = @"Rate";
        self.rateLab = rateLab;
        rateLab.font =font(15);
        rateLab.textColor = Color(@"#333333");
        [self.contentView addSubview:rateLab];
        [rateLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(scrollView.mas_bottom).offset(16);
        }];
        
        UILabel *dateLab = [UILabel new];
        dateLab.textColor = Color(@"#666666");
        dateLab.font =font(12);
        self.dateLab = dateLab;
        [self.contentView addSubview:dateLab];
        [dateLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(scrollView.mas_bottom).offset(18);
        }];
        
        ReviewOneBtn *reviseReview = [ReviewOneBtn new];
        self.reviseReview=reviseReview;
        [reviseReview setTitle:@"Revise review" forState:0];
        reviseReview.titleLabel.font = font(12);
        [reviseReview setTitleColor:[UIColor whiteColor] forState:0];
        [reviseReview setBackgroundColor:Color(@"#CCCCCC")];
        [self.contentView addSubview:reviseReview];
        [reviseReview mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(rateLab.mas_bottom).offset(15);
            make.height.offset(30*AUTOLAYOUT_WIDTH_SCALE);
            make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
        
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)setData:(ReviewLlistMdel *)data{
    
    NSString* encodedString =[data.pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    
   [self.image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    
    self.title.text=data.name;
    CGSize baseSize = CGSizeMake(ScreenWidth-100, CGFLOAT_MAX);
   
    CGSize labelsize  =  [HelpCommon stringSystemSize: data.name size:baseSize  fontSize:14];
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
       make.height.offset(labelsize.height+10);
    }];

    self.money.text=[NSString stringWithFormat:@"TOTAL:%@%.2f",_codeSymbol,[data.price doubleValue]];
 
    
    self.dateLab.text =   [HelpCommon timeWithTimeIntervalString:data.review.review_date andFormatter: @"yyyy-MM-dd"];
    if (data.review.review_content.length>0) {
         //设置行间距
           NSMutableParagraphStyle *rightLabelPragraphStyle = [NSMutableParagraphStyle new];
           rightLabelPragraphStyle.lineSpacing = 10 - (self.content.font.lineHeight - self.content.font.pointSize);
           NSMutableDictionary *RightLabelAttribute = [NSMutableDictionary dictionary];
           [RightLabelAttribute setObject:rightLabelPragraphStyle forKey:NSParagraphStyleAttributeName];

           self.content.attributedText = [[NSAttributedString alloc] initWithString:data.review.review_content attributes:RightLabelAttribute];
    }
   
    
    NSArray * arr= data.review.review_imgs;
   // NSArray *arr =model[@"gallery"];

    if (arr.count == 0){
        self.scrollView.hidden = YES;
        [self.rateLab mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.content.mas_bottom).offset(16);
        }];
    }else{
        self.scrollView.contentSize = CGSizeMake(arr.count*(110+12)+12, 110);
        for (int i = 0; i < arr.count; i++){
            NSInteger x = 12;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((x + 110)*i + x, 0, 110, 110)];
          // NSDictionary *   subModel=arr[i];
             NSString* encodedString =[arr[i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
             [imageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
            
            [self.scrollView addSubview:imageView];
        }
    }
 
        for (int i = 0; i < 5; i++){
            NSInteger x = 10;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((x + 18)*i + 80, 0, 18, 15)];
            if ( i<=[data.review.rate_star intValue]-1) {
                  imageView.image = [UIImage imageNamed:@"reviewed-heart-solid"];
            }
             else
             {
                 imageView.image = [UIImage imageNamed:@"reviewed-heart-empty"];
             }
          
            
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make){
                make.centerY.equalTo(self.rateLab);
                make.left.equalTo(self.rateLab.mas_right).offset((x + 18)*i + 35);
            }];
        }

       [self layoutIfNeeded];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
