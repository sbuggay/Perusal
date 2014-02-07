//
//  WebKitViewController.m
//  Perusal
//
//  Created by Devan Buggay on 2/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "WebKitViewController.h"

@interface WebKitViewController ()

@end

@implementation WebKitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *fullURL = _link.url;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    
//    NSMutableArray *buttons = [[NSMutableArray alloc ]initWithCapacity:2];
//    
//
//    UIBarButtonItem *button1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(share:)];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
//    [buttons addObject:button1];
//    [buttons addObject:button2];
    [self.navigationItem setRightBarButtonItem:button2 animated:NO];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)share: (id)sender {
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:self.link.url, nil] applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
