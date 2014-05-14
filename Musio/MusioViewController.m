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
    NSDictionary* assignmentData = [[self arrTrackData] objectAtIndex:0];
    NSDictionary* trackData = [assignmentData valueForKey:@"track"];

    CGRect trackFrame = CGRectMake(20, 100, 280, 370);
    UIView* trackView = [[UIView alloc] initWithFrame: trackFrame];
    [trackView setBackgroundColor: [UIColor colorWithHue:0.000 saturation:0.000 brightness:0.173 alpha:1.000]];

    // TRACK TITLE
    CGRect titleLabelFrame = CGRectMake(20, 200, 240, 30);
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: titleLabelFrame];
    [titleLabel setText: [trackData valueForKey:@"title"]];
    [titleLabel setTextColor: [UIColor whiteColor]];
    [trackView addSubview:titleLabel];


    NSString* waveform_url = [NSString stringWithFormat:@"http://musio.s3.amazonaws.com/%@.png", [trackData valueForKey:@"wavefile_uuid"] ];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:waveform_url]]];
    UIImageView *waveformImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,280,175)];
    [waveformImage setImage: image];
    [trackView addSubview:waveformImage];


    // PROGRESS BAR
    CGRect progressBarFrame = CGRectMake(0, 180, 280, 10);
    UIView *progressBarView = [[UIView alloc] initWithFrame:progressBarFrame];
    [progressBarView setBackgroundColor:[UIColor colorWithHue:0.604 saturation:0.615 brightness:0.357 alpha:1.000]];
    [trackView addSubview: progressBarView];

    [[self view] addSubview: trackView];
}

- (void)refreshData
{
    if (self.arrTrackData != nil) {
        self.arrTrackData = nil;
    }

    MusioAPIClient *client = [MusioAPIClient sharedClient];
    [client getInbox:@"43834c5c-bcbb-40f2-9ed4-444ba301946f"
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 self.arrTrackData = [[NSArray alloc] initWithArray: (NSArray*) responseObject];
                 if (![self.arrTrackData writeToFile:self.dataFilePath atomically:YES]) {
                     NSLog(@"Couldn't save data.");
                 }
                 [self loadTracksIntoViews];
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something's Gone Horribly Wrong"
                                                                     message:[error localizedDescription]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"Ok"
                                                           otherButtonTitles:nil];
             }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
