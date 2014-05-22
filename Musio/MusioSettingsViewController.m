//
//  MusioSettingsViewController.m
//  Musio
//
//  Created by Oli Young on 18/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioSettingsViewController.h"

@interface MusioSettingsViewController ()
@property UIView *settingsForm;
@property UIScrollView *scrollView;
@property UITextField *emailField;
@property UITextField *passwordField;
@property UITextField *nameField;

@end

@implementation MusioSettingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIColor* backgroundColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.000];
    UIFont* font = [UIFont fontWithName:@"NeuzeitGro-Reg" size:20];

    [self setScrollView:[[UIScrollView alloc] initWithFrame: CGRectMake(0, 00, width, 470)]];
    [self setSettingsForm:[[UIView alloc] initWithFrame: CGRectMake(0, 0, width, 2000)]];


    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out."
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(signOut)];

    [self setNameField: [[UITextField alloc] initWithFrame: CGRectMake(20, 80, (width - 40), 50)]];
    [[self nameField] setBackgroundColor:backgroundColor];
    [[self nameField] setFont:font];
    [[self nameField] setText:[Lockbox stringForKey:@"name"]];
    [[self nameField] setTextColor: [UIColor whiteColor]];
    [[self nameField] setDelegate:self];
    [[self nameField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self nameField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self nameField] setPlaceholder:@"Your Name"];
    [[self nameField] setKeyboardAppearance: UIKeyboardAppearanceDark];
    [[self settingsForm] addSubview:[self nameField]];

    [self setEmailField: [[UITextField alloc] initWithFrame: CGRectMake(20, 150, 280, 50)]];
    [[self emailField] setBackgroundColor:backgroundColor];
    [[self emailField] setText:[Lockbox stringForKey:@"email"]];
    [[self emailField] setFont:font];
    [[self emailField] setTextColor: [UIColor whiteColor]];
    [[self emailField] setDelegate:self];
    [[self emailField] setKeyboardType: UIKeyboardTypeEmailAddress];
    [[self emailField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self emailField] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self emailField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self emailField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self emailField] setPlaceholder:@"Your Email Address"];
    [[self emailField] setKeyboardAppearance: UIKeyboardAppearanceDark];
    [[self settingsForm] addSubview:[self emailField]];


    UIView* notificationsToggleView = [[UIView alloc] initWithFrame: CGRectMake(20, 210, 280, 50)];

    UILabel* notificationsToggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 180, 50)];
    [notificationsToggleLabel setText:@"Notifications?"];
    [notificationsToggleLabel setTextColor:[UIColor whiteColor]];
    [notificationsToggleLabel setFont:font];

    UISwitch* notificationsSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 40, 50)];
//    [notificationsSwitch addTarget:self
//                            action:@selector(toggleNotifications:)
//                  forControlEvents:UIControlEventTouchUpInside];
    [notificationsToggleView addSubview:notificationsSwitch];
    [notificationsToggleView addSubview:notificationsToggleLabel];
    [[self scrollView] addSubview:notificationsToggleView];

    self.scrollView.contentSize = self.settingsForm.bounds.size;
    [[self scrollView] addSubview:[self settingsForm]];

    [[self view] addSubview:[self scrollView]];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self navigationItem] setRightBarButtonItem:saveButton];
    [super viewWillAppear:animated];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[self scrollView] scrollRectToVisible:textField.frame animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self saveSettings];
}

- (void)toggleNotications:(id)sender
{
    if([sender isOn]){
        NSLog(@"Notifications On");
    } else {
        NSLog(@"Notifications Off");
    }
}

- (void)saveSettings
{
    NSLog(@"Save Settings");
}

- (void)signOut
{
    [Lockbox setString:nil forKey:@"token"];
    [Lockbox setString:nil forKey:@"email"];
    [Lockbox setString:nil forKey:@"password"];
    [Lockbox setString:nil forKey:@"uuid"];

    UIViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"WelcomeView"];
    [self presentViewController:controller animated:YES completion:^{}];
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
