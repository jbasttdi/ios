//
//  MusioUploadViewController.m
//  Musio
//
//  Created by Oli Young on 16/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioUploadViewController.h"
#import "MusioUploadStatisticsTableViewController.h"
#import "SVGKit/SVGKit.h"
#import "SVGKFastImageView.h"
#import "AFSoundManager.h"

@interface MusioUploadViewController ()

@end

@implementation MusioUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Share"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(share:)];
    [[self navigationItem] setRightBarButtonItem:shareButton];


    [[[self navigationController] navigationBar] setTitleTextAttributes: @{
                                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                           NSFontAttributeName: [UIFont fontWithName:@"NeuzeitGro-Bol" size:24.0f]
                                                                           }];

    UILabel* trackTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 75, (width - 80), 50)];
    [trackTitleLabel setText: [[self track] valueForKeyPath:@"title"]];
    [trackTitleLabel setTextColor:[UIColor whiteColor]];
    [trackTitleLabel setFont:[UIFont fontWithName:@"NeuzeitGro-Bol" size:20]];
    [[self view] addSubview:trackTitleLabel];

    SVGKImage* playImage = [SVGKImage imageNamed:@"play-xl"];
    [playImage setSize:CGSizeMake(40, 40)];
    SVGKImageView* playImageView = [[SVGKFastImageView alloc] initWithSVGKImage:playImage];
    CGRect playImageFrame = CGRectMake(20, 80, 40, 40);
    UIView* playImageContainer = [[UIView alloc] initWithFrame: playImageFrame];
    [playImageContainer setUserInteractionEnabled:true];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playTouch:)];
    [singleTap setNumberOfTapsRequired:1];
    [playImageContainer addGestureRecognizer:singleTap];
    [playImageContainer addSubview:playImageView];
    [[self view] addSubview: playImageContainer];

    MusioUploadStatisticsTableViewController* statisticsTableView = [MusioUploadStatisticsTableViewController alloc];
    UITableView *statisticsView = [[UITableView alloc] initWithFrame:CGRectMake(0, (height/2), width, height / 2)];
    [statisticsView setBackgroundColor: [UIColor colorWithRed:0.125 green:0.125 blue:0.125 alpha:1.000]];
    [statisticsView setSeparatorColor: [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:0.500]];
    [statisticsView setDelegate: statisticsTableView];

    [[self view] addSubview:statisticsView];

}

- (void)playTouch:(id)sender
{

    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:@"http://www.example.com/audio/file.mp3" andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error) {

        if (!error)
            //This block will be fired when the audio progress increases in 1%
            } else {
                //Handle the error
            }
     }];
    
    NSLog(@"Play Touch");
}
- (void)share:(id)sender
{
    NSLog(@"Share");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
