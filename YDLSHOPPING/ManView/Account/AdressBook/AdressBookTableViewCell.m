//
//  AdressBookTableViewCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AdressBookTableViewCell.h"
#define picWidth 90
#define picHeight 90
#define colCount 2

@interface AdressBookTableViewCell()


@end


@implementation AdressBookTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview{
    static NSString *ID=@"AddressBookCell";
    AdressBookTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[AdressBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLab = [UILabel new];
        nameLab.textColor = Color(@"#333333");
        nameLab.font = font(15);
        self.nameLab = nameLab;
        [self.contentView addSubview:nameLab];
        
        UILabel *addressLab = [UILabel new];
        addressLab.textColor = Color(@"#333333");
        addressLab.font = font(13);
        addressLab.numberOfLines = 0;
        self.addressLab = addressLab;
        [self.contentView addSubview:addressLab];
        
        UIView *line = [UIView new];
        self.line = line;
        line.backgroundColor = Color(@"#CDDDDA");
        [self.contentView addSubview:line];
        

        
         self.defaultBtn = [UIButton new];
        [self.defaultBtn  setTitle:@"Default" forState:0];
    
        [self.defaultBtn setTitleColor:Color(@"333333") forState:0];
        self.defaultBtn .titleLabel.font = font(13);
        [self.defaultBtn  setImage:[UIImage imageNamed:@"addressbook-default"] forState:0];
     
        [self.defaultBtn  setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
        [self.contentView addSubview:self.defaultBtn ];
        
        
        UIButton *deleBtn = [UIButton new];
        [deleBtn setTitle:@"Delete" forState:0];
        self.deleBtn = deleBtn;
        [deleBtn setTitleColor:Color(@"#999999") forState:0];
        deleBtn.titleLabel.font = font(13);
        [deleBtn setImage:[UIImage imageNamed:@"addressbook-delete"] forState:0];
        [deleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
        [self.contentView addSubview:deleBtn];
        
        UIButton *editBtn = [UIButton new];
        [editBtn setTitle:@"Edit" forState:0];
        self.editBtn = editBtn;
        [editBtn setTitleColor:Color(@"#999999") forState:0];
        editBtn.titleLabel.font = font(13);
        [editBtn setImage:[UIImage imageNamed:@"addressbook-edit"] forState:0];
        [editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        [self.contentView addSubview:editBtn];
        
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.nameLab.mas_bottom).offset(15);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.addressLab.mas_bottom).offset(20);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.offset(1);
    }];
    

    
    [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.equalTo(self.contentView).offset(13);
                make.top.equalTo(self.line).offset(15);
                make.height.offset(40);
                make.width.offset(80);
            }];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.centerY.equalTo(self.defaultBtn);
        make.width.offset(60);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.deleBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.deleBtn);
        make.width.offset(60);
    }];
    
}




-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
