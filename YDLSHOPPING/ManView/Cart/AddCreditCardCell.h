//
//  AddCreditCardCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddCreditCardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *cartNum_tf;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;

@property (strong, nonatomic) IBOutlet UITextField *cvv_tf;
@property (weak, nonatomic) IBOutlet UISwitch *BillingAddressSwitch;
@property (strong, nonatomic) IBOutlet UILabel *contry_lab;
@property (weak, nonatomic) IBOutlet UIButton *contryBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;


@property (strong, nonatomic) IBOutlet UITextField *address1_tf;
@property (strong, nonatomic) IBOutlet UITextField *address2_tf;
@property (strong, nonatomic) IBOutlet UITextField *code_tf;
@property (strong, nonatomic) IBOutlet UITextField *city_tf;
@property (strong, nonatomic) IBOutlet UILabel *state_lab;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@property (strong, nonatomic) IBOutlet UITextField *email_tf;
@property (strong, nonatomic) IBOutlet UITextField *phone_tf;
@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (strong, nonatomic)NSString *type;

@end

NS_ASSUME_NONNULL_END
