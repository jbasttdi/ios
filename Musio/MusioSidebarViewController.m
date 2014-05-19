//
//  MusioMenuViewController.m
//  Musio
//
//  Created by Oli Young on 18/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioSidebarViewController.h"


@interface MusioSidebarViewController ()

@end

@implementation MusioSidebarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}



- (void)viewDidLoad
{
    [self setLeftPanel: [[self storyboard] instantiateViewControllerWithIdentifier:@"mainMenu"]];
    [self setCenterPanel: [[self storyboard] instantiateViewControllerWithIdentifier:@"mainNavigation"]];

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
