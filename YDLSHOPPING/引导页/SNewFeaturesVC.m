//
//  SNewFeaturesVC.m
//  ShoesCloud
//
//  Created by wangsen on 15/12/7.
//  Copyright © 2015年 GYM. All rights reserved.
//

#import "SNewFeaturesVC.h"
#import "TabBarController.h"


@interface SNewFeaturesVC () <UIScrollViewDelegate>
{
    NSArray * _imagesArray;
    UIPageControl * _pageControl;
    
    UIButton * _goInHomeButton;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SNewFeaturesVC

- (void)viewWillAppear:(BOOL)animated {
//    [MobClick beginLogPageView:@"引导页"];
 //   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
  
}
- (void)viewWillDisappear:(BOOL)animated
{
//    [MobClick endLogPageView:@"引导页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    _scrollView.delegate = self;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000f green:0.412f blue:0.243f alpha:1.00f];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
 //   [self.view addSubview:_pageControl];
//    [self.view setBackgroundColor:[UIColor redColor]];
    _imagesArray = @[@"引导页750-1",@"引导页750-2",@"引导页750-3"];
    self.scrollView.backgroundColor=[UIColor yellowColor];
    for (NSInteger i = 0;  i < _imagesArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + ScreenWidth * i, 0, ScreenWidth , ScreenHeight)];
        imageView.image = [UIImage imageNamed:_imagesArray[i]];
        [_scrollView addSubview:imageView];
        if (i == 2) {
            //滑动
            UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGoInHome:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:pan];
            
            //点击
            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
            [imageView addGestureRecognizer:singleTap];
          //  imageView.userInteractionEnabled = YES;
        }
    }
    _scrollView.contentSize = CGSizeMake(ScreenWidth * _imagesArray.count, 0);
    
    _pageControl.numberOfPages = _imagesArray.count;
    CGSize _pageControlSize = [_pageControl sizeForNumberOfPages:_imagesArray.count];
    _pageControl.frame = CGRectMake(ScreenWidth/2, ScreenHeight - ScreenHeight*0.1, _pageControlSize.width, _pageControlSize.height);
    _pageControl.hidden = YES;//隐藏
    
//     _goInHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//      _goInHomeButton.frame = CGRectMake(ScreenWidth, ScreenHeight/2 - 25, 50, 44);
//      _goInHomeButton.alpha = 0.6;
//      [_goInHomeButton setBackgroundColor:[UIColor yellowColor]] ;
//    //  [_goInHomeButton setImage:[UIImage imageNamed:@"goInHome"] forState:UIControlStateNormal];
//      [self.view addSubview:_goInHomeButton];
}

#pragma mark - 点击
- (void)onClickImage {

    
    TabBarController * tabBarController = [[TabBarController alloc] init];


    self.view.window.rootViewController = tabBarController;
}

#pragma mark - 滑动
- (void)panGoInHome:(UIPanGestureRecognizer *)pan {
    
    CGFloat panX = [pan translationInView:pan.view].x;
    if (panX <= -50) {
        panX = -50;
    }
    CGRect buttonFrame = _goInHomeButton.frame;
    buttonFrame.origin.x = ScreenWidth+panX;
    _goInHomeButton.frame = buttonFrame;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (panX <= - 25) {
            [UIView animateWithDuration:0.28 animations:^{
                CGRect buttonFrame = _goInHomeButton.frame;
                buttonFrame.origin.x = ScreenWidth-50;
                _goInHomeButton.frame = buttonFrame;
            } completion:^(BOOL finished) {
                

                
                TabBarController * tabBarController = [[TabBarController alloc] init];
                

                self.view.window.rootViewController = tabBarController;
            }];
        } else {
            [UIView animateWithDuration:0.28 animations:^{
                CGRect buttonFrame = _goInHomeButton.frame;
                buttonFrame.origin.x = ScreenWidth;
                _goInHomeButton.frame = buttonFrame;
            }];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = scrollView.contentOffset.x/ScreenWidth;
}

@end
