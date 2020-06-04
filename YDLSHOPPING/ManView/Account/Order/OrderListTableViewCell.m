//
//  OrderListTableViewCell
//  YDLSHOPPING
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OrderListTableViewCell.h"
#define picWidth 90
#define picHeight 90
#define colCount 2

@interface OrderListTableViewCell()

@property (nonatomic, strong)UILabel *Order;
@property (nonatomic, strong)UILabel *Status;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, strong)UILabel *color;
@property (nonatomic, strong)UILabel *price;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UILabel *total;

@property (nonatomic, strong) UILabel *numLab;
@end
@implementation OrderListTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview{
    static NSString *ID=@"OrderListCell";
    OrderListTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[OrderListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UILabel *Order = [UILabel new];
        self.Order = Order;
        Order.textColor = Color(@"#999999");
        Order.font = font(12);
        [self.contentView addSubview:Order];
        
        UILabel *Status = [UILabel new];
        Status.textColor = Color(@"#333333");
        Status.font = font(12);
        self.Status = Status;
        [self.contentView addSubview:Status];
        
        UIView *line1 = [UIView new];
        self.line1 = line1;
        line1.backgroundColor = Color(@"#CDDDDA");
        [self.contentView addSubview:line1];
        
        UIImageView *image = [UIImageView new];
        self.image = image;
        [self.contentView addSubview:image];
        
        UILabel *lab = [UILabel new];
        lab.textColor = Color(@"#333333");
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font = font(12);
        self.numLab = lab;
        [self.contentView addSubview:lab];
        
        UILabel *content = [UILabel new];
        content.textColor = Color(@"#333333");
        content.font = font(15);
        content.numberOfLines = 2;
        self.content = content;
        [self.contentView addSubview:content];
        
        UILabel *color = [UILabel new];
        color.textColor = Color(@"#999999");
        color.font =font(12);
        self.color = color;
        [self.contentView addSubview:color];
        
        UILabel *price = [UILabel new];
        price.textColor = Color(@"#333333");
        price.font =font(12);
        self.price = price;
        [self.contentView addSubview:price];
        
        UIView *line2 = [UIView new];
        self.line2 = line2;
        line2.backgroundColor = Color(@"#CDDDDA");
        [self.contentView addSubview:line2];
        
        UIButton *cancelBtn = [UIButton new];
        self.CancelBtn = cancelBtn;
        cancelBtn.titleLabel.font=font(15);
        [cancelBtn setTitle:@"Cancel" forState:0];
     //   [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setBackgroundColor:Color(@"#EEEEEE")];
      
        cancelBtn.titleLabel.textColor = Color(@"#333333");
        [cancelBtn setTitleColor:[UIColor blackColor] forState:0];
        [self.contentView addSubview:cancelBtn];
        
        UIButton *payBtn = [UIButton new];
        self.PayBtn = payBtn;
        [payBtn setTitle:@"Pay Now" forState:0];
        [payBtn setBackgroundColor:Color(@"#F6AA00")];
        payBtn.titleLabel.font =font(15);
        [payBtn setTitleColor:[UIColor whiteColor] forState:0];
        [self.contentView addSubview:payBtn];
        
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.Order mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(11);
        make.top.offset(18);
    }];
    [self.Status mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-11);
        make.top.offset(18);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(10);
        make.top.equalTo(self.Order.mas_bottom).offset(19);
        make.right.offset(-10);
        make.height.offset(1);
    }];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(11);
        make.top.equalTo(self.line1.mas_bottom).offset(15);
        make.height.offset(60);
        make.width.offset(60);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make){
        //  make.left.offset(0);
          make.top.equalTo(self.image.mas_bottom).offset(10);
          make.height.offset(20);
          make.centerX.equalTo(self.image.mas_centerX);
      }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.image.mas_right).offset(15);
        make.top.equalTo(self.line1.mas_bottom).offset(15);
        make.right.offset(-15);
    }];
    [self.color mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.image.mas_right).offset(15);
        make.centerY.equalTo(self.image.mas_bottom).offset(-7);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-11);
        make.top.equalTo(self.color.mas_bottom).offset(20);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(10);
        make.top.equalTo(self.price.mas_bottom).offset(10);
        make.right.offset(-10);
        make.height.offset(1);
    }];
    [self.PayBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-10);
        make.top.equalTo(self.line2).offset(15);
        make.height.offset(30);
        make.width.offset(82);
    }];
    
    [self.CancelBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.PayBtn.mas_left).offset(-10);
        make.top.equalTo(self.line2).offset(15);
        make.height.offset(30);
        make.width.offset(82);
    }];
}

- (void)setDataSoucreDic:(OrderListModel *)dataSoucreDic{
  
    self.Order.text = [NSString stringWithFormat:@"Order:%@",dataSoucreDic.increment_id];
    NSArray *arr=dataSoucreDic.item_products;
    if (arr.count>0) {
        OrderListModel * model=arr[0];
        
        NSString* encodedString =[model.pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码

        [ self.image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
        
        self.content.text = model.name;
        self.color.text = [NSString stringWithFormat:@"productWeight:%@",model.weight];
       
    }


    self.numLab.text=[NSString stringWithFormat:@"%@ items",dataSoucreDic.items_count];
     self.Status.text = [NSString stringWithFormat:@"Status:%@",dataSoucreDic.order_status];
    
    NSString *str1 = @"TOTAL: ";
    NSString *str2 = [NSString stringWithFormat:@"%@%@",dataSoucreDic.currency_symbol,dataSoucreDic.grand_total];
    
     NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    [attriStr addAttribute:NSFontAttributeName value: [UIFont boldSystemFontOfSize:14] range:NSMakeRange(str1.length,str2.length)];

  
  self.price.attributedText = attriStr;
    
}

- (void)setFlag:(NSInteger)flag{
    if (flag == 0){
        
    }else if (flag == 1 || flag == 2){
        self.PayBtn.hidden = YES;
        [self.CancelBtn mas_updateConstraints:^(MASConstraintMaker *make){
            make.right.offset(-10);
        }];
    }else{
        self.PayBtn.hidden = YES;
        self.CancelBtn.hidden = YES;
        self.line2.hidden = YES;
    }
}

//- (void)setStatusStr:(NSString *)StatusStr{
//    self.Status.text = [NSString stringWithFormat:@"Status:%@",StatusStr];
//}

@end
