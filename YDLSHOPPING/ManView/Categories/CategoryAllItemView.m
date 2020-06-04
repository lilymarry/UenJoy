//
//  CategoryAllItemView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CategoryAllItemView.h"
#import "CategoryItemHeadView.h"
#import "CategoryItemCell.h"

@interface CategoryAllItemView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    BOOL isfilter;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UITextField *lowPriceTf;
@property (weak, nonatomic) IBOutlet UITextField *highPriceTf;

@property (nonatomic ,assign)BOOL isHaveDian;


@end

@implementation CategoryAllItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CategoryAllItemView" owner:self options:nil];
        [self addSubview:_thisView];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.dataSource=self;
        _mTable.delegate=self;
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryItemCell class]) bundle:nil] forCellReuseIdentifier:@"CategoryItemCell"];
        
        [_mTable registerClass:[CategoryItemHeadView class] forHeaderFooterViewReuseIdentifier:@"CategoryItemHeadView"];
        
        _lowPriceTf.delegate=self;
        _highPriceTf.delegate=self;
  
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)loadView{
      _lowPriceTf.text=_priceData[@"lowPrice"];
      _highPriceTf.text=_priceData[@"highPrice"];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
    
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            //您的输入格式不正确
            [self showMBProgressHUDOnKeyBoard:@"Your input format is incorrect"];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            
            //最多只能输入一个小数点
            [self showMBProgressHUDOnKeyBoard:@"At most one decimal point can be entered"];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    
                    [self showMBProgressHUDOnKeyBoard:@"The second character needs to be a decimal point"];
                    
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    
                    [self showMBProgressHUDOnKeyBoard:@"The second character needs to be a decimal point"];
                    
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    
                    [self showMBProgressHUDOnKeyBoard:@"Up to two decimal places after decimal point"];
                    //小数点后最多有两位小数
                    
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}
-(void)showMBProgressHUDOnKeyBoard:(NSString *)title
{
    
    UIWindow *view = [[[UIApplication sharedApplication] delegate] window];
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (id windowView in windows) {
        NSString *viewName = NSStringFromClass([windowView class]);
        if ([@"UIRemoteKeyboardWindow" isEqualToString:viewName]) {
            view = windowView;
            break;
        }
    }
    
    [MBProgressHUD showSuccess:title toView:view];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger result = 0;
    result = self.dataArr.count;
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    if ([self.dataArr[section][@"isExtend"] isEqualToString:@"1"]) {
        result = [self.dataArr[section][@"content"] count];
    } else {
        result = 0;
    }
    return result;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CategoryItemHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CategoryItemHeadView"];
    [headerView configWithData:self.dataArr[section]];
    headerView.titleButton.tag=section;
    [headerView.titleButton addTarget:self action:@selector(isExptentPress:) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryItemCell"];
    NSDictionary *dic= self.dataArr[indexPath.section][@"content"][indexPath.row];
    if ([dic[@"isSelect"] isEqualToString:@"0"]) {
        cell.flag_imag.image=[UIImage imageNamed:@"btn-choose-no"];
         cell.titleLab.textColor=Color(@"666666");
    }
    else
    {
        cell.flag_imag.image=[UIImage imageNamed:@"btn-choose"];
         cell.titleLab.textColor=Color(@"FA6600");
        
    }
    if ( [self.dataArr[indexPath.section][@"isExtend"] isEqualToString:@"1"]) {
        cell.contentView.backgroundColor=Color(@"F5F5F5");
    }
    else
    {
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    cell.titleLab.text=dic[@"name"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_lowPriceTf resignFirstResponder];
    [_highPriceTf resignFirstResponder];
    
   // BOOL issult=[self cherkCellIsSelectInSestion:indexPath.section selectTag:indexPath.row];
    
 //   if (!issult) {
         [self  setNotSelectArrInSestion:indexPath.section];
 //   }

     NSDictionary *dic= self.dataArr[indexPath.section][@"content"][indexPath.row];
    NSMutableDictionary *newDic=[dic mutableCopy];
    
    if ([newDic[@"isSelect"] isEqualToString:@"0"]) {  newDic[@"isSelect"]=@"1";
    }
    else
    {
        newDic[@"isSelect"]=@"0";
        
    }
    
    NSDictionary *d1=self.dataArr[indexPath.section];
    NSMutableArray *arr=[NSMutableArray arrayWithArray:d1[@"content"]];
    [arr replaceObjectAtIndex:indexPath.row withObject:newDic];
    NSMutableDictionary *saveDic=[NSMutableDictionary dictionary];
    [saveDic setValue:d1[@"isExtend"] forKey:@"isExtend"];
    [saveDic setValue:arr forKey:@"content"];
    [saveDic setValue:d1[@"name"] forKey:@"name"];
    [self.dataArr replaceObjectAtIndex:indexPath.section withObject:saveDic];
    
    [_mTable reloadData];
}
-(void)isExptentPress:(ReviewOneBtn *)btn{
    [_lowPriceTf resignFirstResponder];
    [_highPriceTf resignFirstResponder];
    
    [self setNotSelectArrInSestion:btn.tag];
    NSDictionary *dic =self.dataArr[btn.tag];
    NSMutableDictionary *newDic=[dic mutableCopy];

    if ([newDic[@"isExtend"] isEqualToString:@"1"]) {
        newDic[@"isExtend"]=@"0";
    }
    else
    {
         newDic[@"isExtend"]=@"1";
    }
    [self.dataArr replaceObjectAtIndex:btn.tag withObject:newDic];

    [self.mTable reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
  
    
}
- (void)setNotSelectArrInSestion:(NSInteger)section{
    NSMutableArray *arr= [self.dataArr[section][@"content"] mutableCopy];
    for (NSMutableDictionary *dic in arr) {
        if ([dic[@"isSelect"] isEqualToString:@"1"]) {
            dic[@"isSelect"]=@"0";
        }
      
    }
    self.dataArr[section][@"content"]=arr;
}
-(BOOL)cherkCellIsSelectInSestion:(NSInteger)section selectTag:(NSInteger)tag
{
    NSArray *arr= self.dataArr[section][@"content"] ;
    
    for (int i=0; i<arr.count; i++) {
        NSDictionary *dic =arr[i];
        if ([dic[@"isSelect"] isEqualToString:@"1"]) {
            if (i==tag) {
                return YES;
            }
        }
    }
    return NO;
    
}
- (IBAction)savePress:(id)sender {
    [_lowPriceTf resignFirstResponder];
    [_highPriceTf resignFirstResponder];
    
   NSDictionary *data=[self getSelectDataInArr];
  
    if (_lowPriceTf.text.length>0&&  _highPriceTf.text.length==0) {
         [self showMBProgressHUDOnKeyBoard:@"Please enter the highest price"];
        return;
    }
    
    if (_lowPriceTf.text.length==0&&  _highPriceTf.text.length>0) {
         [self showMBProgressHUDOnKeyBoard:@"Please enter the lowest price"];
        return;
    }
    
    if (_lowPriceTf.text.doubleValue> _highPriceTf.text.doubleValue>0) {
         [self showMBProgressHUDOnKeyBoard:@"The lowest price cannot be higher than the highest price"];
        return;
    }
    NSMutableDictionary *price=[NSMutableDictionary dictionary];
    [price setValue:_lowPriceTf.text forKey:@"lowPrice"];
    [price setValue:_highPriceTf.text forKey:@"highPrice"];
    
    if ([_lowPriceTf.text doubleValue]>0&&[_highPriceTf.text doubleValue]>0) {
        isfilter=YES;
    }
    self.setBlock(self.dataArr, data,price,isfilter);
    
    [self removeFromSuperview];
    
    
    
}
- (IBAction)resetPress:(id)sender {
    [_lowPriceTf resignFirstResponder];
    [_highPriceTf resignFirstResponder];
    
    self.resetBlock();
    [self removeFromSuperview];
}


- (NSDictionary *)getSelectDataInArr{
    NSMutableArray *dataArr=[NSMutableArray array];
    for (NSDictionary *dic in self.dataArr ) {
        if ([dic[@"isExtend"] isEqualToString:@"1"]) {
            NSMutableDictionary *d1=[NSMutableDictionary dictionary];
            for (NSDictionary *dict in dic[@"content"]) {
                if ([dict[@"isSelect"] isEqualToString:@"1"]) {
                    [d1 setValue:dict[@"name"] forKey:@"content"];
                    break;
                }
            }
             [d1 setValue:dic[@"name"] forKey:@"name"];
            
            [dataArr addObject:d1];
        }
    }
    NSMutableDictionary *data=[NSMutableDictionary dictionary];
    if (dataArr.count>0) {
     
        for (NSDictionary *dic in dataArr) {
            if ([dic[@"content"] length]>0) {
                   isfilter=YES;
            }
            if (![dic[@"content"] isEqualToString:@"ALL"]) {
                [data setValue:dic[@"content"] forKey: dic[@"name"]];
            }
        }
    }
    return data;
 
}
- (IBAction)cancelPress:(id)sender {
    [self savePress:nil];
}


@end
