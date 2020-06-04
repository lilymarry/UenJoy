//
//  SaveSearchHistory.m
//  YDLSHOPPING
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 sunjiayu. All rights reserved.
//

#import "SaveSearchHistory.h"

@implementation SaveSearchHistory
+ (SaveSearchHistory*)sharedStore {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[SaveSearchHistory alloc] init];
    });
    return _sharedObject;
}



- (void)saveSearchHistoryArrayToLocal:(NSArray *)historyStringArray {
    [[NSUserDefaults standardUserDefaults] setObject:historyStringArray forKey:@"historyStringArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)getSearchHistoryArrayFromLocal{
    NSArray *historyStringArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyStringArray"];
    historyStringArray = [NSMutableArray arrayWithArray:historyStringArray];
    return historyStringArray;
}
@end
