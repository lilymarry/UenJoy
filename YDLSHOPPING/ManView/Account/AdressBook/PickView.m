//
//  PickView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "PickView.h"

@interface PickView ()
{
    NSString *typeStr;
}
@end

@implementation PickView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"PickView" owner:self options:nil];
        [self addSubview:_thisView];
        
        self.pickView.dataSource=self;
        self.pickView.delegate=self;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)loadPick:(NSArray *)data andType:(NSString *)type
{
    self.dataArr = [NSArray arrayWithArray:data];
    typeStr=type;
    [self.pickView reloadAllComponents];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArr.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dic= [self.dataArr objectAtIndex:row];
    return dic[@"value"];
}

- (IBAction)casellView:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)surePress:(id)sender {
  
    if (self.dataArr.count>0) {
          [self removeFromSuperview];
        int  row=  (int) [_pickView selectedRowInComponent:0];
        
        NSDictionary *dic= [self.dataArr objectAtIndex:row];
        
        if ([self.delegate respondsToSelector:@selector(selectRow:type:)])
        {
            [self.delegate selectRow:dic type:typeStr];
        }
    }
    
  
}

@end
