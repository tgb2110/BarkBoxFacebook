//
//  TMTViewController.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 7/30/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTLoginViewController.h"

@interface TMTLoginViewController ()

- (IBAction)logout:(id)sender;
- (IBAction)postComment:(id)sender;

@end

@implementation TMTLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)checkForLoggedInUser
{
    if (![PFUser currentUser]) {
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"email", nil]];
        [logInViewController setFields: PFLogInFieldsFacebook | PFLogInFieldsDismissButton];
        
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        
        [logInViewController setSignUpController:signUpViewController];
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self checkForLoggedInUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PFLoginViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in with Error: %@...", error);
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self checkForLoggedInUser];
    
}

- (void)postNotUsingNativeFacbookApp {
    // Put together the dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Tutorial", @"name",
                                   @"Build great social apps and get more installs.", @"caption",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  
                                                  
                                                  
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              __block NSInteger currentDonationAmount =  [self.currentUser[@"DonationCounter"] integerValue];
                                                              currentDonationAmount ++;
                                                              self.currentUser[@"DonationCounter"] = [NSNumber numberWithInt:currentDonationAmount];
                                                              [self.currentUser saveInBackground];
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
}

- (void)postUsingNativeFacebookApp:(FBLinkShareParams *)params {
    [FBDialogs presentShareDialogWithLink:params.link
                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                      
                                      // increment counter and push back up to parse
                                      
                                      if(error) {
                                          // An error occurred, we need to handle the error
                                          // See: https://developers.facebook.com/docs/ios/errors
                                          NSLog(@"Error publishing story: %@", error.description);
                                      } else {
                                          __block NSInteger currentDonationAmount =  [self.currentUser[@"DonationCounter"] integerValue];
                                          currentDonationAmount ++;
                                          self.currentUser[@"DonationCounter"] = [NSNumber numberWithInt:currentDonationAmount];
                                          [self.currentUser saveInBackground];
                                          NSLog(@"result %@", results);
                                      }
                                  }];
}

- (IBAction)postComment:(id)sender {
    
    //run this on a background thread
    NSOperationQueue *newQueue = [[NSOperationQueue alloc]init];
    [newQueue addOperationWithBlock:^{
        [self retrieveCurrentUserWithCompletion:^(BOOL success) {
        
            if (success) {
                // in the completion block if it is good then run ...
                
                
                FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
                params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
                
                // If the Facebook app is installed and we can present the share dialog
                if ([FBDialogs canPresentShareDialogWithParams:params]) {
                    [self performSelectorOnMainThread:@selector(postUsingNativeFacebookApp:) withObject:nil waitUntilDone:YES];
                } else {
                    [self performSelectorOnMainThread:@selector(postNotUsingNativeFacbookApp) withObject:nil waitUntilDone:YES];
                }
            }
        }];
    }];
    
    }


// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

-(void)retrieveCurrentUserWithCompletion:(void (^)(BOOL))retrieveUser {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    PFUser *currentUser = [PFUser currentUser];
    self.currentUser = [query getObjectWithId:currentUser.objectId];
    retrieveUser(YES);
}

@end
