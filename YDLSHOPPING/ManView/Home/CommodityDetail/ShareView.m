//
//  ShareView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil];
        [self addSubview:_thisView];
       
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancelPress:(id)sender {
    [self removeFromSuperview];
}

@end
