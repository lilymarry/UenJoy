//
//  SaveSearchHistory.h
//  YDLSHOPPING
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveSearchHistory : NSObject
+ (SaveSearchHistory*)sharedStore;
- (void)saveSearchHistoryArrayToLocal:(NSMutableArray *)historyStringArray;
- (NSMutableArray *)getSearchHistoryArrayFromLocal;
@end

NS_ASSUME_NONNULL_END
