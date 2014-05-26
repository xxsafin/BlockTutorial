//
//  IODViewController.m
//  iOSDiner
//
//  Created by Adam Burkepile on 1/29/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "IODViewController.h"

#import "IODItem.h"
#import "IODOrder.h"

@interface IODViewController()
{
    int currentItemIndex;
}
@property (strong, nonatomic) NSMutableArray *inventory;
@property (strong, nonatomic) IODOrder *order;

@end

@implementation IODViewController

dispatch_queue_t queue;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentItemIndex = 0;
    self.order = [[IODOrder alloc] init];
    queue = dispatch_queue_create("com.otakugame.iosdiner", nil);
}

- (void)viewDidUnload
{
    [self setIbRemoveItemButton:nil];
    [self setIbAddItemButton:nil];
    [self setIbPreviousItemButton:nil];
    [self setIbNextItemButton:nil];
    [self setIbTotalOrderButton:nil];
    [self setIbChalkboardLabel:nil];
    [self setIbCurrentItemImageView:nil];
    [self setIbCurrentItemLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //0 - Update Buttons
    [self updateInventoryButtons];
    
    //1 - Set loading text
    self.ibChalkboardLabel.text = @"Loading Inventory...";
    //2 - Get inventory
    dispatch_async(queue, ^{
        self.inventory = [[IODItem retrieveInventoryItems] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            //3 - Set inventory loaded text
			[self updateInventoryButtons];
            [self updateCurrentInventoryItem];
            self.ibChalkboardLabel.text = @"Inventory loaded! How can i help you?";
        });
    });
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)ibaRemoveItem:(id)sender {
}

- (IBAction)ibaAddItem:(id)sender {
}

- (IBAction)ibaLoadPreviousItem:(id)sender {
}

- (IBAction)ibaLoadNextItem:(id)sender {
}

- (IBAction)ibaCalculateTotal:(id)sender {
}

- (void)updateInventoryButtons {
    if (!self.inventory || [self.inventory count] == 0) {
        self.ibAddItemButton.enabled = NO;
        self.ibRemoveItemButton.enabled = NO;
        self.ibNextItemButton.enabled = NO;
        self.ibPreviousItemButton.enabled = NO;
        self.ibTotalOrderButton.enabled = NO;
    } else {
        if (currentItemIndex <= 0) {
            self.ibPreviousItemButton.enabled = NO;
        } else {
            self.ibPreviousItemButton.enabled = YES;
        }
        if (currentItemIndex >= [self.inventory count]-1) {
            self.ibNextItemButton.enabled = NO;
        } else {
            self.ibNextItemButton.enabled = YES;
        }
        IODItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
        if (currentItem) {
            self.ibAddItemButton.enabled = YES;
        } else {
            self.ibAddItemButton.enabled = NO;
        }
        if (![self.order findKeyForOrderItem:currentItem]) {
            self.ibRemoveItemButton.enabled = NO;
        } else {
            self.ibRemoveItemButton.enabled = YES;
        }
        if ([self.order.orderItems count] == 0) {
            self.ibTotalOrderButton.enabled = NO;
        } else {
            self.ibTotalOrderButton.enabled = YES;
        }
    }
}

- (void)updateCurrentInventoryItem {
    if (currentItemIndex >= 0 && currentItemIndex < [self.inventory count]) {
        IODItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
        self.ibCurrentItemLabel.text = currentItem.name;
        self.ibCurrentItemImageView.image = [UIImage imageNamed:[currentItem pictureFile]];
    }
}

-(void)dealloc
{
    dispatch_release(queue);
}
@end
