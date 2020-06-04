//
//  itemCollectionView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewOneBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface itemCollectionView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *imgeView1;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet ReviewOneBtn *btn1;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *imgeView2;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet ReviewOneBtn *btn2;

@end

NS_ASSUME_NONNULL_END
