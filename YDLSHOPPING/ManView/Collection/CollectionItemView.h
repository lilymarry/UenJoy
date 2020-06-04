//
//  CollectionItemView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionItemView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIImageView *goodImaV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *ItemBtn;



@end

NS_ASSUME_NONNULL_END
