//
//  itemCollectionView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "itemCollectionView.h"

@interface itemCollectionView ()

@end

@implementation itemCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"itemCollectionView" owner:self options:nil];
        [self addSubview:_thisView];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
