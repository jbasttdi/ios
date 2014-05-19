//
//  MusioMainMenuViewController.m
//  Musio
//
//  Created by Oli Young on 19/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioMenuViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@implementation MusioMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    UIFont* font = [UIFont fontWithName:@"NeuzeitGro-Reg" size:20];

    UIButton* inboxButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [[inboxButton titleLabel] setFont:font];
    [[inboxButton titleLabel] setTextAlignment:NSTextAlignmentLeft];
    [inboxButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [inboxButton setContentEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 0)];
    [inboxButton setFrame:CGRectMake(20, 20, 270, 50)];
    [inboxButton setTitle:@"Inbox" forState:UIControlStateNormal];
    [inboxButton addTarget:self
                    action:@selector(inboxButtonSelector:)
          forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:inboxButton];

    UIButton* uploadsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [[uploadsButton titleLabel] setFont:font];
    [uploadsButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [uploadsButton setContentEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 0)];
    [uploadsButton setFrame:CGRectMake(20, 80, 270, 50)];
    [uploadsButton setTitle:@"Uploads" forState:UIControlStateNormal];
    [uploadsButton addTarget:self
                      action:@selector(uploadsButtonSelector:)
            forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:uploadsButton];

    UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [[settingsButton titleLabel] setFont:font];
    [settingsButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [settingsButton setContentEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 0)];
    [settingsButton setFrame:CGRectMake(20, 220, 270, 50)];
    [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
    [settingsButton addTarget:self
                       action:@selector(settingsButtonSelector:)
             forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:settingsButton];

    UIButton* helpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [[helpButton titleLabel] setFont:font];
    [helpButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [helpButton setContentEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 0)];
    [helpButton setFrame:CGRectMake(20, 280, 270, 50)];
    [helpButton setTitle:@"Help" forState:UIControlStateNormal];
    [helpButton addTarget:self
                       action:@selector(helpButtonSelector:)
             forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:helpButton];

    UILabel* copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 540, [UIScreen mainScreen].bounds.size.width, 20)];
    [copyrightLabel setText:@"©2014 Musio Pty Ltd"];
    [copyrightLabel setTextColor:[UIColor colorWithRed:0.502 green:0.502 blue:0.502 alpha:1.000]];
    [copyrightLabel setFont:[UIFont fontWithName:@"NeuzeitGro-Reg" size:12]];

    [[self view] addSubview:copyrightLabel];
}

- (void) inboxButtonSelector:(id)sender {
    UINavigationController* mainNavigation = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainNavigation"];
    [[self sidePanelController] setCenterPanel: mainNavigation];
}

- (void) settingsButtonSelector:(id)sender {
    UINavigationController* settingsView = [[self storyboard] instantiateViewControllerWithIdentifier:@"settingsView"];
    [[self sidePanelController] setCenterPanel: settingsView];

}

- (void) uploadsButtonSelector:(id)sender {
    UINavigationController* uploadNavigation = [[self storyboard] instantiateViewControllerWithIdentifier:@"uploadNavigation"];
    [[self sidePanelController] setCenterPanel: uploadNavigation];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
