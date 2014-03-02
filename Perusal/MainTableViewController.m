//
//  MainTableViewController.m
//  Perusal
//
//  Created by Devan Buggay on 2/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _links = [[NSMutableArray alloc] init];
    _nsfw = NO;
    [self refresh:nil];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadNextPage:(id)sender {
    NSInteger limit = 10;
    NSString *name = [[_links lastObject] name];
    [self loadJSON:@"all" withLimit:limit withName:name];
}

- (void)refresh:(id)sender
{
    _links = [[NSMutableArray alloc] init];
    [self loadJSON:@"all" withLimit:10 withName:nil];
    [self.tableView reloadData];
}

- (void)loadJSON:(NSString *)subreddit withLimit:(NSInteger)limit withName:(NSString *) name {
    NSString *formattedURL = [NSString stringWithFormat:@"http://www.reddit.com/r/%@.json?limit=%ld", subreddit, limit];
    if (name) {
        formattedURL = [NSString stringWithFormat:@"http://www.reddit.com/r/%@.json?limit=%ld&after=%@", subreddit, limit, name];
    }
    NSURL *url;
    url = [NSURL URLWithString: formattedURL];
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    
    NSMutableDictionary *results = [json valueForKey:@"data"];
    NSMutableDictionary *posts = [results valueForKey:@"children"];
    
    for(NSDictionary * dict in posts)
    {
        bool nsfw = NO;
        NSMutableDictionary *postdata = [dict valueForKey:@"data"];
        Link *link = [[Link alloc] init];
        link.title = [postdata valueForKey:@"title"];
        link.author = [postdata valueForKey:@"author"];
        link.ups = [NSString stringWithFormat:@"%@", [postdata valueForKey:@"ups"]];
        link.downs = [NSString stringWithFormat:@"%@", [postdata valueForKey:@"downs"]];
        link.score = [NSString stringWithFormat:@"%@", [postdata valueForKey:@"score"]];
        link.comments = [NSString stringWithFormat:@"%@", [postdata valueForKey:@"num_comments"]];
        link.subreddit = [postdata valueForKey:@"subreddit"];
        
        link.name = [postdata valueForKey:@"name"];
        
        if ([[postdata valueForKey:@"thumbnail"] isEqualToString:@"self"]) {
            link.thumbnail = [UIImage imageNamed:@"icon"];
        }
        if (!link.thumbnail) {
            link.thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[postdata valueForKey:@"thumbnail"]]]];
        }
        
        if ([[postdata valueForKey:@"over_18"] boolValue] == YES) {
            link.thumbnail = [UIImage imageNamed:@"nsfw"];
            nsfw = YES;
        }
        
        link.url = [postdata valueForKey:@"url"];
        
        bool contained = NO;
        for (Link *temp in _links) {
            if ([temp.name isEqualToString:link.name]) {
                contained = YES;
            }
        }
        if (!contained && !nsfw)
            [_links addObject: link];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_links count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinkCell"];
    
    Link *link = _links[indexPath.row];
    
    UILabel *linkLabel = (UILabel *)[cell viewWithTag:100];
    linkLabel.text = link.title;
    
    UILabel *authorLabel = (UILabel *)[cell viewWithTag:102];
    authorLabel.text = link.author;
    
    UILabel *scoreLabel = (UILabel *)[cell viewWithTag:104];
    scoreLabel.text = link.score;
    
    UILabel *downsLabel = (UILabel *)[cell viewWithTag:105];
    downsLabel.text = link.downs;
    
    UILabel *commentsLabel = (UILabel *)[cell viewWithTag:106];
    commentsLabel.text = link.comments;
    
    UILabel *subredditLabel = (UILabel *)[cell viewWithTag:107];
    subredditLabel.text = link.subreddit;
    
    UIImageView *thumbnailView = (UIImageView *)[cell viewWithTag:101];
    thumbnailView.image = link.thumbnail;
    
    return cell;
}

//- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
//
//}


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"WebKitSegue"]) {
         NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
         WebKitViewController *webKitViewController = [segue destinationViewController];
         webKitViewController.link = (self.links)[selectedRowIndex.row];
//         [_links removeObjectAtIndex:selectedRowIndex.row];
//         [self.tableView reloadData];
     }
 }

@end
