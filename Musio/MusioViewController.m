//
//  MusioViewController.m
//  Musio
//
//  Created by Oli Young on 7/03/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioViewController.h"
#import "MusioAPIClient.h"

@interface MusioViewController ()

@property (nonatomic, strong) NSArray *arrTrackData;
@property (nonatomic, strong) NSString *dataFilePath;

@end

@implementation MusioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dataFilePath]) {
        self.arrTrackData = [[NSMutableArray alloc] initWithContentsOfFile:self.dataFilePath];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    self.dataFilePath = [docDirectory stringByAppendingPathComponent:@"data"];
    [self refreshData];
}

- (void)loadTracksIntoViews
{
    NSLog(@"Loading Tracks Into Views -- %@", [[self arrTrackData] objectAtIndex:0] );
}

- (void)refreshData
{
    if (self.arrTrackData != nil) {
        self.arrTrackData = nil;
    }

    MusioAPIClient *client = [MusioAPIClient sharedClient];
    [client getInbox:@"43834c5c-bcbb-40f2-9ed4-444ba301946f"
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 self.arrTrackData = [[NSArray alloc] initWithArray:responseObject];
                 if (![self.arrTrackData writeToFile:self.dataFilePath atomically:YES]) {
                     NSLog(@"Couldn't save data.");
                 }
                 [self loadTracksIntoViews];
                 NSLog(@"Success -- %@", self.arrTrackData);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"Failure -- %@", error);
             }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
