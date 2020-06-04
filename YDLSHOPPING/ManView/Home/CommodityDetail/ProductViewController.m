//
//  ProductViewController.m
//  YDLSHOPPING
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ProductViewController.h"
#import "SDCycleScrollView.h"
#import<WebKit/WebKit.h>
#import "AddCartModel.h"
#import "SelectProductAttributeView.h"
#import "ProductTopCell.h"
#import "CartListModel.h"
#import "CartViewController.h"
#import "OderInfoNewTwo.h"
#import "OderInfoNew.h"
#import "OrderInfoModel.h"
@interface ProductViewController ()<SDCycleScrollViewDelegate ,WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource>
{
    SelectProductAttributeView *buy;
    NSString *buyNumStr;
    
    NSString * overAgein;//是否选择完购物车跳转   1选择规格 2.立即购买 3.加入购物车
}
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) WKWebView * wk_web;//极速web
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * moneyNewLab;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UILabel *flagView;
@property (nonatomic, strong)UILabel *SelectDetailLab;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"f5f5f5");
    [self getData];
    
}
- (void)getData{
    ProductDetailModel *model=[[ProductDetailModel alloc]init];
    model.product_id=_product_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model productDetailModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        
        if ([code intValue]==200) {
            ProductDetailModel *model=(  ProductDetailModel *)data;
            self.productModel=model.data.product;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setMainView];
              
                
                
            });
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
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    UIScrollView *mainScrollView = [UIScrollView new];
    mainScrollView.showsVerticalScrollIndicator = NO;
    self.scrollView=mainScrollView;
 
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.offset(0);
        make.height.offset(ScreenHeight);
        make.width.offset(ScreenWidth);
        make.centerX.equalTo(self.view);
    }];
    
    //轮播图
    NSArray *imageArrBottom =_productModel.thumbnail_img;
    NSMutableArray *arrImage=[NSMutableArray array];
    for (ProductDetailModel *model in imageArrBottom)
    {
        [arrImage addObject:model.image];
    }
    SDCycleScrollView *cycleScrollViewBottom = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenWidth, 325*AUTOLAYOUT_WIDTH_SCALE) shouldInfiniteLoop:YES imageNamesGroup:arrImage];
    
    cycleScrollViewBottom.delegate = self;
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0 ; i<imageArrBottom.count; i++) {
        NSString *str =[NSString stringWithFormat:@"%d/%d",i+1,(int)imageArrBottom.count];
        [arr addObject:str];
    }
    cycleScrollViewBottom.titlesGroup = arr;
    cycleScrollViewBottom.titleLabelTextAlignment = NSTextAlignmentRight;
    cycleScrollViewBottom.titleLabelTextFont =  font(15);
    cycleScrollViewBottom.titleLabelTextColor = Color(@"#333333");
    cycleScrollViewBottom.titleLabelBackgroundColor = [UIColor clearColor];
    cycleScrollViewBottom.pageControlStyle = 0;
    cycleScrollViewBottom.showPageControl = NO;
    [mainScrollView addSubview:cycleScrollViewBottom];
    cycleScrollViewBottom.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollViewBottom.autoScrollTimeInterval = 3.5;
    
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view1];
    
    
    CGSize baseSize = CGSizeMake(ScreenWidth-30, CGFLOAT_MAX);
    
    UILabel *CreatLab = [UILabel new];
    CreatLab.text = _productModel.name;
    CreatLab.textColor = Color(@"#333333");
    CreatLab.font = font(17);
    CreatLab.numberOfLines=0;
    CreatLab.backgroundColor=[UIColor clearColor];
    
    CGSize size=  [HelpCommon stringSystemSize:_productModel.name size:baseSize fontSize:17];
    
    [view1 addSubview:CreatLab];
    [CreatLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view1).offset(20);
        make.left.equalTo(view1).offset(12);
        make.right.equalTo(view1).offset(-12);
        make.height.offset(size.height+20);
    }];
    
    
    //    UILabel *BalconyLab = [UILabel new];
    //    BalconyLab.text = @"";
    //    BalconyLab.textColor = Color(@"#666666");
    //    BalconyLab.font =  [UIFont fontWithName:@"Helvetica" size:14];
    //    BalconyLab.numberOfLines=0;
    //
    //    CGSize labelsize1  = [@""
    //                          boundingRectWithSize:baseSize
    //                          options:NSStringDrawingUsesLineFragmentOrigin
    //                          attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:14]}
    //                          context:nil].size;
    //
    //    [view1 addSubview:BalconyLab];
    //    [BalconyLab mas_makeConstraints:^(MASConstraintMaker *make){
    //        make.left.equalTo(view1).offset(12);
    //        make.top.equalTo(CreatLab.mas_bottom).offset(5);
    //        make.right.equalTo(view1).offset(-12);
    //        make.height.offset(labelsize1.height+10);
    //    }];
    
    UILabel *newMonryLab = [UILabel new];
    newMonryLab.textColor = Color(@"#EB5E57");
    newMonryLab.text =[NSString stringWithFormat:@"%@%.2f",_productModel.price_info.special_price.symbol,(double)[_productModel.price_info.special_price.value doubleValue]];
    
    newMonryLab.font = font(20);
    self.moneyNewLab=newMonryLab;
    [view1 addSubview:newMonryLab];
    [newMonryLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(view1).offset(12);
        make.top.equalTo(CreatLab.mas_bottom).offset(20);
    }];
    
    
    UILabel *oldMoneyLab = [UILabel new];
    oldMoneyLab.textColor = Color(@"#999999");
    oldMoneyLab.font = font(12);
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSString *price=  [NSString stringWithFormat:@"%@%.2f",_productModel.price_info.price.symbol,(double)[_productModel.price_info.price.value doubleValue]];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:price attributes:attribtDic];
    if ([_productModel.price_info.price.value doubleValue]>0) {
        oldMoneyLab.attributedText = attribtStr;
    }
    else
    {
        oldMoneyLab.text = @"";
    }
    
    
    [view1 addSubview:oldMoneyLab];
    [oldMoneyLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(newMonryLab.mas_right).offset(20);
        make.centerY.equalTo(newMonryLab);
    }];
    
    
    if ([_productModel.price_info.special_price.value doubleValue]==0) {
        
        newMonryLab.text=price;
        oldMoneyLab.text=@"";
    }
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.equalTo(cycleScrollViewBottom.mas_bottom).offset(5);
        make.bottom.equalTo(newMonryLab.mas_bottom).offset(20);
    }];
    
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view2];
    
    UILabel * ServiceLab = [UILabel new];
    ServiceLab.text = @"Service";
    ServiceLab.textColor = Color(@"#333333");
    ServiceLab.font = font(15);
    [view2 addSubview:ServiceLab];
    [ServiceLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.top.offset(20);
    }];
    UILabel *ServiceDetailLab = [UILabel new];
    ServiceDetailLab.text = @"Free Shipping   Get It In 3-5 Days";
    ServiceDetailLab.textColor = Color(@"#333333");
    ServiceDetailLab.font =font(14);
    [view2 addSubview:ServiceDetailLab];
    [ServiceDetailLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(ServiceLab.mas_right).offset(20);
        make.centerY.equalTo(ServiceLab);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = Color(@"f5f5f5");
    [view2 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(ServiceDetailLab.mas_bottom).offset(20);
        make.centerX.equalTo(view2);
        make.height.offset(1);
        make.width.offset(351*AUTOLAYOUT_WIDTH_SCALE);
    }];
    UILabel * SelectLab = [UILabel new];
    SelectLab.text = @"Select";
    SelectLab.textColor = Color(@"#333333");
    SelectLab.font = font(15);
    [view2 addSubview:SelectLab];
    [SelectLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.top.equalTo(line).offset(20);
    }];
    UILabel *SelectDetailLab = [UILabel new];
    SelectDetailLab.text = @"Quantity";
    SelectDetailLab.textColor = Color(@"#333333");
    SelectDetailLab.font = font(14);
    self.SelectDetailLab=SelectDetailLab;
    [view2 addSubview:SelectDetailLab];
    [SelectDetailLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(SelectLab.mas_right).offset(20);
        make.centerY.equalTo(SelectLab);
    }];
    
    
    UIImageView *imageView=[UIImageView new];
    imageView.image=[UIImage imageNamed:@"灰色右箭头"];
    [view2 addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.height.offset(15);
        make.width.offset(12);
        make.right.offset(-20);
        make.centerY.equalTo(SelectDetailLab);
    }];
    
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.backgroundColor=[UIColor clearColor];
    [but addTarget:self action:@selector(choiceTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(0);
        make.right.offset(0);
        make.top.equalTo(line).offset(0);
        make.bottom.offset(0);
    }];
    
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.equalTo(view1.mas_bottom).offset(5);
        make.bottom.equalTo(SelectLab.mas_bottom).offset(20);
    }];
    
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view3];
    
    UILabel *PDesciptionLab = [UILabel new];
    PDesciptionLab.text = @"Product Desciption";
    PDesciptionLab.textColor = Color(@"#333333");
    PDesciptionLab.font =font(15);
    [view3 addSubview:PDesciptionLab];
    [PDesciptionLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.top.offset(20);
    }];
    
    
    NSArray *attrArrNew=_productModel.groupAttrArrNew;
    for (int i = 0; i <attrArrNew .count; i++){
        UILabel *titleLab = [UILabel new];
        self.titleLab = titleLab;
        ProductDetailModel *sub=attrArrNew[i];
        titleLab.text = sub.key;
        titleLab.textColor = Color(@"#666666");
        titleLab.font = font(14);
        [view3 addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.offset(12);
            make.top.equalTo(view3).offset(57+34*i);
            make.width.offset(130);
        }];
        UILabel *detailLab = [UILabel new];
        self.detailLab = detailLab;
        detailLab.text = sub.value;
        detailLab.textColor = Color(@"333333");
        detailLab.font = font(14);
        [view3 addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(titleLab.mas_right).offset(10);
            make.right.equalTo(view3.mas_right).offset(12);
            make.centerY.equalTo(titleLab);
        }];
    }
    
    if (attrArrNew.count>0) {
        [view3 mas_makeConstraints:^(MASConstraintMaker *make){
            make.width.offset(ScreenWidth);
            make.top.equalTo(view2.mas_bottom).offset(5);
            make.bottom.equalTo(self.titleLab.mas_bottom).offset(10);
        }];
    }
    else
    {
        [view3 mas_makeConstraints:^(MASConstraintMaker *make){
                   make.width.offset(ScreenWidth);
                   make.top.equalTo(view2.mas_bottom).offset(5);
                   make.height.offset(0);
               }];
    }
    
    
    
    
    /*
     NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);document.getElementsByTagName('body')[0].style.fontFamily='Arial';document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'; var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='150%';imgs[i].style.height='auto';}";
     WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
     WKUserContentController *wkUController = [[WKUserContentController alloc] init];
     [wkUController addUserScript:wkUScript];
     WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
     wkWebConfig.userContentController = wkUController;
     _wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth,40) configuration:wkWebConfig];
     
     _wk_web.userInteractionEnabled = YES;
     _wk_web.navigationDelegate = self;
     _wk_web.scrollView.scrollEnabled = NO;
     [view3 addSubview:_wk_web];
     
     [_wk_web loadHTMLString:_productModel.desc baseURL:nil];
     
     
     [view3 mas_makeConstraints:^(MASConstraintMaker *make){
     make.width.offset(ScreenWidth);
     make.top.equalTo(view2.mas_bottom).offset(5);
     make.bottom.equalTo(self.wk_web.mas_bottom).offset(20);
     }];
     */
    
    
    UIView *view5 = [UIView new];
    view5.backgroundColor = [UIColor whiteColor];
    view5.hidden=YES;
    [mainScrollView addSubview:view5];
    
    UILabel *SpecLab1 = [UILabel new];
    SpecLab1.text = @"Specification";
    SpecLab1.textColor = Color(@"#333333");
    SpecLab1.font = font(15);
    [view5 addSubview:SpecLab1];
    [SpecLab1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.top.offset(20);
    }];
    
    UIImageView * SpecImage1 = [UIImageView new];
    
    SpecImage1.image=[UIImage imageNamed:@"null-picture"];
    // [SpecImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    [view5 addSubview:SpecImage1];
    
    [SpecImage1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(SpecLab1).offset(40);
        make.height.offset(ScreenWidth);
        make.width.offset(ScreenWidth);
    }];
    
    NSString *str=@"The above data is for reference only, because the size is manually measured, it is inevitable that there is an error of 1cm-2cm.";
    CGSize labelsize3=  [HelpCommon stringSize:str size:baseSize fontWithName:@"Helvetica" size:14];
    UILabel *SpecImagedescLab=[UILabel new];
    SpecImagedescLab.textColor= Color(@"#333333");
    SpecImagedescLab.backgroundColor=[UIColor clearColor];
    SpecImagedescLab.font= [UIFont fontWithName:@"Helvetica" size:14];
    
    SpecImagedescLab.numberOfLines = 0;//设置换行
    SpecImagedescLab.text=str;
    
    [view5 addSubview:SpecImagedescLab];
    
    
    [SpecImagedescLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(12);
        make.right.offset(-12);
        make.top.equalTo(SpecImage1.mas_bottom).offset(10);
        make.height.offset(labelsize3.height+10);
        
    }];
    
    [view5 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.equalTo(view3.mas_bottom).offset(10);
        //make.bottom.equalTo(SpecImagedescLab.mas_bottom).offset(10);
        make.height.offset(0);
    }];
    
    
    
    UIView *view6 = [UIView new];
    view6.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:view6];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor =Color(@"#EEEEEE");
    [view6 addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.offset(10);
        make.height.offset(1);
    }];
    
    
    UILabel *detailLab = [UILabel new];
    detailLab.text = @"Graphic details";
    detailLab.textColor = Color(@"#cccccc");
    detailLab.font = font(11);
    detailLab.backgroundColor=[UIColor whiteColor];
    [view6 addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(lineView);
        make.centerX.equalTo(view6);
    }];
    
    [view6 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.offset(ScreenWidth);
        make.top.equalTo(view5.mas_bottom).offset(0);
        make.bottom.equalTo(detailLab.mas_bottom).offset(10);
    }];
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.offset(0);
        make.width.offset(ScreenWidth);
        make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
    }];
    UIButton *cartBtn = [UIButton new];
    [cartBtn setImage:[UIImage imageNamed:@"details_ic_cart"] forState:0];
    [cartBtn addTarget:self action:@selector(cartListPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cartBtn];
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.offset(0);
        make.top.offset(0);
        make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
        make.width.offset(ScreenWidth-(290*AUTOLAYOUT_WIDTH_SCALE));
    }];
    
    UILabel *flagView=[UILabel new];
    flagView.backgroundColor=[UIColor redColor];
    flagView.layer.masksToBounds = YES;
    flagView.layer.cornerRadius = 7;
    flagView.textAlignment=NSTextAlignmentCenter;
    flagView.font=[UIFont systemFontOfSize:8];
    flagView.textColor=[UIColor whiteColor];
    self.flagView=flagView;
    //  flagView.hidden=YES;
    [cartBtn addSubview:flagView];
    [flagView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(cartBtn).offset(+15);
        make.top.offset(10);
        make.height.offset(14);
        make.width.offset(14);
    }];
    
    
    UIButton *orderBtn = [UIButton new];
    [orderBtn setTitle:@"Order Now" forState:0];
    [orderBtn setBackgroundColor:[UIColor blackColor]];
    orderBtn.titleLabel.font = font(16);
    orderBtn.titleLabel.textColor = [UIColor whiteColor];
    [orderBtn addTarget:self action:@selector(orderNowPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:orderBtn];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(cartBtn.mas_right).offset(0);
        make.top.offset(0);
        make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
        make.width.offset(145*AUTOLAYOUT_WIDTH_SCALE);
    }];
    UIButton *AddBtn = [UIButton new];
    [AddBtn setTitle:@"Add To Cart" forState:0];
    [AddBtn setBackgroundColor:Color(@"#F6AA00")];
    AddBtn.titleLabel.font = font(16);
    AddBtn.titleLabel.textColor = Color(@"#ffffff");
    [AddBtn addTarget:self action:@selector(cartPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:AddBtn];
    [AddBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(orderBtn.mas_right).offset(0);
        make.top.offset(0);
        make.height.offset(50*AUTOLAYOUT_WIDTH_SCALE);
        make.width.offset(145*AUTOLAYOUT_WIDTH_SCALE);
    }];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView = tableview;
    tableview.estimatedRowHeight = 94;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = Color(@"#F5F5F5");
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.scrollEnabled=NO;
    tableview.rowHeight = UITableViewAutomaticDimension;
    [tableview registerClass:[ProductTopCell class] forCellReuseIdentifier:@"ProductTopCell"];
    [self.scrollView addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view6).offset(20);
        make.width.offset(ScreenWidth);
        make.height.offset([self getTableViewHeight]);
        
    }];
    
    
    [view1 layoutIfNeeded];
    [view2 layoutIfNeeded];
    [view3 layoutIfNeeded];
    [view5 layoutIfNeeded];
    [view6 layoutIfNeeded];
    
    
    
    CGFloat height1 = view1.frame.size.height;
    CGFloat height2 = view2.frame.size.height;
    CGFloat height3 = view3.frame.size.height;
    CGFloat height5 = view5.frame.size.height;
    CGFloat height6 = view6.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, height1+height2+height3+height5+height6+325*AUTOLAYOUT_WIDTH_SCALE+  15+[self getTableViewHeight]);
    
      [self  getCartNum];
    
}
- (void)getCartNum{
    CartListModel *model=[[CartListModel alloc]init];
    
    
    [model CartListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        
        
        if ([code intValue]==200) {
            CartListModel *model= (CartListModel *)data;
            if (model.data.cart_info.products.count>0) {
                
                NSArray *arr=model.data.cart_info.products;
                NSInteger index=0;
                for (  CartListModel *submodel in arr) {
                    index= [submodel.qty intValue]+index;
                }
                
                self.flagView.hidden=NO;
                if (index >99) {
                    self.flagView.text= @".";
                }
                else
                {
                    self.flagView.text=[NSString stringWithFormat:@"%ld",(long)index] ;
                }
            }
            else
            {
                self.flagView.hidden=YES;
            }
            
            
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
-(CGFloat )getTableViewHeight
{
    int sumHeight=0;
    
    NSArray *arr=[[NSArray alloc]init];
    if (_productModel.long_img.count>0) {
        arr=_productModel.long_img;
    }
    else
    {
        arr=_productModel.thumbnail_img;
    }
    
    for (ProductDetailModel *model in arr) {
        
        CGSize baseSize = CGSizeMake(ScreenWidth-24, CGFLOAT_MAX);
        
        CGSize labelsize1  = [HelpCommon stringSystemSize:model.image_imgdesc size:baseSize  fontSize:12];
        sumHeight=sumHeight+labelsize1.height+10+ScreenWidth+30;
        
    }
    
    return sumHeight;
}
/*
 //页面加载完成之后调用
 - (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
 
 [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
 NSString *heightStr = [NSString stringWithFormat:@"%@",any];
 
 _wk_web.frame = CGRectMake(0, 60, ScreenWidth, heightStr.floatValue + 15);
 
 [self.view3 mas_updateConstraints:^(MASConstraintMaker *make){
 
 make.bottom.equalTo(self.wk_web.mas_bottom).offset(20);
 }];
 
 [self.view1 layoutIfNeeded];
 [self.view2 layoutIfNeeded];
 [self.view3 layoutIfNeeded];
 [self.view4 layoutIfNeeded];
 CGFloat height1 = self.view1.frame.size.height;
 CGFloat height2 = self.view2.frame.size.height;
 CGFloat height3 = self.view3.frame.size.height;
 CGFloat height4 = self.view4.frame.size.height+20;
 
 self.scrollView.contentSize = CGSizeMake(ScreenWidth, height1+height2+height3+height4+325*AUTOLAYOUT_WIDTH_SCALE+500+heightStr.floatValue + 15);
 
 }];
 }
 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_productModel.long_img.count>0) {
        return  _productModel.long_img.count;
    }
    else
    {
        return   _productModel.thumbnail_img.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductTopCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_productModel.long_img.count>0) {
        cell.productModel=_productModel.long_img[indexPath.row];
    }
    else
    {
        cell.productModel=_productModel.thumbnail_img[indexPath.row];
    }
    
    
    return cell;
    
}
- (void)cartListPress{
    BOOL isExit=NO;
    for(UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:[CartViewController class]]){
            isExit=YES;
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
    
    if (isExit==NO) {
        CartViewController *cart=[[CartViewController alloc]init];
        cart.ishiddenTabBarController=YES;//隐藏tabbar
        [self.navigationController pushViewController:cart animated:YES];
        
    }
    
}
- (void)cartPress{
    overAgein = @"2";//加入购物车
    if (buyNumStr == nil) {
        [self selectProductAttributeView];
        return;
    }
    [self addCart];
    
}

- (void)choiceTypeBtnClick{
    
    overAgein = @"1";
    [self selectProductAttributeView];
}

- (void)orderNowPress{
    overAgein = @"3";//立即购买
    if (buyNumStr == nil) {
        [self selectProductAttributeView];
        return;
    }
    [self setOrder];
}
- (void)selectProductAttributeView{
    buy=[[SelectProductAttributeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    NSString* encodedString =[_productModel.main_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
    
    [buy.goodImaView  sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"null-picture"]];
    buy.priceLab.text=self.moneyNewLab.text;
    buy.num=buyNumStr;
    __block ProductViewController * blockSelf = self;
    
    buy.numBlock = ^(NSString * _Nonnull num,NSString *type) {
        buyNumStr=num;
        blockSelf.SelectDetailLab.text=[NSString stringWithFormat:@"Quantity x%@",num];
        
        if ([blockSelf->overAgein isEqualToString:@"2"]) {
            [blockSelf addCart];
        }
        if ([blockSelf->overAgein isEqualToString:@"3"]) {
            [blockSelf setOrder];
        }
    };
    buy.cancelBlock = ^{
        //   buyNumStr=nil;
    };
    [self.view.window addSubview:buy];
    
    
}
- (void)setOrder{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    
    if (uid.length>0) {
        [self addCartToNetWithType:@"setOrder" ];
    }
    else
    {
        if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
            LoginViewController *log = [LoginViewController new];
            YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
            
            log.isPresent=@"2";
            [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
        }
        else
        {
            [self addCartToNetWithType:@"setOrder" ];
        }
    }
    
}
- (void)addCart{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
    
    if (uid.length>0) {
        [self addCartToNetWithType:@"addCart" ];
    }
    else
    {
        if ([[LoginModel shareInstance]getUserInfo].uuid.length==0) {
            LoginViewController *log = [LoginViewController new];
            YDLNavigationViewController *navi = [[YDLNavigationViewController alloc]initWithRootViewController:log];
            
            log.isPresent=@"2";
            [[UIApplication sharedApplication] keyWindow].rootViewController=navi;
        }
        else
        {
            [self addCartToNetWithType:@"addCart" ];
        }
    }
    
}
- (void)addCartToNetWithType:(NSString *)type{
    AddCartModel *model=[[AddCartModel alloc]init];
    model.product_id=_product_id;
    model.qty=buyNumStr;
    
    if ([type isEqualToString:@"setOrder"]) {
        model.buy_now=@"1";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [model AddCartModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            
            if ([type isEqualToString:@"addCart"]) {
                
                [self getCartNum];
            }
            else
            {
                
                NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tourist_id"];
                
                if (uid.length>0) {
                    
                    OderInfoNew  *one=[[OderInfoNew alloc]init];
                    [self.navigationController pushViewController:one animated:YES];
                }
                else
                {
                    
                    [MBProgressHUD showMessage:nil toView:self.view];
                    OrderInfoModel *info=[[OrderInfoModel alloc]init];
                    info.refresh=@"0";
                    [info OrderInfoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, id  _Nonnull address_list  ,id  _Nonnull payments,NSDictionary *contryDic) {
                        
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        if ([code intValue]==200) {
                            OrderInfoModel *model=(OrderInfoModel *)address_list;
                            
                            NSArray *arr=(NSArray *)model.address_list;
                            if (arr.count>0) {
                                OderInfoNewTwo *one=[[OderInfoNewTwo alloc]init];
                                [self.navigationController pushViewController:one animated:YES];
                            }
                            else
                            {
                                OderInfoNew  *one=[[OderInfoNew alloc]init];
                                [self.navigationController pushViewController:one animated:YES];
                            }
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
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:message toView:self.view];
        });
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        
    }];
}
@end
