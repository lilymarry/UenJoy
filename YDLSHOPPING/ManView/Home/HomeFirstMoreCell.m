//
//  HomeFirstMoreCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HomeFirstMoreCell.h"

@implementation HomeFirstMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _moreView.layer.borderWidth = 5;
    _moreView.layer.borderColor =Color(@"666666").CGColor;
}

@end
