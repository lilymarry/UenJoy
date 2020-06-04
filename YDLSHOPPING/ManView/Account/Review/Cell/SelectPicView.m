//
//  SelectPicView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SelectPicView.h"
//#import "UImageHelper.h"
@interface SelectPicView()<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIButton *addBtn;
    UILabel * numLab;
}
@property (nonatomic, strong)NSMutableArray *imageArrs;
@property (nonatomic, strong)NSMutableArray *saveImageView;

@end
@implementation SelectPicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _saveImageView = [[NSMutableArray alloc] init];
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    
}
- (void)refresPictureView:(NSArray *)lists
{
    self.imageArrs = (NSMutableArray *)lists;
    int imgNum =(int) self.imageArrs.count;
    for (UIImageView *imageView in _saveImageView) {
        [imageView removeFromSuperview];
    }
    [addBtn removeFromSuperview];
    [numLab removeFromSuperview];
  
    CGFloat  viewWidth =60;
    CGFloat  viewHeight =60;
    scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1)+200, 0);
    for (int i = 0 ; i < imgNum; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 5, viewWidth, viewHeight)];
        UIImage *data = [self.imageArrs objectAtIndex:i];
        imageView.image=data;
    //  [imageView setImage:[HelpCommon zipImage:data]];
        [imageView setUserInteractionEnabled:YES];
       
        imageView.tag =i;
        [scrollView addSubview:imageView];
        [_saveImageView addObject:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        [imageView addGestureRecognizer:singleTap];
        
        
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake(viewWidth - 15,0, 15, 15)];
      
        [bt.layer setMasksToBounds:YES];
         bt.layer.cornerRadius = bt.frame.size.width/2;;
        
        [bt setTitle:@"X" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:12]];
        bt.backgroundColor=Color(@"f6aa00");
        bt.tag = i;
        [bt addTarget:self action:@selector(deletNowIma:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:bt];
        
        
        
    }
    addBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setFrame:CGRectMake(5+(5+viewWidth)*imgNum ,5, viewWidth, viewHeight)];
    [addBtn setImage:[UIImage imageNamed:@"review-btn-add"] forState:UIControlStateNormal];
    addBtn.tag = 8000;
    [addBtn addTarget:self action:@selector(deletNowIma:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addBtn];
    
    numLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addBtn.frame)+5, 20, 200, viewHeight-20)];
    numLab.text=[NSString stringWithFormat:@"up to %d",imgNum];
    numLab.font= font(12);
    numLab.textColor=Color(@"#333333");
    if (imgNum==0) {
        numLab.hidden=YES;
    }
    else{
        numLab.hidden=NO;
    }
    [scrollView addSubview:numLab];
 
    
    if (imgNum==8) {
        addBtn.hidden=YES;
        
    }
    else
    {
      
        addBtn.hidden=NO;
    }
    [_saveImageView addObject:addBtn];
    
    
}
-(void)deletNowIma:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag!=8000) {
        [self.imageArrs removeObjectAtIndex:button.tag];
        UIImageView *imgView = (UIImageView *)[self.saveImageView objectAtIndex:button.tag];
        [imgView removeFromSuperview];
        [self.saveImageView removeObjectAtIndex:button.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(removeImageView:andType:)]) {
        [self.delegate removeImageView:(int)button.tag andType:_typeStr];
    }
    
    
}

-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
    if ([self.delegate respondsToSelector:@selector(showImageView: andType:)]) {
        [self.delegate showImageView:(int)imgView.tag andType:_typeStr];
    }
    
}

@end
