//
//  PaymentCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payPalImagView;
@property (weak, nonatomic) IBOutlet UIButton *payPalBtn;
@property (weak, nonatomic) IBOutlet UIImageView *CreditcardImageView;
@property (weak, nonatomic) IBOutlet UIButton *CreditcardBtn;
@property (weak, nonatomic) IBOutlet UITextField *CreditcardTf;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UITextField *dateTf;
@property (weak, nonatomic) IBOutlet UITextField *cvvTf;

@end

NS_ASSUME_NONNULL_END
