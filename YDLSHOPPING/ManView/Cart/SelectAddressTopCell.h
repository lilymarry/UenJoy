//
//  SelectAddressTopCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectAddressTopCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *firstName_tf;
@property (strong, nonatomic) IBOutlet UITextField *lastName_tf;
@property (strong, nonatomic) IBOutlet UILabel *contry_lab;
@property (strong, nonatomic) IBOutlet UITextField *address1_tf;
@property (strong, nonatomic) IBOutlet UITextField *address2_tf;
@property (strong, nonatomic) IBOutlet UITextField *code_tf;
@property (strong, nonatomic) IBOutlet UITextField *city_tf;
@property (strong, nonatomic) IBOutlet UILabel *state_lab;
@property (strong, nonatomic) IBOutlet UITextField *email_tf;
@property (strong, nonatomic) IBOutlet UITextField *phone_tf;

@property (weak, nonatomic) IBOutlet UIButton *contryBtn;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIView *CountryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CountryViewHH;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHH;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *firstNameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *lastNameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *contryTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *address1TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *codeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *cityTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *emailTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleLab;

- (void)setTitleNoSelect:(NSString * )index;

@end

NS_ASSUME_NONNULL_END
