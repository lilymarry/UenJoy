//
//  AlertMessageView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertMessageView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;


@end

NS_ASSUME_NONNULL_END
