//
//  MainTableViewController.h
//  Perusal
//
//  Created by Devan Buggay on 2/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebKitViewController.h"

@interface MainTableViewController : UITableViewController

@property (nonatomic, copy) NSString *subreddit;
@property (nonatomic, strong) NSMutableArray *links;
@property bool nsfw;

- (IBAction)loadNextPage:(id)sender;

- (void) refresh:(id) sender;

- (void) loadJSON:(NSString *)subreddit withLimit:(NSInteger)limit withName:(NSString *) name;

@end
