//
//  HelpAndContact.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HelpAndContact.h"
#import "FeedbackViewController.h"
#import "PolicyDetail.h"
@interface HelpAndContact ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr;
};
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHHH;

@end

@implementation HelpAndContact

- (void)viewDidLoad {
    [super viewDidLoad];
   adjustsScrollViewInsets_NO(self.table, self);
    _topHHH.constant=isIOS10 ?64:0;
 
    self.title=@"Help & Contact";
    arr=[NSArray arrayWithObjects:@"Contact us",
    @"Shipping Policy",@"Return Policy",@"Privacy Policy",@"Terms of Service", nil];
    self.table.tableFooterView=[[UIView alloc]init];
   
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font=font(15);
    cell.textLabel.text=arr[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        FeedbackViewController *back=[[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:back animated:YES];
    }
    else
    {
       
        PolicyDetail *detail=[[PolicyDetail alloc]init];
        detail.title=arr[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
