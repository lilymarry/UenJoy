//
//  AddCreditCardCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "AddCreditCardCell.h"
@interface AddCreditCardCell ()
{
    NSString *typeStr;
}
@end
@implementation AddCreditCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    _BillingAddressSwitch.onTintColor= Color(@"#666666");

    _BillingAddressSwitch.thumbTintColor=Color(@"#666666");
    
   
}
- (void)setType:(NSString *)type
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)butPress:(id)sender {
    
    
}

@end
