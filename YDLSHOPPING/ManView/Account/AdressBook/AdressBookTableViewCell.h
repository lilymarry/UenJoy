//
//  AdressBookTableViewCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AdressBookTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *addressLab;
@property (nonatomic, strong)UIView *line;

@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *defaultBtn;


+(instancetype)cellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
