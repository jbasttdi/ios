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

    UIButton* logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [[logoutButton titleLabel] setFont:[UIFont fontWithName:@"NeuzeitGro-Reg" size:15]];
    [logoutButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [logoutButton setContentEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 0)];
    [logoutButton setFrame:CGRectMake(20, 520, 270, 50)];
    [logoutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [logoutButton addTarget:self
                       action:@selector(logoutButtonSelector:)
             forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:logoutButton];

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

}

- (void) logoutButtonSelector:(id)sender {
    [Lockbox setString:nil forKey:@"token"];
    [Lockbox setString:nil forKey:@"email"];
    [Lockbox setString:nil forKey:@"password"];
    [Lockbox setString:nil forKey:@"uuid"];

    UIViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"WelcomeView"];
    [self presentViewController:controller animated:YES completion:^{}];

}

- (void) helpButtonSelector:(id)sender {
    UIViewController* helpViewNavigation = [[self storyboard] instantiateViewControllerWithIdentifier:@"helpView"];
    [[self sidePanelController] setCenterPanel: helpViewNavigation];

}

- (void) inboxButtonSelector:(id)sender {
    UINavigationController* mainNavigation = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainNavigation"];
    [[self sidePanelController] setCenterPanel: mainNavigation];
}

- (void) settingsButtonSelector:(id)sender {
    UIViewController* settingsView = [[self storyboard] instantiateViewControllerWithIdentifier:@"settingsView"];
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
