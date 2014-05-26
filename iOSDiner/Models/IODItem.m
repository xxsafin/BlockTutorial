//
//  IODItem.m
//  iOSDiner
//
//  Created by Xu Xian on 14-5-26.
//  Copyright (c) 2014年 Adam Burkepile. All rights reserved.
//

#import "IODItem.h"

#define kInventoryAddress @"http://adamburkepile.com/inventory/"

@implementation IODItem

-(id)copyWithZone:(NSZone *)zone
{
    IODItem *newItem = [[IODItem alloc] init];
    newItem.name = self.name;
    newItem.price = self.price;
    newItem.pictureFile = self.pictureFile;
    
    return newItem;
}

- (id)initWithName:(NSString*)inName andPrice:(float)inPrice andPictureFile:(NSString*)inPictureFile {
    if (self = [self init]) {
        [self setName:inName];
        [self setPrice:inPrice];
        [self setPictureFile:inPictureFile];
    }
    
    return self;
}

+ (NSArray *)retrieveInventoryItems
{
    //1.create variables
    NSMutableArray *inventories = [NSMutableArray array];
    NSError *err = nil;
    
    //2.get inventory data
    NSArray *jsonInventory = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kInventoryAddress]]
                                                             options:kNilOptions
                                                               error:&err];
    
    //3.enumerate inventory objects
    [jsonInventory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary *item = obj;
        [inventories addObject:[[IODItem alloc] initWithName:[item objectForKey:@"Name"]
                                                    andPrice:[[item objectForKey:@"Price"] floatValue]
                                              andPictureFile:[item objectForKey:@"Image"]]];
    }];
    
    //4.return a copy of the inventory data
    return [inventories copy];
}

@end
