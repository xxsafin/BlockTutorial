//
//  IODOrder.m
//  iOSDiner
//
//  Created by Xu Xian on 14-5-26.
//  Copyright (c) 2014年 Adam Burkepile. All rights reserved.
//

#import "IODOrder.h"

#import "IODItem.h"

@implementation IODOrder

- (IODItem*)findKeyForOrderItem:(IODItem*)searchItem {
    
    NSIndexSet *indexes = [[self.orderItems allKeys] indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        IODItem *key = obj;
        return [searchItem.name isEqualToString:key.name] && searchItem.price == key.price;
    }];
    
	// 2 - Return first matching item
    if ([indexes count] >= 1) {
        IODItem* key = [[self.orderItems allKeys] objectAtIndex:[indexes firstIndex]];
        return key;
    }
	// 3 - If nothing is found
    return nil;
}

@end
