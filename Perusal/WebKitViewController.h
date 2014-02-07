//
//  WebKitViewController.h
//  Perusal
//
//  Created by Devan Buggay on 2/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Link.h"

@interface WebKitViewController : UIViewController


@property (nonatomic, strong) Link *link;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
