//
//  SelectAddressNoteCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectAddressNoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *introduceView;
@property (weak, nonatomic) IBOutlet UITextView *desc_txt;
@property (weak, nonatomic) IBOutlet UILabel *desc_lab;

@end

NS_ASSUME_NONNULL_END
