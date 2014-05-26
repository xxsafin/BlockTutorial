//
//  IODItem.h
//  iOSDiner
//
//  Created by Xu Xian on 14-5-26.
//  Copyright (c) 2014年 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IODItem : NSObject<NSCopying>

@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) float price;
@property (nonatomic,strong) NSString* pictureFile;

- (id)initWithName:(NSString*)inName andPrice:(float)inPrice andPictureFile:(NSString*)inPictureFile;

+ (NSArray *)retrieveInventoryItems;

@end
