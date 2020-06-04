//
//  ContactInforCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactInforCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *contactTf;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@end

NS_ASSUME_NONNULL_END
