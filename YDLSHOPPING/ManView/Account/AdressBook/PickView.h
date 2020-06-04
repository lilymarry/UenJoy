//
//  PickView.h
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PickViewDelegate <NSObject>
-(void)selectRow:(NSDictionary *)data type:(NSString * )type;
@end
@interface PickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic)id<PickViewDelegate>delegate;
- (void)loadPick:(NSArray *)data andType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
