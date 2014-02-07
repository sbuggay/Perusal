//
//  Link.h
//  Perusal
//
//  Created by Devan Buggay on 2/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Link : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *ups;
@property (nonatomic, copy) NSString *downs;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *subreddit;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) bool *nsfw;
@property (nonatomic, copy) UIImage *thumbnail;

@end
