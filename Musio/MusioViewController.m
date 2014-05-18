//
//  MusioViewController.m
//  Musio
//
//  Created by Oli Young on 7/03/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioViewController.h"
#import "MusioAPIClient.h"
#import "SVGKit/SVGKit.h"
#import "SVGKFastImageView.h"
#import "UIViewController+JASidePanel.h"
#import "MusioMenuViewController.h"
#import <POP/POP.h>

@interface MusioViewController ()

@property (nonatomic, strong) NSArray *arrTrackData;
@property (nonatomic, strong) NSString *dataFilePath;
@property (nonatomic) CGPoint startDragLocation;

@end

@implementation MusioViewController

- (void)viewDidLoad
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dataFilePath]) {
        self.arrTrackData = [[NSMutableArray alloc] initWithContentsOfFile:self.dataFilePath];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    self.dataFilePath = [docDirectory stringByAppendingPathComponent:@"data"];
    [self refreshData];
    [super viewDidLoad];

}

- (void)loadTracksIntoViews
{

    for(NSDictionary* assignment in [self arrTrackData]) {
        NSDictionary* trackData = [assignment valueForKey:@"track"];

        CGRect trackFrame = CGRectMake(20, 100, 280, 370);
        UIView* trackView = [[UIView alloc] initWithFrame: trackFrame];
        [trackView setBackgroundColor: [UIColor colorWithHue:0.000 saturation:0.000 brightness:0.173 alpha:1.000]];

    //    TRACK TITLE
        CGRect titleLabelFrame = CGRectMake(20, 200, 240, 120);
        UILabel* titleLabel = [[UILabel alloc] initWithFrame: titleLabelFrame];
        [titleLabel setText: [trackData valueForKey:@"title"]];
        [titleLabel setFont:[UIFont fontWithName:@"NeuzeitGro-Bol" size:30]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setTextColor: [UIColor whiteColor]];
        [trackView addSubview:titleLabel];

    //    PLAY BUTTON
        SVGKImage* playImage = [SVGKImage imageNamed:@"play-xl"];
        [playImage setSize:CGSizeMake(120, 120)];
        SVGKImageView* playImageView = [[SVGKFastImageView alloc] initWithSVGKImage:playImage];
        CGRect playImageFrame = CGRectMake(80, 20, 120, 120);
        UIView* playImageContainer = [[UIView alloc] initWithFrame: playImageFrame];
        [playImageContainer setUserInteractionEnabled:true];
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playTouch:)];
        [singleTap setNumberOfTapsRequired:1];
        [playImageContainer addGestureRecognizer:singleTap];
        [playImageContainer addSubview:playImageView];
        [trackView addSubview: playImageContainer];

    //    PROGRESS BAR
        CGRect progressBarFrame = CGRectMake(0, 180, 280, 10);
        UIView *progressBarView = [[UIView alloc] initWithFrame:progressBarFrame];
        [progressBarView setBackgroundColor:[UIColor colorWithHue:0.604 saturation:0.615 brightness:0.357 alpha:1.000]];
        [trackView addSubview: progressBarView];
        [trackView setTag: 101010];

        [[self view] addSubview: trackView];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    //    NSString* waveform_url = [NSString stringWithFormat:@"http://musio.s3.amazonaws.com/%@.png", [trackData valueForKey:@"wavefile_uuid"] ];
    //    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:waveform_url]]];
    //    UIImageView *waveformImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,280,175)];
    //    [waveformImage setImage: image];
    //    [trackView addSubview:waveformImage];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"I have finished rotating");
}

-(void)playTouch:(UIGestureRecognizer *)recognizer
{
    NSLog(@"Play Audio");
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [self view] ];
    if ([[touch view] tag] == 101010) {
        [[touch view] setCenter:location];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [self view]];
     if (location.y < 40) {
        NSLog(@"Share Track");
        [[touch view] removeFromSuperview];
    } else if (location.y > (CGRectGetHeight(self.view.bounds) - 40) ) {
        NSLog(@"Save Track");
        [[touch view] removeFromSuperview];
    } else if (location.x < 40) {
        NSLog(@"Dismiss Track");
        [[touch view] removeFromSuperview];
    } else if (location.x > (CGRectGetWidth(self.view.bounds) - 40) ) {
        NSLog(@"Like Track");
        [[touch view] removeFromSuperview];
    } else {
        if ([[touch view] tag] == 101010) {
            [UIView beginAnimations:@"" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [[touch view] setCenter:CGPointMake(160, 285)];
            [UIView commitAnimations];
        }
    }
}


- (IBAction)toggleMenu:(id)sender {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)refreshData
{
    if (self.arrTrackData != nil) {
        self.arrTrackData = nil;
    }

    MusioAPIClient *client = [MusioAPIClient sharedClient];
    [client getInbox:[Lockbox stringForKey:@"uuid"]
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
                 [alertView show];
                 [Lockbox setString:nil forKey:@"token"];
             }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
