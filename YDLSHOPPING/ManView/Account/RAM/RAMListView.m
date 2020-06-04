//
//  RAMListView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RAMListView.h"
#import "RAMOneCell.h"
#import "RAMReasonView.h"
#import "ReviewOneCell.h"
#import "ReviewTwoCell.h"
#import "AddReviewsViewController.h"
#import "TwoCell.h"
@interface RAMListView ()
<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSString * type;//文字类型
    NSString * subTypeStr;
    NSArray * thisArr;
}
@end

@implementation RAMListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"RAMListView" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerClass:[RAMOneCell class] forCellReuseIdentifier:NSStringFromClass([RAMOneCell class])];
        
        
        [_mTable registerClass:[ReviewOneCell class] forCellReuseIdentifier:NSStringFromClass([ReviewOneCell class])];
        
        [_mTable registerClass:[ReviewTwoCell class] forCellReuseIdentifier:NSStringFromClass([ReviewTwoCell class])];
        [_mTable registerClass:[TwoCell class] forCellReuseIdentifier:NSStringFromClass([TwoCell class])];
        
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.backgroundColor = Color(@"f5f5f5");
        
        _mTable.emptyDataSetSource = self;
        _mTable.emptyDataSetDelegate = self;
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr andType:(NSString *)thisType subType:(NSString *)subType{
    type = thisType;
    thisArr = arr;
    subTypeStr=subType;
    [_mTable reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if ([type isEqualToString:@"RAM"]||[type isEqualToString:@"discount"]) {
        count= 1;
    }
    else if ([type isEqualToString:@"review"])
    {
        count= thisArr.count;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if ([type isEqualToString:@"RAM"]||[type isEqualToString:@"discount"]) {
        count= thisArr.count;
    }
    else if ([type isEqualToString:@"review"])
    {
        ReviewLlistMdel *model = thisArr[section];
        count = model.products.count;
    }
    return count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([type isEqualToString:@"RAM"]) {
        
        
        RAMOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RAMOneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        RAMListModel *model=thisArr[indexPath.row];
        if (model.products.count>0) {
            RAMListModel *subModel=model.products[0];
            cell.title.text=subModel.name;
            NSString* encodedString =[model.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
            [cell.image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
            cell.money.text =[NSString stringWithFormat:@"TOTAL:$%@",subModel.price];
            
        }
        if([subTypeStr isEqualToString:@"1"]){
            
            [ cell.AddBtn setTitle:@"After sale" forState:0];
            [ cell.AddBtn setTitleColor:[UIColor whiteColor] forState:0];
            
            [ cell.AddBtn setBackgroundColor:Color(@"#F6AA00")];
            cell.AddBtn.tag=indexPath.row;
            [cell.AddBtn addTarget:self action:@selector(addPress:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else if ([subTypeStr isEqualToString:@"2"]){
            
            
            [ cell.AddBtn setTitle:@"Submit Application" forState:0];
            [ cell.AddBtn setTitleColor:Color(@"#159082") forState:0];
            
            
        }else {
            [ cell.AddBtn setTitle:@"Complete the refund" forState:0];
            [ cell.AddBtn setTitleColor:Color(@"#999999") forState:0];
            
        }
        
        return cell;
    }
    
    else  if ([type isEqualToString:@"discount"]) {
        
        
        TwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CouponListModel *model=thisArr[indexPath.row];
        cell.moneyLab.text=[NSString stringWithFormat:@"$%@",model.discount];
        
        cell.timeLab.text=[NSString stringWithFormat:@"%@-%@",[HelpCommon timeWithTimeIntervalString:model.created_at andFormatter:@"YYYY-MM-dd"],[HelpCommon timeWithTimeIntervalString:model.expiration_date andFormatter:@"YYYY-MM-dd"]];
        cell.codeLab.text=model.coupon_code;
        
          cell.contentLab.text = model.type_tittle;
        
        if([subTypeStr isEqualToString:@"1"]){
            
            cell.flagImagV.hidden=YES;
            cell.moneyLab.textColor=Color(@"#ED5151");
            cell.CopyBtn.backgroundColor=Color(@"#ED5151");
            cell.CopyBtn.enabled=YES;
            cell.contentLab.textColor=Color(@"#333333");
            cell.onLab.textColor=Color(@"#ED5151");
            cell.CopyBtn.tag=indexPath.row;
            [cell.CopyBtn addTarget:self action:@selector(copyBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else {
            cell.flagImagV.hidden=NO;
            cell.moneyLab.textColor=Color(@"#999999");
            cell.CopyBtn.backgroundColor=Color(@"#CCCCCC");
            cell.CopyBtn.enabled=NO;
            cell.contentLab.textColor=Color(@"#999999");
            cell.onLab.textColor=Color(@"#999999");
            if ([subTypeStr isEqualToString:@"2"]) {
                
                cell.flagImagV.image=[UIImage imageNamed:@"coupon-applied"];
            }
            
            else
            {
                cell.flagImagV.image=[UIImage imageNamed:@"coupon-expired"];
            }
            
        }
        
        return cell;
    }
    
    else
    {
        if([subTypeStr isEqualToString:@"1"]){
            ReviewOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReviewOneCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ReviewLlistMdel *model = thisArr[indexPath.section];
            ReviewLlistMdel *subModel = model.products[indexPath.row];
            NSString* encodedString =[subModel.pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
            [ cell.image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
            cell.title.text=subModel.name;
            cell.money.text=[NSString stringWithFormat:@"TOTAL:%@%.2f",model.currency_symbol,[subModel.price doubleValue]];;
            cell.AddBtn.indexPath=indexPath;
            [cell.AddBtn addTarget:self action:@selector(addReViewPress:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else {
            ReviewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReviewTwoCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ReviewLlistMdel *model = thisArr[indexPath.section];
            ReviewLlistMdel *subModel = model.products[indexPath.row];
            cell.codeSymbol=model.currency_symbol;
            cell.data = subModel;
            
            if ([subModel.review.status intValue]==10) {
                cell.reviseReview.indexPath=indexPath;
                [cell.reviseReview addTarget:self action:@selector(repitReview:) forControlEvents:UIControlEventTouchUpInside];
                cell.reviseReview.enabled=YES;
                   [cell.reviseReview setBackgroundColor:Color(@"#F6AA00")];
                
            }
            else
            {
                   [cell.reviseReview setBackgroundColor:Color(@"#CCCCCC")];
                cell.reviseReview.enabled=NO;
                  
            }
            
            return cell;
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([type isEqualToString:@"RAM"]) {
        if ([subTypeStr isEqualToString:@"2"]||[subTypeStr isEqualToString:@"3"]){
            
            RAMListModel *model=thisArr[indexPath.row];
            self.cellBlock(model, subTypeStr);
            
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([type isEqualToString:@"discount"]) {
        return 120;
        
    }
    else
    {
        return UITableViewAutomaticDimension;
    }
}
- (void)addPress:(UIButton *)but{
    
    if ([subTypeStr isEqualToString:@"1"]){
        
        RAMListModel *model=thisArr[but.tag];
        RAMReasonView *reason=[[RAMReasonView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        reason.block = ^(NSString * _Nonnull reason) {
            self.btnBlock(model, reason);
            
        };
        [self.window addSubview:reason];
        
    }
    
}
- (void)addReViewPress:(ReviewOneBtn *)but{
    
    ReviewLlistMdel *model = thisArr[but.indexPath.section];
    ReviewLlistMdel *subModel = model.products[but.indexPath.row];
    self.reviewBtnBlock(subModel, subTypeStr,model.currency_symbol);
    
    
}
- (void)repitReview:(ReviewOneBtn *)but{
    
    ReviewLlistMdel *model = thisArr[but.indexPath.section];
    ReviewLlistMdel *subModel = model.products[but.indexPath.row];
    self.reviewBtnBlock(subModel, subTypeStr,model.currency_symbol);
    
    
}

- (void)copyBtnPress:(UIButton *)btn{
    CouponListModel *model=thisArr[btn.tag];
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = model.coupon_code;
    [MBProgressHUD showSuccess:@"Replicating Success" toView:self.superview];
    
}

#pragma mark -空数据页代理
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"aftersale-img-empty"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"It is still empty";
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
        NSForegroundColorAttributeName:Color(@"#666666")
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100.0;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

@end
