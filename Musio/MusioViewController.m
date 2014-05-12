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

@end

@implementation MusioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.arrTrackData != nil) {
        self.arrTrackData = nil;
    }
    MusioAPIClient *client = [MusioAPIClient sharedClient];
    [client getInbox:@"43834c5c-bcbb-40f2-9ed4-444ba301946f"
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"Success -- %@", responseObject);
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
