//
//  TMTEventDetailViewController.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/4/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTEvent.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TMTEventDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *map;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UITextView *description;

- (IBAction)addToCalander:(id)sender;
- (IBAction)postToFB:(id)sender;

@property (strong, nonatomic) TMTEvent *event;
@property (strong, nonatomic) PFObject *currentUser;

@end
