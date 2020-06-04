//
//  SelectProductAttributeView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectProductNumBlock)(NSString *num, NSString * typestr);
typedef void(^SelectProductCancelBlock)(void);
@interface SelectProductAttributeView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIImageView *goodImaView;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UITextField *num_tf;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, copy) SelectProductNumBlock numBlock ;
@property (nonatomic, copy) SelectProductCancelBlock cancelBlock ;
@property (nonatomic, strong) NSString * num ;
@property (nonatomic, strong) NSString * type;
@end

NS_ASSUME_NONNULL_END
