//
//  MusioSignInViewController.m
//  Musio
//
//  Created by Oli Young on 17/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//
#import "MusioAPIClient.h"
#import "MusioSignInViewController.h"

@interface MusioSignInViewController ()
@property UITextField *emailField;
@property UITextField *passwordField;
@end

@implementation MusioSignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    UIColor* backgroundColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.000];
    UIFont* font = [UIFont fontWithName:@"NeuzeitGro-Reg" size:20];

    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 50, 270, 120)];
    [titleLabel setText: @"Sign In."];
    [titleLabel setFont: [UIFont fontWithName:@"NeuzeitGro-Bol" size:24]];
    [titleLabel setTextColor: [UIColor whiteColor]];
    [[self view] addSubview:titleLabel];


    [self setEmailField: [[UITextField alloc] initWithFrame: CGRectMake(20, 135, 270, 50)]];
    [[self emailField] setBackgroundColor:backgroundColor];
    [[self emailField] setFont:font];
    [[self emailField] setTextColor: [UIColor whiteColor]];
    [[self emailField] setDelegate:self];
    [[self emailField] setKeyboardType: UIKeyboardTypeEmailAddress];
    [[self emailField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self emailField] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self emailField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self emailField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self emailField] setKeyboardAppearance: UIKeyboardAppearanceDark];
    [[self emailField] setPlaceholder:@"Your Email Address"];
    [[self view] addSubview:[self emailField]];

    [self setPasswordField: [[UITextField alloc] initWithFrame: CGRectMake(20, 205, 270, 50)]];
    [[self passwordField] setBackgroundColor:backgroundColor];
    [[self passwordField] setFont:font];
    [[self passwordField] setTextColor: [UIColor whiteColor]];
    [[self passwordField] setDelegate:self];
    [[self passwordField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self passwordField] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self passwordField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self passwordField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self passwordField] setPlaceholder:@"Your Password"];
    [[self passwordField] setKeyboardAppearance: UIKeyboardAppearanceDark];
    [[self passwordField] setSecureTextEntry:YES];
    [[self view] addSubview:[self passwordField]];


    UIButton* signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signUpButton setFrame:CGRectMake(20, 275, 270, 50)];
    [signUpButton setImage:[UIImage imageNamed:@"Go.png"] forState:UIControlStateNormal];
    [signUpButton addTarget:self
                     action:@selector(signIn:)
           forControlEvents:UIControlEventTouchUpInside];

    [[self view] addSubview:signUpButton];

    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signIn:(id)sender
{
    [self.view endEditing:YES];

    MusioAPIClient *client = [MusioAPIClient sharedClient];
    [client signIn:[[self emailField] text]
      withPassword:[[self passwordField] text]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               NSMutableDictionary* session = [[NSMutableDictionary alloc] initWithDictionary: (NSMutableDictionary *)responseObject];
               NSLog(@"%@", session);
               [Lockbox setString:[[self emailField] text] forKey:@"email"];
               [Lockbox setString:[[self passwordField] text] forKey:@"password"];
               [Lockbox setString:[session objectForKey:@"uuid"]  forKey:@"uuid"];
               [Lockbox setString:[session objectForKey:@"token"] forKey:@"token"];
               UINavigationController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainNavigation"];
               [self presentViewController:controller animated:YES completion:^{}];
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something's Gone Wrong"
                                                                   message:[error localizedDescription]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
               [alertView show];
           }];
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
