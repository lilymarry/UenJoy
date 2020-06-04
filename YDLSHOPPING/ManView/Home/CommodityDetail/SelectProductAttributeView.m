//
//  SelectProductAttributeView.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SelectProductAttributeView.h"
#import "SelectProductAttributeViewCell.h"
@interface SelectProductAttributeView ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *mcollect;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UIView *backView;



@end

@implementation SelectProductAttributeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SelectProductAttributeView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _mcollect.delegate=self;
        _mcollect.dataSource=self;
         [_mcollect registerNib:[UINib nibWithNibName:NSStringFromClass([SelectProductAttributeViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"SelectProductAttributeViewCell"];
        
        _num_tf.delegate=self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHiden:) name: UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillAppear:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        
    }
    return self;
}
-(void)keyHiden:(NSNotification *)notification
{
    
    [UIView animateWithDuration:0.25 animations:^{
        //恢复原样
        self.backView.transform = CGAffineTransformIdentity;
        
    }];
    
    
}
-(void)keyWillAppear:(NSNotification *)notification
{
    //获得通知中的info字典
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect= [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
         self.backView.transform = CGAffineTransformMakeTranslation(0, -([UIScreen mainScreen].bounds.size.height-rect.origin.y)+100);
    }];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)setNum:(NSString *)num
{
    if (num.length==0) {
           self.num_tf.text=@"1";
          //  _num=@"1";
    }
    else
    {
        self.num_tf.text=num;
         //   _num=num;
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
        SelectProductAttributeViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectProductAttributeViewCell" forIndexPath:indexPath];
    
    if (_indexPath.item ==indexPath.item &&_indexPath!=nil) {
        cell.nameLab.textColor=Color(@"333333");
         cell.nameLab.layer.borderWidth = 2;
         cell.nameLab.layer.borderColor =Color(@"333333").CGColor;
    }
    else
    {
       cell.nameLab.textColor=Color(@"666666");
         cell.nameLab.layer.borderWidth = 0.8;
         cell.nameLab.layer.borderColor =Color(@"999999").CGColor;;
    }
        return cell;
}


#pragma mark - CollectionView的item的布局
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
        return CGSizeMake(ScreenWidth/2-6,50);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    int newRow =(int) [indexPath item];
    
        int oldRow =(int)( (_indexPath !=nil)?[_indexPath item]:-1);
        if (newRow != oldRow) {
            SelectProductAttributeViewCell *newcell =(SelectProductAttributeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            newcell.nameLab.textColor=Color(@"333333");
            newcell.nameLab.layer.borderWidth = 2;
            newcell.nameLab.layer.borderColor =Color(@"333333").CGColor;
            
            SelectProductAttributeViewCell *oldCell =(SelectProductAttributeViewCell *)[collectionView cellForItemAtIndexPath:_indexPath];
            oldCell.nameLab.textColor=Color(@"666666");
            oldCell.nameLab.layer.borderWidth = 0.8;
            oldCell.nameLab.layer.borderColor =Color(@"999999").CGColor;;
            _indexPath = indexPath;
            
        }
    else
    {
    
        if (_indexPath !=nil) {
               SelectProductAttributeViewCell *oldCell =(SelectProductAttributeViewCell *)[collectionView cellForItemAtIndexPath:_indexPath];
            oldCell.nameLab.textColor=Color(@"666666");
            oldCell.nameLab.layer.borderWidth = 0.8;
            oldCell.nameLab.layer.borderColor =Color(@"999999").CGColor;
            _indexPath=nil;
            
        }
        else
        {
            SelectProductAttributeViewCell *newcell =(SelectProductAttributeViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            newcell.nameLab.textColor=Color(@"333333");
            newcell.nameLab.layer.borderWidth = 2;
            newcell.nameLab.layer.borderColor =Color(@"333333").CGColor;
            _indexPath=indexPath;
        }
    }
 
   
}

- (IBAction)cancellPress:(id)sender {
    
    BOOL  re =[self textFieldShouldEndEditing:_num_tf];
    if (re) {
    
      [self removeFromSuperview];
        self.cancelBlock();
    }
   
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField.text intValue]==0) {
      //  The purchase quantity can not be 0.
           return NO;
       }
       return YES;
}
- (IBAction)addBtnPress:(id)sender {
    NSInteger num = [ self.num_tf.text integerValue];
    num ++;
    NSString *str =[NSString stringWithFormat:@"%ld",(long)num];
    self.num_tf.text=str;

}
- (IBAction)reduceBtnPress:(id)sender {
    NSInteger num = [ self.num_tf.text integerValue];
    if (num>=2) {
         num --;
    }
     NSString *str =[NSString stringWithFormat:@"%ld",(long)num];
          self.num_tf.text=str;
    
}
- (IBAction)sureBtn:(id)sender {
  
      NSInteger num = [ self.num_tf.text integerValue];
    if (num==0) {
        [MBProgressHUD showError:@"Buy at least one" toView:self.superview];
        return;
    }
      [self removeFromSuperview];
    self.numBlock([NSString stringWithFormat:@"%ld",num] ,_type);
}
@end
