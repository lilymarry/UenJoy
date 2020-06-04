//
//  ReviewThreeCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "ReviewThreeCell.h"
#import "SelectPicView.h"
#import "ZLPhoto.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ReviewThreeCell ()<
UINavigationControllerDelegate,UIImagePickerControllerDelegate,SelectPicViewDelegate,UIActionSheetDelegate,UITextViewDelegate>
{
    
    SelectPicView *pictureView;
    UIImagePickerController * _imagePickerPhoto;
    UIImagePickerController * _imagePickerCamera;
}
@property (strong, nonatomic) IBOutlet UIView *picView;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UITextView *descText;


@property (weak, nonatomic) IBOutlet UIButton *rateBtn1;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn2;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn3;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn4;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn5;

@end
@implementation ReviewThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    pictureView = [[SelectPicView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  80)];
    pictureView.delegate = self;
    pictureView.typeStr=@"1";
    [_picView addSubview:pictureView];
    
    self.descLab.text=@"Does the item meet your expectations? Tell me about your experience and share with them.";
}

- (void)loadPicView{
      [pictureView refresPictureView:self.saveArr];
    int i= [self.rateNum intValue];
    switch (i) {
        case 0:
        {
            self.rateBtn1.selected=NO;
            self.rateBtn2.selected=NO;
            self.rateBtn3.selected=NO;
            self.rateBtn4.selected=NO;
            self.rateBtn5.selected=NO;
            
            
        }
            break;
        case 1:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=NO;
            self.rateBtn3.selected=NO;
            self.rateBtn4.selected=NO;
            self.rateBtn5.selected=NO;
           
            
        }
            break;
        case 2:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=NO;
            self.rateBtn4.selected=NO;
            self.rateBtn5.selected=NO;
          
            
        }
            break;
        case 3:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=YES;
            self.rateBtn4.selected=NO;
            self.rateBtn5.selected=NO;
         
            
        }
            break;
        case 4:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=YES;
            self.rateBtn4.selected=YES;
            self.rateBtn5.selected=NO;
          
        }
            break;
        case 5:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=YES;
            self.rateBtn4.selected=YES;
            self.rateBtn5.selected=YES;
           
            
        }
        default:
            break;
    }
    if (self.desc.length >0) {
        self.descLab.hidden=YES;
    }
    else
    {
        self.descLab.hidden=NO;
    }
    self.descText.text=self.desc;
    self.descText.delegate=self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)removeImageView:(int)index andType:(nonnull NSString *)type {
    if (index==8000) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self  pickerCamera];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"choose from album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self  choiceMutSelectImageView];
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [alert addAction:cancle];
        
        UIPopoverPresentationController *popover = alert.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = self.superview;
            popover.sourceRect = CGRectMake(0, 0, 100, 100);
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        [ [self viewController]  presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        
        [pictureView refresPictureView:self.saveArr];
        self.threeBlock(self.saveArr,  self.rateNum,self.desc);
           
    }
}

-(void)pickerCamera
{
    _imagePickerCamera = [[UIImagePickerController alloc] init];
    _imagePickerCamera.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.25, 1.25);
        _imagePickerCamera.cameraViewTransform = cameraTransform;
        
        _imagePickerCamera.allowsEditing = YES;
        _imagePickerCamera.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [[self viewController] presentViewController:_imagePickerCamera animated:YES completion:nil];
    }
}
#pragma mark - 相册多图
- (void)choiceMutSelectImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    
    pickerVc.maxCount = 8-self.saveArr.count;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = NO;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        [MBProgressHUD showMessage:nil toView:self.superview];
        dispatch_queue_t queue = dispatch_queue_create("x.x.x", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
        
             for (int i = 0; i < status.count; i++) {
                      id assets = status[i];
                      if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                          ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
                          UIImage *   scaleImage = [HelpCommon zipImage:ddd.originImage];
                          [self.saveArr addObject:scaleImage];
                      }
                  }
            dispatch_async(dispatch_get_main_queue(), ^{
                  [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];
                self.threeBlock(self.saveArr,  self.rateNum,self.desc);
                       [pictureView refresPictureView:self.saveArr];
            });
        });
      
    };
    [pickerVc showPickerVc:[self viewController]];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
#pragma mark 照相
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //设置只可拍照
        _imagePickerCamera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
        NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImage * imageCamera = info[UIImagePickerControllerEditedImage];
            
            SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
            UIImageWriteToSavedPhotosAlbum(imageCamera, self,selectorToCall, nil);
            UIImage * scaleImage= [HelpCommon zipImage:imageCamera];
            [self.saveArr addObject:scaleImage];
            
            [pictureView refresPictureView:self.saveArr];
          self.threeBlock(self.saveArr,  self.rateNum,self.desc);
            [[self viewController]  dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [MBProgressHUD showSuccess:@"Saved to album successfully!" toView:[UIApplication sharedApplication].delegate.window];
}
- (void)imageWasSavedSuccessfully:(UIImage *)cameraImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    
    if (paramError == nil){
        
        NSLog(@"保存相册成功");
        
    } else {
        
        NSLog(@"保存相册时发生错误");
        NSLog(@"Error = %@", paramError);
    }
}
- (UIViewController *)viewController

{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
}

- (IBAction)rateBtnPress:(id)sender {
    [_descText resignFirstResponder];
    UIButton *btn =(UIButton *)sender;
    switch (btn.tag) {
        case 1000:
            {
                self.rateBtn1.selected=YES;
                  self.rateBtn2.selected=NO;
                  self.rateBtn3.selected=NO;
                  self.rateBtn4.selected=NO;
                  self.rateBtn5.selected=NO;
                self.rateNum=@"1";
                
            }
            break;
        case 1001:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=NO;
            self.rateBtn4.selected=NO;
            self.rateBtn5.selected=NO;
              self.rateNum=@"2";
            
        }
            break;
        case 1002:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=YES;
            self.rateBtn4.selected=NO;
            self.rateBtn5.selected=NO;
              self.rateNum=@"3";
            
        }
            break;
        case 1003:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=YES;
            self.rateBtn4.selected=YES;
            self.rateBtn5.selected=NO;
              self.rateNum=@"4";
        }
            break;
        case 1004:
        {
            self.rateBtn1.selected=YES;
            self.rateBtn2.selected=YES;
            self.rateBtn3.selected=YES;
            self.rateBtn4.selected=YES;
            self.rateBtn5.selected=YES;
              self.rateNum=@"5";
            
        }
        default:
            break;
    }
    self.threeBlock(self.saveArr,  self.rateNum,self.desc);
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    self.desc=textView.text;
    self.threeBlock(self.saveArr,  self.rateNum,self.desc);

    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
   
    self.descLab.hidden=YES;
 
}

@end
