//
//  TMTDetailDogViewController.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTDog.h"
#import <Parse/Parse.h>
#import <FacebookSDK/Facebook.h>
#import "DogsDataStore.h"

@interface TMTDetailDogViewController : UIViewController

@property (strong, nonatomic) TMTDog *dog;
@property (strong, nonatomic) PFObject *currentUser;

@end
