//
//  MusioHelpViewController.m
//  Musio
//
//  Created by Oli Young on 19/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioHelpViewController.h"
#import "SVGKit/SVGKit.h"
#import "SVGKFastImageView.h"

@interface MusioHelpViewController ()

@end

@implementation MusioHelpViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    UILabel* copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 535, [UIScreen mainScreen].bounds.size.width, 20)];
    [copyrightLabel setText:@"©2014 Musio Pty Ltd"];
    [copyrightLabel setTextColor:[UIColor colorWithRed:0.502 green:0.502 blue:0.502 alpha:1.000]];
    [copyrightLabel setFont:[UIFont fontWithName:@"NeuzeitGro-Reg" size:12]];
    [[self view] addSubview:copyrightLabel];

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
