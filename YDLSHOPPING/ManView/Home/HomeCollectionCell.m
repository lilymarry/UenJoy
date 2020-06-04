//
//  HomeCollectionCell.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "HomeCollectionCell.h"

@implementation HomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(void)xibWithCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[HomeCollectionCell cellIdentifier] bundle:nil]
     forCellWithReuseIdentifier:[HomeCollectionCell cellIdentifier]];
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}
@end
