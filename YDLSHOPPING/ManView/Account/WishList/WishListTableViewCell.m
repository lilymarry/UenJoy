//
//  OrderListTableViewCell
//  YDLSHOPPING
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "WishListTableViewCell.h"
#define picWidth 90
#define picHeight 90
#define colCount 2

@interface WishListTableViewCell()


@end


@implementation WishListTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview{
    static NSString *ID=@"OrderListCell";
    WishListTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[WishListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *image = [UIImageView new];
        self.image = image;
        [self.contentView addSubview:image];
        
        UILabel *money = [UILabel new];
        money.textColor = Color(@"#333333");
        money.font =  [UIFont boldSystemFontOfSize:16];

        self.money = money;
        [self.contentView addSubview:money];
        
        UILabel *oldmoney = [UILabel new];
        oldmoney.textColor = Color(@"#999999");
        oldmoney.font =font(12);
        self.oldmoney = oldmoney;
        [self.contentView addSubview:oldmoney];
        
        UILabel *title = [UILabel new];
        title.textColor = Color(@"#333333");
        title.numberOfLines=2;
        title.font =font(16);
        self.title = title;
        [self.contentView addSubview:title];
        
        UILabel *content = [UILabel new];
        content.textColor = Color(@"#666666");
        content.font = font(12);
        self.content = content;
        [self.contentView addSubview:content];
        
        UIButton *wish_icImage = [UIButton new];
        self.wish_icImage = wish_icImage;
        [wish_icImage setImage:[UIImage imageNamed:@"wish_ic_cart"] forState:UIControlStateNormal];
      //  wish_icImage.image = [UIImage imageNamed:@"wish_ic_cart"];
        [self.contentView addSubview:wish_icImage];
        
        UIImageView *flag = [UIImageView new];
        flag.image = [UIImage imageNamed:@"wish_sel_nor"];
        self.flag_image = flag;
        [self.contentView addSubview:flag];
        
        UIView *line = [UIView new];
        line.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.lineView = line;
        [self.contentView addSubview:line];
        
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];

    [self.flag_image mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(5);
        make.centerY.equalTo(self.contentView);
        make.height.offset(15);
        make.width.offset(15);
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(25);
        make.centerY.equalTo(self.contentView);
        make.height.offset(110);
        make.width.offset(110);
    }];
    
    [self.money mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.image.mas_right).offset(21);
        make.top.equalTo(self.contentView).offset(14);
    }];
    
    [self.oldmoney mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.money.mas_right).offset(15);
        make.centerY.equalTo(self.money);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.image.mas_right).offset(21);
        make.top.equalTo(self.money.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.image.mas_right).offset(21);
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    //购物车
    [self.wish_icImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        make.height.offset(30);
        make.width.offset(30);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(0);
         make.left.offset(0);
       make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.offset(1);
       
    }];
}




@end
