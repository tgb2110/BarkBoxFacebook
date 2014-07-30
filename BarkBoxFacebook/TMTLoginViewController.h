//
//  TMTViewController.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 7/30/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/Facebook.h>

@interface TMTLoginViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) PFObject *currentUser;

@end
