//
//  CollectionVCCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "CollectionVCCell.h"
#import "SNBannerView.h"
#import "CollectionItemView.h"

@interface CollectionVCCell()<SNBannerViewDelegate>
{
       UIScrollView  *itemScrollView;
}
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemViewhhh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerViewHH;

@end
@implementation CollectionVCCell
- (void)setModel:(CollectionListModel *)model
{
    _model=model;
    
  
    for (UIView *view in self.bannerView.subviews ) {
        [view removeFromSuperview];
    }
    if (model.collection_imgs.count>0) {
          _bannerViewHH.constant=ScreenWidth/375*129;
        SNBannerView * banner =  [[SNBannerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/375*129) delegate:self imageURLs:model.collection_imgs placeholderImageName:@"null-picture" currentPageTintColor:[UIColor darkTextColor] pageTintColor:[UIColor lightGrayColor]];
           
           [self.bannerView addSubview:banner];
    }
    else
    {
         _bannerViewHH.constant=0;
    }
    
    
    if (self.model.content_products.count>0) {
          [self intiItemScrollView];
          _itemViewhhh.constant=180;
    }
    else
    {
        _itemViewhhh.constant=0;
    }
  
    
}
-(void) intiItemScrollView
{
    //获取滚动条
    if(!itemScrollView){
        itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth ,180)];
        itemScrollView.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        itemScrollView.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
         itemScrollView.bouncesZoom = NO;
        //横竖屏自适应
        itemScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //  scrollView.backgroundColor=[UIColor redColor];
        //添加到当前视图
        [self.itemView addSubview:itemScrollView];
    }else{
        //清除子控件
        for (UIView *view in [itemScrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (self.model.content_products>0) {
        
        CGFloat width = ScreenWidth/3.5 ;
        if (width<118) {
            width=118;
        }
        
   
        for (int i=0; i<self.model.content_products.count; i++) {
            
          
            CollectionItemView *view = [[CollectionItemView alloc] initWithFrame:CGRectMake(width*i, 0, width, 180)];
          
                      
                
                            CollectionListModel *model=self.model.content_products[i];
                         
                            NSString* encodedString =[model.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
                             [view.goodImaV sd_setImageWithURL:[NSURL URLWithString:encodedString]
                                          placeholderImage:[UIImage imageNamed:@"null-picture"]];
                           view.nameLab.text = model.name;
            view.priceLab.text=[NSString stringWithFormat:@"$%.2f",[model.special_price doubleValue]];
            view.ItemBtn.tag=i;
            [view.ItemBtn addTarget:self action:@selector(itemPress:) forControlEvents:UIControlEventTouchUpInside];
            [itemScrollView addSubview:view];
           
        }
        if (ScreenWidth>(self.model.content_products.count+1)*width) {
             [itemScrollView setContentSize:CGSizeMake(ScreenWidth, 0)];
        }
        else
        {
             [itemScrollView setContentSize:CGSizeMake((self.model.content_products.count+1)*width, 0)];
        }
    }
}
- (void)itemPress:(UIButton *)btn{
       CollectionListModel *model=self.model.content_products[btn.tag];
    self.block(model);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
