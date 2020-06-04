//
//  SearchNavView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SearchNavView.h"

@interface SearchNavView ()

@end

@implementation SearchNavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height-10)];
          backView.backgroundColor=Color(@"F5F5F5");
      
        [self addSubview:backView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, backView.frame.size.height/2-7.5, 15, 15)];

        imageView.image=[UIImage imageNamed:@"nav_ic_search_nor"];
        [backView addSubview:imageView];
        
        UITextField *content_tf=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 0, backView.frame.size.width-25, backView.frame.size.height)];
        content_tf.textColor=Color(@"999999");
        content_tf.borderStyle=UITextBorderStyleNone;
        content_tf.font=font(13);
        content_tf.placeholder=@"Dressing table";
        
        content_tf.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        self.content_tf=content_tf;
        [backView addSubview:content_tf];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
  
}


@end
