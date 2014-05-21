//
//  MusioUploadTableViewController.m
//  Musio
//
//  Created by Oli Young on 19/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioUploadsTableViewController.h"

@interface MusioUploadsTableViewController ()
@property NSMutableArray *tracks;
@end

@implementation MusioUploadsTableViewController

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

    [[MusioAPIClient sharedClient] getTracksWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [self setTracks: responseObject];
        [[self tableView] reloadData];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure -- %@", error);
    }];
    [[self navigationItem] setTitle:@"Uploads"];
    [[[self navigationController] navigationBar] setAlpha:0.500];
    [[[self navigationController] navigationBar] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"NeuzeitGro-Bol" size:24.0f]
                                                            }];
    [[self tableView] setBackgroundColor: [UIColor colorWithRed:0.125 green:0.125 blue:0.125 alpha:1.000]];
    [[self tableView] setSeparatorColor: [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:0.500]];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self tracks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* track = [[self tracks] objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uploadViewCell" forIndexPath:indexPath];

    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:cell.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0.169 green:0.169 blue:0.169 alpha:1.000]];

    [cell setSelectedBackgroundView:backgroundView];
    [cell setBackgroundColor:[UIColor colorWithRed:0.125 green:0.125 blue:0.125 alpha:1.000]];

    [[cell textLabel] setTextColor: [UIColor whiteColor]];
    [[cell textLabel] setText: [track valueForKey:@"title"]];
    [[cell textLabel] setFont: [UIFont fontWithName:@"NeuzeitGro-Bol" size:24]];

    [[cell detailTextLabel] setTextColor: [UIColor whiteColor]];
    [[cell detailTextLabel] setText: [track valueForKey:@"description"]];
    [[cell detailTextLabel] setFont: [UIFont fontWithName:@"NeuzeitGro-Reg" size:15]];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     MusioUploadViewController * destination = [segue destinationViewController];
     [destination setTrack:[[self tracks] objectAtIndex:indexPath.row]];
 }


@end
