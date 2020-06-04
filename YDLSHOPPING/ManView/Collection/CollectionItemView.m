//
//  CollectionItemView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CollectionItemView.h"

@interface CollectionItemView ()

@end

@implementation CollectionItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CollectionItemView" owner:self options:nil];
        [self addSubview:_thisView];
  
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
