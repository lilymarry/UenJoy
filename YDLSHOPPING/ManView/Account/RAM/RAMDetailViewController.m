//
//  RAMDetailViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "RAMDetailViewController.h"
#import "NOPayCancelModel.h"
@interface RAMDetailViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UIView *shipView;
@property (nonatomic, strong) NSMutableArray *flowSortArray;//流程数组
@end

@implementation RAMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      self.view.backgroundColor = Color(@"F5F5F5");
    self.title=@"After sale Details";
    _flowSortArray = [[NSMutableArray alloc] init];
    [self setMainView];
}

- (void)setMainView{
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 0, 0)];
    mainScrollView.showsVerticalScrollIndicator = NO;
       adjustsScrollViewInsets_NO(mainScrollView, self);
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(0);
        if (self.flag==1) {
              make.height.offset(ScreenHeight-55);
        }
        else
        {
              make.height.offset(ScreenHeight);
        }
      
        make.width.offset(ScreenWidth-24);
        make.left.offset(12);
    }];
    
    UIView *topView = [UIView new];
    self.topView = topView;
    [mainScrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.offset(75);
        make.top.offset(Is_iPhoneX? 84 : 64);
        make.width.mas_equalTo(mainScrollView);
    }];
    [self setTop];
    
    UIView *firstView = [UIView new];
    firstView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.width.offset(ScreenWidth-24);
        make.height.offset(80);
    }];
    

    
    UILabel *pendingLabel = [UILabel new];
    pendingLabel.textColor = Color(@"#333333");
    pendingLabel.font =  [UIFont boldSystemFontOfSize:18];
    pendingLabel.text =  self.flag == 1? @"Submit application" : @"Complete the refund";
    [firstView addSubview:pendingLabel];
    [pendingLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(firstView);
        make.centerY.equalTo(firstView).offset(-3);
    }];
    
    UILabel *subLabel = [UILabel new];
      subLabel.textColor = Color(@"#333333");
    subLabel.font =font(11);
      subLabel.text = @"You have already submitted your application, please be patient";
    subLabel.textAlignment=NSTextAlignmentCenter;
    
      [firstView addSubview:subLabel];
      [subLabel mas_makeConstraints:^(MASConstraintMaker *make){
          make.top.equalTo(pendingLabel.mas_bottom).offset(5);
         make.centerX.equalTo(firstView);
          
      }];
    
    UIImageView *lineImage = [UIImageView new];
    lineImage.image = [UIImage imageNamed:@"order_line"];
    [firstView addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(firstView.mas_bottom).offset(-1);
        make.centerX.equalTo(firstView);
        make.width.offset(ScreenWidth-24);
        make.height.offset(15);
    }];
    
    UIView *secondView = [UIView new];
    secondView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(firstView.mas_bottom).offset(0);
        make.width.offset(ScreenWidth-24);
        make.height.offset(34);
    }];
    
    UILabel *OrderLabel = [UILabel new];
    OrderLabel.textColor = Color(@"#999999");
    OrderLabel.font =font(12);
   OrderLabel.text =[NSString stringWithFormat:@"Order:%@",self.list.increment_id];
    [secondView addSubview:OrderLabel];
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(16);
        make.centerY.equalTo(secondView).offset(-2);
    }];
    
    UILabel *TimeLabel = [UILabel new];
    TimeLabel.textColor = Color(@"#999999");
    TimeLabel.font = font(12);
     NSString *time =  [HelpCommon timeWithTimeIntervalString:self.list.created_at andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    TimeLabel.text = [NSString stringWithFormat:@"Time:%@",time];
    [secondView addSubview:TimeLabel];
    [TimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-16);
        make.centerY.equalTo(secondView).offset(-2);
    }];
    
    for (int i = 0; i < self.list.products.count; i++) {
        int x = 90*i;
        
        UIView *contentView = [UIView new];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:contentView];
        
        UIView *line = [UIView new];
        line.backgroundColor = Color(@"#EEEEEE");
        [contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(11);
            make.top.offset(0);
            make.right.equalTo(contentView.mas_right).offset(-11);
            make.height.offset(1);
        }];
        
        
        UIImageView *image = [UIImageView new];
        
        RAMListModel *detail =self.list.products[i];
        NSString* encodedString =[detail.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        
        [image sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
        
        [contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(11);
            make.centerY.equalTo(contentView);
            make.height.offset(60);
            make.width.offset(60);
        }];
        
        UILabel *content = [UILabel new];
        content.textColor = Color(@"#333333");
        content.font = font(15);
        content.text =  detail.name;
        [contentView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(image.mas_right).offset(15);
            make.top.equalTo(image);
            make.right.offset(-15);
        }];
        
        UILabel *color = [UILabel new];
        color.textColor = Color(@"#999999");
        color.font =font(12);
        //  color.text = [NSString stringWithFormat:@"Color:%@",self.dataSource[i][@"color"]];
        [contentView addSubview:color];
        [color mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(image.mas_right).offset(15);
            make.top.equalTo(content.mas_bottom).offset(5);
        }];
        
        UILabel *price = [UILabel new];
        price.textColor = Color(@"#333333");
        price.font = [UIFont boldSystemFontOfSize:15];
        price.text =[NSString stringWithFormat:@"%@%@",self.list.currency_symbol,detail.row_total] ;
        [contentView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(image.mas_right).offset(15);
            make.bottom.equalTo(image.mas_bottom);
        }];
        
        UILabel *number = [UILabel new];
        number.textColor = Color(@"#333333");
        number.font =font(12);
        number.text = [NSString stringWithFormat:@"X%d",[detail.qty intValue]];
        [contentView addSubview:number];
        [number mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(contentView.mas_right).offset(-13);
            make.top.equalTo(content.mas_bottom).offset(5);
        }];
        
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(secondView.mas_bottom).offset(x);
            make.height.offset(90);
            make.width.offset(ScreenWidth-24);
        }];
    }
    
    NSArray *itemArr = @[@"Total commodity price", @"Discount", @"Shipping"];
    NSString *Shipping;
    if ([self.list.shipping_total doubleValue]==0) {
        Shipping=@"Free";
    }
    else
    {
        Shipping=[NSString stringWithFormat:@"%@%.2f",self.list.currency_symbol,[self.list.shipping_total doubleValue]];
    }
    
    
    NSArray *detailArr = @[ [NSString stringWithFormat:@"%@%.2f",self.list.currency_symbol,[self.list.subtotal doubleValue]],    [NSString stringWithFormat:@"%@%.2f",self.list.currency_symbol,[self.list.subtotal_with_discount doubleValue]], Shipping];
    if (self.flag != 0){
        itemArr = @[@"Payment Method",@"Total commodity price", @"Discount", @"Shipping"];
        detailArr = @[self.list.payment_method,[NSString stringWithFormat:@"%@%.2f",self.list.currency_symbol,[self.list.subtotal doubleValue]],  [NSString stringWithFormat:@"%@%.2f",self.list.currency_symbol,[self.list.subtotal_with_discount doubleValue]], Shipping];
    }
    for (int i = 0; i < itemArr.count; i++) {
        int x = 50*i;
        
        UIView *itemView = [UIView new];
        self.itemView = itemView;
        itemView.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:itemView];
        
        UIView *line = [UIView new];
        line.backgroundColor = Color(@"#EEEEEE");
        [itemView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(11);
            make.top.offset(0);
            make.right.equalTo(itemView.mas_right).offset(-11);
            make.height.offset(1);
        }];
        
        UILabel *totalLabel = [UILabel new];
        totalLabel.textColor = Color(@"#333333");
        totalLabel.font = font(14);
        totalLabel.text = itemArr[i];
        [itemView addSubview:totalLabel];
        [totalLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(10);
            make.centerY.equalTo(itemView);
        }];
        
        UILabel *detailLabel = [UILabel new];
        detailLabel.textColor = Color(@"#333333");
        detailLabel.font =  [UIFont boldSystemFontOfSize:14];
        if (i == itemArr.count-1 || (self.flag != 0 && i ==0)){
            //   detailLabel.font = font(14);
            detailLabel.textColor = Color(@"#999999");
        }
            detailLabel.text = [NSString stringWithFormat:@"%@%@",self.list.currency_symbol,detailArr[i]];
        detailLabel.text = [NSString stringWithFormat:@"%@",detailArr[i]];
        [itemView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.offset(-10);
            make.centerY.equalTo(itemView);
        }];
        
        if (i == itemArr.count-1){
            UIView *line1 = [UIView new];
            line1.backgroundColor = Color(@"#EEEEEE");
            [itemView addSubview:line1];
            [line1 mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.offset(11);
                make.bottom.equalTo(itemView);
                make.right.equalTo(itemView.mas_right).offset(-11);
                make.height.offset(1);
            }];
        }
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView.mas_bottom).offset(x);
            make.height.offset(50);
            make.width.offset(ScreenWidth-24);
        }];
    }
    
    UIView *orderTotalView = [UIView new];
    orderTotalView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:orderTotalView];
    
    UILabel *orderTotalLabel = [UILabel new];
    orderTotalLabel.textColor = Color(@"#333333");
    orderTotalLabel.font =font(14);
    [orderTotalView addSubview:orderTotalLabel];
    [orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-10);
        make.centerY.equalTo(orderTotalView).offset(-5);
    }];
    
    NSString *str1 = @"Order Total: ";
    NSString *str2 =[NSString stringWithFormat:@"%@%.2f",self.list.currency_symbol,[self.list.grand_total doubleValue]];
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    [noteStr addAttribute:NSFontAttributeName value: [UIFont boldSystemFontOfSize:14] range:NSMakeRange(str1.length,str2.length)];
    [noteStr addAttribute:NSForegroundColorAttributeName value:Color(@"#F6AA00") range:NSMakeRange(str1.length,str2.length)];
    orderTotalLabel.attributedText = noteStr;
    
    
    [orderTotalView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.itemView.mas_bottom);
        make.height.offset(65);
        make.width.offset(ScreenWidth-24);
    }];
    
    UIView *shipView = [UIView new];
    self.shipView = shipView;
    shipView.backgroundColor =[UIColor whiteColor];
    [mainScrollView addSubview:shipView];
    [shipView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orderTotalView.mas_bottom).offset(10);
        make.height.offset(120);
        make.width.offset(ScreenWidth-24);
    }];
    
    UILabel *shipLabel = [UILabel new];
    shipLabel.textColor = Color(@"#333333");
    shipLabel.font =  [UIFont boldSystemFontOfSize:18];
    shipLabel.text = @"Ship To";
    [shipView addSubview:shipLabel];
    [shipLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(11);
        make.top.offset(14);
    }];
    
    UILabel *shipContentLabel = [UILabel new];
    shipContentLabel.textColor = Color(@"#333333");
    shipContentLabel.font =  font(14);
    shipContentLabel.numberOfLines = 0;
    shipContentLabel.text =[NSString stringWithFormat:@"%@%@  %@",self.list.customer_address_state_name,self.list.customer_address_country_name,self.list.customer_telephone];
    [shipView addSubview:shipContentLabel];
    [shipContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(shipView);
        make.top.equalTo(shipLabel.mas_bottom).offset(14);
        make.width.offset(ScreenWidth-48);
    }];
    
    UILabel *shipNumberLabel = [UILabel new];
    shipNumberLabel.textColor = Color(@"#333333");
    shipNumberLabel.font =  font(14);
    shipNumberLabel.numberOfLines = 0;
    shipNumberLabel.text = [NSString stringWithFormat:@"%@%@  %@",self.list.customer_lastname,self.list.customer_firstname,self.list.customer_telephone];
    [shipView addSubview:shipNumberLabel];
    [shipNumberLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.bottom.equalTo(shipView.mas_bottom).offset(-16);
    }];
    
    
  
    UIView *trackingView = [UIView new];
    trackingView.backgroundColor =[UIColor whiteColor];
    [mainScrollView addSubview:trackingView];
    
    
    UILabel *trackingLabel = [UILabel new];
    trackingLabel.textColor = Color(@"#333333");
    //trackingLabel.backgroundColor=[UIColor yellowColor];
    trackingLabel.font =  [UIFont boldSystemFontOfSize:18];
    trackingLabel.text = @"Refund Progress";
    [trackingView addSubview:trackingLabel];
    [trackingLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(11);
        make.top.offset(14);
    }];
    
    
    UIView *trackingFlowView;
    CGFloat sumHeight=0;
    NSArray *arr=self.list.returnmsg;

    
    NSMutableArray *timeArr = [[NSMutableArray alloc]init];
       // 时间戳-对象字典，将对象和其对应的时间戳字符串存入字典（哈希表）
       NSMutableDictionary *dateKeyArr = [[NSMutableDictionary alloc]init];
       
       // 2.时间戳取出，并格式化处理
       for(  RAMListModel *model in arr) {
           // 时间戳转成时间对象用于排序
           NSDate  *date = [NSDate dateWithTimeIntervalSince1970:[model.created_at integerValue]];
           [timeArr addObject:date];
           // 时间戳转成时间戳字符串作为key,制作哈希表
           NSNumber *dataNum = [NSNumber numberWithLongLong:[model.created_at integerValue]];
           NSString *datekey = [dataNum stringValue];
           [dateKeyArr setObject:model forKey:datekey];
       }
       
       // 3.将时间NSDate数组排序
       NSArray *orderedDateArray = [timeArr sortedArrayUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
           // 降序排序，最近的时间靠前
           return [date2 compare:date1];
       }];
       
       // 4.根据排序好的时间数组对号入座将对象按时间排序
       // 临时数组，保存排序后的对象数组
       NSMutableArray *sortedAccounts = [[NSMutableArray alloc]init];
       NSDate *datekey = [[NSDate alloc]init];
       for (int i = 0; i<orderedDateArray.count; i++) {
           datekey = orderedDateArray[i];
           // 日期对象转换成时间戳字符串key
           NSString *datekeys = [NSString stringWithFormat:@"%lld", (long long)[datekey timeIntervalSince1970]];
           // 根据时间戳字符串key取对应的对象（哈希表）
           [sortedAccounts addObject:[dateKeyArr objectForKey:datekeys]];
       }
    // 5.更新排序后的对象数组[ARC中不需要手动释放排序前的数组]
       _flowSortArray = sortedAccounts;
    
    for (int i=0; i<_flowSortArray.count; i++) {
        
        
        CGSize baseSize = CGSizeMake(ScreenWidth-80, CGFLOAT_MAX);
      
        RAMListModel *model=_flowSortArray[i];
        CGSize labelsize1  =    [HelpCommon stringSystemSize: model.return_desc size:baseSize fontSize:12];
        
        CGFloat height=  labelsize1.height+10+10+50;
     
        if (i==_flowSortArray.count-1) {
           sumHeight=  height+[self getTitleLeft:i];
        }
       
        
        trackingFlowView=[UIView new];
        [trackingView addSubview:trackingFlowView];
        [trackingFlowView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(0);
            make.top.equalTo(trackingLabel.mas_bottom).offset([self getTitleLeft:i]);
            
            make.right.offset(0);
            make.height.offset(height);
        }];
        
        
        UIView *toplineView=[UIView new];
        toplineView.backgroundColor=Color(@"#CCCCCC");
     
        [trackingFlowView addSubview:toplineView];
        if (i==0) {
            toplineView.hidden=YES;
        }
        else
        {
            toplineView.hidden=NO;
        }
        [toplineView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(21);
            make.top.offset(0);
            make.height.offset(15);
            make.width.offset(1);
        }];
        
        
        UIImageView *flowImage=[UIImageView new];
        if (i==0) {
            flowImage.image=[UIImage imageNamed:@"wish_sel_pre"];
        }else
        {
            flowImage.image=[UIImage imageNamed:@"wish_sel_nor"];
            
        }
        
        [trackingFlowView addSubview:flowImage];
        [flowImage mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(toplineView.mas_centerX);
            make.top.equalTo(toplineView).offset(18);
            make.height.offset(18);
            make.width.offset(18);
        }];
        
        UIView *bottomlineView=[UIView new];
        bottomlineView.backgroundColor=Color(@"#CCCCCC");
        [trackingFlowView addSubview:bottomlineView];
        if (i==_flowSortArray.count-1) {
            bottomlineView.hidden=YES;
        }
        else
        {
            bottomlineView.hidden=NO;
        }
        [bottomlineView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(flowImage.mas_centerX);
            make.top.equalTo(flowImage).offset(21);
            make.bottom.offset(0);
            make.width.offset(1);
        }];
        UILabel *timeLab=[UILabel new];
        timeLab.textColor = Color(@"#999999");
        timeLab.font =  font(12);
        timeLab.text =  [HelpCommon timeWithTimeIntervalString:model.created_at andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        [trackingFlowView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(flowImage.mas_right).offset(20);
            make.right.offset(12);
            make.centerY.equalTo(flowImage.mas_centerY);
        }];
        UILabel *contentLab=[UILabel new];
        contentLab.textColor = Color(@"#333333");
        contentLab.font =  font(12);
        contentLab.text =model.return_desc;
        contentLab.numberOfLines=0;
        
        
        
        [trackingFlowView addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(flowImage.mas_right).offset(20);
            make.right.offset(12);
            make.top.equalTo(timeLab.mas_bottom).offset(5);
            make.bottom.equalTo(trackingFlowView.mas_bottom).offset(0);
        }];
        
    }
    
    [trackingView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(shipView.mas_bottom).offset(10);
        if (_flowSortArray.count>0) {
             make.bottom.equalTo(trackingFlowView.mas_bottom).offset(0);
        }
        else
        {
           make.bottom.equalTo(trackingLabel.mas_bottom).offset(0);
        }
       
        make.width.offset(ScreenWidth-24);
    }];
    
    
    if (self.flag ==1){
        UIButton *cancelBtn = [UIButton new];
                   [cancelBtn setBackgroundColor:Color(@"#F6AA00")];
                   [cancelBtn setTitle:@"Cancel Application" forState:0];
                   [cancelBtn addTarget:self action:@selector(CancelPress:) forControlEvents:UIControlEventTouchUpInside];
                   cancelBtn.titleLabel.font =  font(18);
               [cancelBtn setTitleColor:Color(@"#FFFFFF") forState:0];
                   [self.view addSubview:cancelBtn];
                   [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make){
                  
                       make.height.offset(55);
                      make.bottom.offset(Is_iPhoneX?-34:0); make.width.offset(ScreenWidth);
                   }];
       
       }

    mainScrollView.contentSize = CGSizeMake(ScreenWidth-24, 680 + self.list.products.count*90+sumHeight+100   );

    
}
- (void)setTop{
    NSArray *titleArr = @[@"Submit application",@"Complete the refund"];
    for(int i = 0; i < titleArr.count; i++){
        int x = ((ScreenWidth-24)/2)*i;
        UIView *view = [UIView new];
       
    
        [self.topView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(x);
            make.top.offset(0);
            make.height.offset(75);
            make.width.offset((ScreenWidth-24)/2);
        }];

        UIView *circle1 = [UIView new];
        circle1.backgroundColor = self.flag == i+1? Color(@"#333333") : Color(@"#EEEEEE");
        circle1.layer.masksToBounds = YES;
        circle1.layer.cornerRadius = 12.5;
        [view addSubview:circle1];
        [circle1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.offset(15);
            make.centerX.equalTo(view);
            make.height.offset(25);
            make.width.offset(25);
        }];
        
       UILabel *label1 = [UILabel new];
                     label1.textColor = Color(@"#ffffff");
                     label1.font = [UIFont fontWithName:@"SanFranciscoDisplay-Semibold" size:12];
                     label1.text = [NSString stringWithFormat:@"%d", 1 + i];
                     [circle1 addSubview:label1];
                     [label1 mas_makeConstraints:^(MASConstraintMaker *make){
                         make.center.equalTo(circle1);
                     }];
        
        UILabel *PendingPayment = [UILabel new];
        PendingPayment.textColor = self.flag == i+1? Color(@"#333333") : Color(@"#999999");
        PendingPayment.font = font(11);
        PendingPayment.text = titleArr[i];
        [view addSubview:PendingPayment];
        [PendingPayment mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(circle1);
           make.top.equalTo(circle1.mas_bottom).offset(10);
        }];
        
        if (i != 1){
            UIView *line = [UIView new];
            line.backgroundColor =Color(@"#999999");
            [view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.equalTo(circle1.mas_right).offset(19);
                make.centerY.equalTo(circle1);
                make.height.offset(1);
                make.width.offset((ScreenWidth-24)/2-70);
            }];
        }
        
    }
    
    
}
-(float) getTitleLeft:(CGFloat) i {
    float left = 5;
    
    if (i > 0) {
        for (int j = 0; j < i; j ++) {
            
            RAMListModel *model=_flowSortArray[j];
            NSString *name=model.return_desc;
            
            CGSize baseSize = CGSizeMake(ScreenWidth-80, CGFLOAT_MAX);
            
            CGSize labelsize1  =    [HelpCommon stringSystemSize:name size:baseSize fontSize:12];
            
            left += labelsize1.height+10+10+50;
        }
    }
    return left;
}
- (void)CancelPress:(UIButton *)btn{
    NOPayCancelModel *cancel=[[NOPayCancelModel alloc]init];
    cancel.order_id=self.list.order_id;
    cancel.type=@"cancelorder";
    [MBProgressHUD showMessage:nil toView:self.view];
    [cancel NOPayCancelModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showSuccess:message toView:self.view];
        if ([code intValue]==200) {
              self.cancellBlock();
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [self.navigationController popViewControllerAnimated:YES];
                  });
        }
     

       
        
    } andFailure:^(NSError * _Nonnull error) {

        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
               [MBProgressHUD showError:[error localizedDescription] toView:self.view];


    }];
}
@end
