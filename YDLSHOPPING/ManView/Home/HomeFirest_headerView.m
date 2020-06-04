//
//  HomeFirest_headerView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HomeFirest_headerView.h"
@interface HomeFirest_headerView ()
{
    UIScrollView  *scrollView;
}
@end
@implementation HomeFirest_headerView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr=titleArr;
    [self initScrollView];
}
-(void) initScrollView{
    //获取滚动条
    if(!scrollView){
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-80 ,30)];
        scrollView.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        scrollView.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
         scrollView.bouncesZoom = NO;
        //横竖屏自适应
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
       scrollView.backgroundColor=[UIColor whiteColor];
        //添加到当前视图
        [self.cataView addSubview:scrollView];
        
     
             UIButton *     btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnText setFrame:CGRectMake(ScreenWidth-80,
                                               0,
                                                80,
                                               30)];
                  
                  btnText.backgroundColor=[UIColor whiteColor];
                  
                  [btnText setTitle:@"More" forState:UIControlStateNormal];
                  btnText.titleLabel.font = font(12);
                  
                
                  btnText.userInteractionEnabled = YES;
                  
                  btnText.tag=9000;
                  [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];


                        [btnText setTitleColor:Color(@"#F69C00") forState:UIControlStateNormal];
                      
                      [btnText setImage:[UIImage imageNamed:@"btn_home_more"] forState:UIControlStateNormal];
                      [btnText setTitleEdgeInsets:UIEdgeInsetsMake(0, - btnText.imageView.image.size.width-2, 0, btnText.imageView.image.size.width)];
                         [btnText setImageEdgeInsets:UIEdgeInsetsMake(2, btnText.titleLabel.bounds.size.width, 0, -btnText.titleLabel.bounds.size.width)];
                 
        [self.cataView addSubview:btnText];
        
        
    }else{
        //清除子控件
        for (UIView *view in [scrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (self.titleArr) {
        
        CGFloat offsetX = 0 , h = 30;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
    
        
        for (int i=1; i<self.titleArr.count; i++) {
            HomeFirstModel *model=self.titleArr[i];
            strTitle=model.name;
            
            CGSize baseSize = CGSizeMake(CGFLOAT_MAX, 30);
            
                CGSize size=  [HelpCommon stringSystemSize:model.name size:baseSize fontSize:12];
         
                        
            CGFloat width= size.width+20;
           
            
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
         
            [btnText setFrame:CGRectMake([self getTitleLeft:i],
                                         0,
                                          width,
                                         h)];
            
          
     
            btnText.backgroundColor=[UIColor clearColor];
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = font(12);
            
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];

          
            
                 if (i!=self.titleArr.count-1) {
                    
                    [btnText setTitleColor:Color(@"#333333") forState:UIControlStateNormal];
                              UIView *line=[[UIView alloc]initWithFrame:CGRectMake(btnText.frame.size.width-1, 8, 1, btnText.frame.size.height-16)];
                              line.backgroundColor=Color(@"#666666");
                              [btnText addSubview:line];
                       [scrollView addSubview:btnText];
                         
                }
           
        }
        [scrollView setContentSize:CGSizeMake(offsetX+10*(self.titleArr.count-1), 0)];

    }
}
-(float) getTitleLeft:(CGFloat) i {
     float left = 0;
        for (int j = 1; j < i; j ++) {

                HomeFirstModel *model=[self.titleArr objectAtIndex:j];
            
            CGSize baseSize = CGSizeMake(CGFLOAT_MAX, 30);
                     CGSize size=  [HelpCommon stringSystemSize:model.name size:baseSize  fontSize:12];
               
            left += size.width+20;
    }
    return left;
}
#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(UIButton *)but
{
       NSInteger index;
   if (but.tag==self.titleArr.count-1) {
       index=0;
   }
   else
   {
       index=but.tag;
   }
  if (but.tag==9000) {
       index=0;
  }
   self.titleBlock(index);
}

@end
