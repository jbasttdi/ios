//
//  MusioViewController.m
//  Musio
//
//  Created by Oli Young on 7/03/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioViewController.h"

@interface MusioViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *MainWebView;

@end

@implementation MusioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *fullURL = @"http://beta.musio.co";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_MainWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
