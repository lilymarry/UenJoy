//
//  OrderDetailViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailModel.h"
#import "NOPayCancelModel.h"
#import "RAMReasonView.h"
#import "PayCancelModel.h"
#import <PayPalMobile.h>
#import "PaySuccess.h"
@interface OrderDetailViewController ()<PayPalPaymentDelegate>
{
    NSMutableArray *arr;
}
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UIView *shipView;
@property (nonatomic, strong) OrderDetailModel *mainModel;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@end

@implementation OrderDetailViewController
-(NSMutableArray *)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F5F5F5");
    self.title = @"Order Detail";
    
    
    [self getData];
}
-(void)getData{
    OrderDetailModel *detail=[[OrderDetailModel alloc]init];
    detail.order_id=_order_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [detail OrderDetailModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            OrderDetailModel *detail =(OrderDetailModel *)data;
            self.mainModel=  detail.data.order;
            [self setMainView];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)setMainView{
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 0, 0)];
    mainScrollView.showsVerticalScrollIndicator = NO;
       adjustsScrollViewInsets_NO(mainScrollView, self);
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(0);
        make.height.offset(ScreenHeight);
        make.width.offset(ScreenWidth-24);
        make.centerX.equalTo(self.view);
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
    
    if (self.flag == 4){
        [topView removeFromSuperview];
        [firstView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(mainScrollView).offset(100);
            make.width.offset(ScreenWidth-24);
            make.height.offset(80);
        }];
    };
    
    UILabel *pendingLabel = [UILabel new];
    pendingLabel.textColor = Color(@"#333333");
    pendingLabel.font =  [UIFont boldSystemFontOfSize:18];
    pendingLabel.text = self.flag == 0? @"Pending Payment" : self.flag == 1? @"Processing" : self.flag == 2? @"shipped" : self.flag == 3? @"Delivered" : @"Cancelled";
    [firstView addSubview:pendingLabel];
    [pendingLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(firstView);
        make.centerY.equalTo(firstView).offset(-3);
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
    OrderLabel.font = font(12);
    OrderLabel.text =[NSString stringWithFormat:@"Order:%@",self.mainModel.increment_id];
    [secondView addSubview:OrderLabel];
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(16);
        make.centerY.equalTo(secondView).offset(-2);
    }];
    
    UILabel *TimeLabel = [UILabel new];
    TimeLabel.textColor = Color(@"#999999");
    TimeLabel.font =font(12);
    TimeLabel.text = [NSString stringWithFormat:@"Time:%@",self.mainModel.created_at];
    [secondView addSubview:TimeLabel];
    [TimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.offset(-16);
        make.centerY.equalTo(secondView).offset(-2);
    }];
    
    for (int i = 0; i < self.mainModel.products.count; i++) {
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
        
        OrderDetailModel *detail =self.mainModel.products[i];
        NSString* encodedString =[detail.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
        
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
        price.font = [UIFont boldSystemFontOfSize:15];;
        price.text =[NSString stringWithFormat:@"%@%@",self.mainModel.currency_symbol,detail.row_total] ;
        [contentView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(image.mas_right).offset(15);
            make.bottom.equalTo(image.mas_bottom);
        }];
        
        UILabel *number = [UILabel new];
        number.textColor = Color(@"#333333");
        number.font = font(12);
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
    if ([self.mainModel.shipping_total doubleValue]==0) {
        Shipping=@"Free";
    }
    else
    {
        Shipping=[NSString stringWithFormat:@"%@%.2f",self.mainModel.currency_symbol,[self.mainModel.shipping_total doubleValue]];
    }
    
    
    NSArray *detailArr = @[ [NSString stringWithFormat:@"%@%.2f",self.mainModel.currency_symbol,[self.mainModel.subtotal doubleValue]],    [NSString stringWithFormat:@"%@%.2f",self.mainModel.currency_symbol,[self.mainModel.subtotal_with_discount doubleValue]], Shipping];
    if (self.flag != 0){
        itemArr = @[@"Payment Method",@"Total commodity price", @"Discount", @"Shipping"];
        detailArr = @[self.mainModel.payment_method,[NSString stringWithFormat:@"%@%.2f",self.mainModel.currency_symbol,[self.mainModel.subtotal doubleValue]],  [NSString stringWithFormat:@"%@%.2f",self.mainModel.currency_symbol,[self.mainModel.subtotal_with_discount doubleValue]], Shipping];
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
        //    detailLabel.text = [NSString stringWithFormat:@"%@%@",self.mainModel.currency_symbol,detailArr[i]];
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
    NSString *str2 =[NSString stringWithFormat:@"%@%.2f",self.mainModel.currency_symbol,[self.mainModel.grand_total doubleValue]];
    
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
    shipContentLabel.text =[NSString stringWithFormat:@"%@%@  %@",self.mainModel.customer_address_state_name,self.mainModel.customer_address_country_name,self.mainModel.customer_telephone];
    [shipView addSubview:shipContentLabel];
    [shipContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(shipView);
        make.top.equalTo(shipLabel.mas_bottom).offset(14);
        make.width.offset(ScreenWidth-48);
    }];
    
    UILabel *shipNumberLabel = [UILabel new];
    shipNumberLabel.textColor = Color(@"#333333");
    shipNumberLabel.font = font(14);
    shipNumberLabel.numberOfLines = 0;
    shipNumberLabel.text = [NSString stringWithFormat:@"%@%@  %@",self.mainModel.customer_lastname,self.mainModel.customer_firstname,self.mainModel.customer_telephone];
    [shipView addSubview:shipNumberLabel];
    [shipNumberLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.bottom.equalTo(shipView.mas_bottom).offset(-16);
    }];
    
     CGFloat sumHeight=0;
    /*
    arr=[NSMutableArray array];
    
    [arr addObjectsFromArray:@[
        @{@"time": @"2019-12-12",
          @"content": @"Item being sent to [SHENZHEN] Logistics Centre-SHENZHENItem being sent to [SHENZHEN] Logistics Centre-SHENZHENItem being sent to [SHENZHEN] Logistics Centre-SHENZHENItem being sent to [SHENZHEN] Logistics Centre-SHENZHENItem being sent to [SHENZHEN] Logistics Centre-SHENZHENItem being sent to [SHENZHEN] Logistics Centre-SHENZHEN"
        },
        @{@"time": @"2019-12-12",
          @"content": @"Centre-SHENZHEN"
        },
        @{@"time": @"2019-12-12",
          @"content": @"Item being"
        },
        @{@"time": @"2019-12-12",
          @"content": @"Centre-SHENZHEN"
        },
        @{@"time": @"2019-12-12",
          @"content": @"Item being sent to [SHENZHEN] Logistics Centre-SHENZHEN"
        }]];
    UIView *trackingView = [UIView new];
    trackingView.backgroundColor =[UIColor whiteColor];
    [mainScrollView addSubview:trackingView];
    
    
    UILabel *trackingLabel = [UILabel new];
    trackingLabel.textColor = Color(@"#333333");
    //trackingLabel.backgroundColor=[UIColor yellowColor];
    trackingLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    trackingLabel.text = @"Tracking";
    [trackingView addSubview:trackingLabel];
    [trackingLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(11);
        make.top.offset(14);
    }];
    
    
    UIView *trackingFlowView;
  
    for (int i=0; i<arr.count; i++) {
        
        
        CGSize baseSize = CGSizeMake(ScreenWidth-80, CGFLOAT_MAX);
      
        CGSize labelsize1  =    [HelpCommon stringSize:arr[i][@"content"] size:baseSize fontWithName:@"Helvetica" size:12];
        
        CGFloat height=  labelsize1.height+10+10+50;
     
        if (i==arr.count-1) {
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
        if (i==arr.count-1) {
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
        timeLab.font =  [UIFont fontWithName:@"Helvetica" size:12];
        timeLab.text = arr[i][@"time"];
        [trackingFlowView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(flowImage.mas_right).offset(20);
            make.right.offset(12);
            make.centerY.equalTo(flowImage.mas_centerY);
        }];
        UILabel *contentLab=[UILabel new];
        contentLab.textColor = Color(@"#333333");
        contentLab.font =  [UIFont fontWithName:@"Helvetica" size:12];
        contentLab.text = arr[i][@"content"];
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
        make.bottom.equalTo(trackingFlowView.mas_bottom).offset(0);
        make.width.offset(ScreenWidth-24);
    }];
    */
    
    if (self.flag < 3){
        UIView *bottomBtnView = [UIView new];
        bottomBtnView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bottomBtnView];
        [bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.offset(Is_iPhoneX?-34:0);
            make.height.offset(55);
            make.width.offset(ScreenWidth);
        }];
        if (self.flag == 0){
            UIButton *cancelBtn = [UIButton new];
            [cancelBtn setBackgroundColor:Color(@"ffffff")];
            [cancelBtn setTitle:@"Cancel" forState:0];
            [cancelBtn addTarget:self action:@selector(CancelPress:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn.titleLabel.font =  [UIFont fontWithName:@"Helvetica" size:18];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:0];
            [bottomBtnView addSubview:cancelBtn];
            [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.offset(0);
                make.top.offset(0);
                make.height.offset(55);
                make.width.offset(160*AUTOLAYOUT_WIDTH_SCALE);
            }];
            
            UIButton *PayBtn = [UIButton new];
            [PayBtn setBackgroundColor:Color(@"#F6AA00")];
            [PayBtn setTitle:@"Pay Now" forState:0];
            PayBtn.titleLabel.font =  font(18);
            [bottomBtnView addSubview:PayBtn];
                [PayBtn addTarget:self action:@selector(payPress:) forControlEvents:UIControlEventTouchUpInside];
            [PayBtn mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(bottomBtnView.mas_right);
                make.top.offset(0);
                make.height.offset(55);
                make.width.offset(ScreenWidth-(160*AUTOLAYOUT_WIDTH_SCALE));
            }];
        }else{
            UIButton *cancelBtn = [UIButton new];
            [cancelBtn setBackgroundColor:Color(@"ffffff")];
            [cancelBtn setTitle:@"Cancel" forState:0];
            cancelBtn.titleLabel.font =  font(18);
            [cancelBtn setTitleColor:[UIColor blackColor] forState:0];
            [cancelBtn addTarget:self action:@selector(CancelPress:) forControlEvents:UIControlEventTouchUpInside];
            [bottomBtnView addSubview:cancelBtn];
            [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.offset(0);
                make.top.offset(0);
                make.height.offset(55);
                make.width.offset(ScreenWidth);
            }];
        }
        if (Is_iPhoneX){
            UIView *buttomView = [UIView new];
            buttomView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:buttomView];
            [buttomView mas_makeConstraints:^(MASConstraintMaker *make){
                make.bottom.equalTo(self.view.mas_bottom);
                make.height.offset(34);
                make.width.offset(ScreenWidth);
            }];
        }
    }
    
    mainScrollView.contentSize = CGSizeMake(ScreenWidth-24, 680 + self.mainModel.products.count*90+sumHeight+100   );
    
}

- (void)setTop{
    NSArray *titleArr = @[@"PendingPayment",@"Processing",@"Shipped",@"Delivered"];
    for(int i = 0; i < titleArr.count; i++){
        int x = ((ScreenWidth-24)/4)*i;
        UIView *view = [UIView new];
        [self.topView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(x);
            make.top.offset(0);
            make.height.offset(75);
            make.width.offset((ScreenWidth-24)/4);
        }];

        UIView *circle1 = [UIView new];
        circle1.backgroundColor = self.flag == i? Color(@"#333333") : Color(@"#EEEEEE");
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
        PendingPayment.textColor = self.flag == i? Color(@"#333333") : Color(@"#999999");
        PendingPayment.font = font(11);
        PendingPayment.text = titleArr[i];
        [view addSubview:PendingPayment];
        [PendingPayment mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(circle1);
           make.top.equalTo(circle1.mas_bottom).offset(10);
        }];
        
        if (i != 3){
            UIView *line = [UIView new];
            line.backgroundColor = self.flag == i? Color(@"#333333") : Color(@"#999999");
            [view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.equalTo(circle1.mas_right).offset(19);
                make.centerY.equalTo(circle1);
                make.height.offset(1);
                make.width.offset(20);
            }];
        }
        
    }
    
    
}
-(float) getTitleLeft:(CGFloat) i {
    float left = 5;
    
    if (i > 0) {
        for (int j = 0; j < i; j ++) {
            
            NSString *name=arr[j][@"content"];
            
            CGSize baseSize = CGSizeMake(ScreenWidth-80, CGFLOAT_MAX);
            
            CGSize labelsize1  =    [HelpCommon stringSize:name size:baseSize fontWithName:@"Helvetica" size:12];
            
            left += labelsize1.height+10+10+50;
        }
    }
    return left;
}
- (void)CancelPress:(UIButton *)btn{
if (self.flag==0 ) {
     
    NOPayCancelModel *cancel=[[NOPayCancelModel alloc]init];
    cancel.order_id=self.mainModel.order_id;
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
    else if (self.flag==2||self.flag==1)
    {
        RAMReasonView *reason=[[RAMReasonView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        __block OrderDetailViewController * blockSelf = self;

        reason.block = ^(NSString * _Nonnull reason) {
            PayCancelModel *model=[[PayCancelModel alloc]init];
            model.order_id=blockSelf.order_id;
            model.detail=reason;
            model.nickname= [[LoginModel shareInstance]getUserInfo].uinfo.nickname;
              model.email= [[LoginModel shareInstance]getUserInfo].uinfo.email;
             [MBProgressHUD showMessage:nil toView:blockSelf.view];
            [model PayCancelModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
               [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [MBProgressHUD showSuccess:message toView:self.view];
                   if ([code intValue]==200) {
                             self.cancellBlock();
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [self.navigationController popViewControllerAnimated:YES];
                               });
                     }

            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:blockSelf.view animated:YES];
                       [MBProgressHUD showError:[error localizedDescription] toView:blockSelf.view];

            }];
            
            
            
        };
        [self.view.window addSubview:reason];
    }
}
- (void)payPress:(UIButton *)btn{
    if (self.flag==0 ) {
    
//         if (  [self.mainModel.payment_method isEqualToString:@"paypal_standard"]) {
          [self onClickPayPalButtonAction:self.order_id OrderMoney:self.mainModel.grand_total];
                      
                  }
    //     }
       
          
      }

- (void)onClickPayPalButtonAction:(NSString *)orderId OrderMoney:(NSString *) grand_total
{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    NSString *priceString = grand_total;
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:priceString];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = self.mainModel.order_currency_code;
    payment.shortDescription = @"order summary";
    payment.custom =orderId;//self.order.order_no;
    
    
    //  payment.shippingAddress=  [PayPalShippingAddress shippingAddressWithRecipientName:@"1" withLine1:@"2" withLine2:@"3" withCity:@"3" withState:@"3" withPostalCode:@"4" withCountryCode:@"5"];
    
    
    if (payment!=nil) {
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc]initWithPayment:payment configuration:self.payPalConfig delegate:self];
        
        paymentViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
    
}
#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
       [self dismissViewControllerAnimated:YES completion:nil];
         [MBProgressHUD showSuccess:@"PayPal Payment Success!" toView:self.view];
     
    
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         PaySuccess *pay=[[PaySuccess alloc]init];
         pay.order_id=completedPayment.custom;
         [self.navigationController pushViewController:pay animated:YES];
               });

}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
      [self dismissViewControllerAnimated:YES completion:nil];
    
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"PayPal Payment failed!" toView:self.view];
                 });

    
}
@end
