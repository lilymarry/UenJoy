//
//  RowNumDetailCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddAddressCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UITextField *numTf;
@property (weak, nonatomic) IBOutlet UIImageView *flagImaView;


@end

NS_ASSUME_NONNULL_END
