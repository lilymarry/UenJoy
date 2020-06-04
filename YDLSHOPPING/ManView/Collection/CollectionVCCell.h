//
//  CollectionVCCell.h
//  YDLSHOPPING
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionListModel.h"

typedef void(^CollectionVCCellItemBlock)(CollectionListModel * _Nullable model);

NS_ASSUME_NONNULL_BEGIN

@interface CollectionVCCell : UITableViewCell
@property(nonatomic ,strong)CollectionListModel *model;
@property (nonatomic, copy) CollectionVCCellItemBlock block ;
@end

NS_ASSUME_NONNULL_END
