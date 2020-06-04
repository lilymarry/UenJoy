//
//  RAMReasonView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RAMReasonView.h"
#import "RAMReasonModel.h"
@interface RAMReasonView ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isShow;
}
@property (nonatomic ,strong)NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *reasonLab;





@end

@implementation RAMReasonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"RAMReasonView" owner:self options:nil];
        [self addSubview:_thisView];
    
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [self getData];
        
        self.tableView.hidden=YES;
        isShow=NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancellPress:(id)sender {
    
    [self removeFromSuperview];
}

- (void)getData{
    RAMReasonModel *model=[[RAMReasonModel alloc]init];
    [model RAMReasonModelSuccess:^(NSDictionary *data) {
        if ([data[@"code"] intValue]==200) {
            self.data=[NSArray arrayWithArray:data[@"data"]];
            [self.tableView reloadData];
        }
        else
        {
            
        }
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return   self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = font(14);
        cell.contentView.backgroundColor=Color(@"#EEEEEE");
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
 
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.reasonLab.text= self.data[indexPath.row];
    isShow=NO;
    self.tableView.hidden=YES;
    

}


- (IBAction)selectReasonPress:(id)sender {
    isShow=!isShow;
    self.tableView.hidden=!isShow;
}

- (IBAction)submitPress:(id)sender {
    if ([self.reasonLab.text isEqualToString:@"Input reason in here" ]) {
       [MBProgressHUD showSuccess:@"Reason is NUll" toView:self];
        return;

    }
    self.block(  self.reasonLab.text);
    [self removeFromSuperview];
}


@end
