//
//  MusioSignUpViewController.m
//  Musio
//
//  Created by Oli Young on 17/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioSignUpViewController.h"
#import "MusioViewController.h"
#import "MusioAPIClient.h"

@interface MusioSignUpViewController ()
@property UIView* signUpForm;
@property UITextField *emailField;
@property UITextField *passwordField;
@property UITextField *nameField;
@end

@implementation MusioSignUpViewController

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

    CGRect formFrame = CGRectMake(0, 50, 320, 520);
    [self setSignUpForm: [[UIView alloc] initWithFrame: formFrame]];
    [[self signUpForm] setBackgroundColor: [UIColor colorWithHue:0.000 saturation:0.000 brightness:0.173 alpha:0.2]];

    UIColor* backgroundColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.000];
    UIFont* font = [UIFont fontWithName:@"NeuzeitGro-Reg" size:20];

    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, -10, 270, 120)];
    [titleLabel setText: @"Sign Up."];
    [titleLabel setFont: [UIFont fontWithName:@"NeuzeitGro-Bol" size:24]];
    [titleLabel setTextColor: [UIColor whiteColor]];
    [[self signUpForm] addSubview:titleLabel];

    [self setNameField: [[UITextField alloc] initWithFrame: CGRectMake(20, 75, 270, 50)]];
    [[self nameField] setBackgroundColor:backgroundColor];
    [[self nameField] setFont:font];
    [[self nameField] setTextColor: [UIColor whiteColor]];
    [[self nameField] setDelegate:self];
    [[self nameField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self nameField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self nameField] setPlaceholder:@"Your Name"];
    [[self signUpForm] addSubview:[self nameField]];

    [self setEmailField: [[UITextField alloc] initWithFrame: CGRectMake(20, 145, 270, 50)]];
    [[self emailField] setBackgroundColor:backgroundColor];
    [[self emailField] setFont:font];
    [[self emailField] setTextColor: [UIColor whiteColor]];
    [[self emailField] setDelegate:self];
    [[self emailField] setKeyboardType: UIKeyboardTypeEmailAddress];
    [[self emailField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self emailField] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self emailField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self emailField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self emailField] setPlaceholder:@"Your Email Address"];
    [[self signUpForm] addSubview:[self emailField]];


    [self setPasswordField: [[UITextField alloc] initWithFrame: CGRectMake(20, 215, 270, 50)]];
    [[self passwordField] setBackgroundColor:backgroundColor];
    [[self passwordField] setFont:font];
    [[self passwordField] setTextColor: [UIColor whiteColor]];
    [[self passwordField] setDelegate:self];
    [[self passwordField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self passwordField] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self passwordField] setSecureTextEntry:YES];
    [[self passwordField] setLeftView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
    [[self passwordField] setLeftViewMode: UITextFieldViewModeAlways];
    [[self passwordField] setPlaceholder:@"Your Password"];
    [[self signUpForm] addSubview:[self passwordField]];


    UIButton* signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signUpButton setFrame:CGRectMake(30, 285, 260, 50)];
    [signUpButton setImage:[UIImage imageNamed:@"Go.png"] forState:UIControlStateNormal];
    [signUpButton addTarget:self
                     action:@selector(signUp:)
           forControlEvents:UIControlEventTouchUpInside];

    [[self signUpForm] addSubview:signUpButton];

    [[self view] addSubview:[self signUpForm]];
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    CGRect rect = self.signUpForm.frame;
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    self.signUpForm.frame = CGRectMake(0, 30, rect.size.width, rect.size.height);
    [UIView commitAnimations];
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect rect = self.signUpForm.frame;
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    self.signUpForm.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    [UIView commitAnimations];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
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



- (void)signUp:(UIButton*)sender
{

    [self.view endEditing:YES];

    MusioAPIClient *client = [MusioAPIClient sharedClient];
    [client signUp:[[self emailField] text]
        withPassword:[[self passwordField] text]
             andName:[[self nameField] text]
           success:^(NSURLSessionDataTask *task, id responseObject) {
                NSMutableDictionary* user = [[NSMutableDictionary alloc] initWithDictionary: (NSMutableDictionary *)responseObject];
                [Lockbox setString:[user objectForKey:@"email"] forKey:@"email"];
                [Lockbox setString:[user objectForKey:@"name"] forKey:@"name"];
                [Lockbox setString:[user objectForKey:@"uuid"] forKey:@"uuid"];
                [Lockbox setString:[user objectForKey:@"token"] forKey:@"token"];

                MusioViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"InboxView"];
                [self presentViewController:controller animated:YES completion:^{}];
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something's Gone Horribly Wrong"
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
