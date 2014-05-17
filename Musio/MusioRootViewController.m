//
//  MusioRootViewController.m
//  Musio
//
//  Created by Oli Young on 17/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioRootViewController.h"

@interface MusioRootViewController ()

@end

@implementation MusioRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([Lockbox stringForKey:@"token"] == nil) {
        [self performSegueWithIdentifier:@"NotLoggedIn" sender:self];
    } else {
        [self performSegueWithIdentifier:@"LoggedIn" sender:self];
    }
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
