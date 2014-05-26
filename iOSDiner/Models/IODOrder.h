//
//  IODOrder.h
//  iOSDiner
//
//  Created by Xu Xian on 14-5-26.
//  Copyright (c) 2014年 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IODItem;
@interface IODOrder : NSObject

@property (nonatomic,strong) NSMutableDictionary* orderItems;

- (IODItem*)findKeyForOrderItem:(IODItem*)searchItem;

@end
