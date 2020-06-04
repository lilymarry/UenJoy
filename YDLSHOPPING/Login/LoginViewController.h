
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshViewBlock)(void);

@interface LoginViewController : UIViewController
@property(nonatomic ,strong)NSString *isPresent ; //1为Present 进入   2为根视图 进入
@property (nonatomic, copy) refreshViewBlock block;
@end

NS_ASSUME_NONNULL_END
