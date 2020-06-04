//
//  SelectAddressTopCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SelectAddressTopCell.h"

@implementation SelectAddressTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTitleNoSelect:(NSString * )index
{
    
    NSArray *arr=[NSArray arrayWithObjects:_firstNameTitleLab,_lastNameTitleLab,_contryTitleLab,_address1TitleLab,_codeTitleLab,_cityTitleLab,_stateTitleLab,_emailTitleLab,_phoneTitleLab, nil];
    if (index.length>0) {
        UILabel *lab=(UILabel *) arr[[index intValue]];
        lab.textColor=[UIColor redColor];
    }
    
}
@end
