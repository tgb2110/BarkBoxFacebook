//
//  TMTEventDetailViewController.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/4/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTEventDetailViewController.h"
#import <EventKitUI/EventKitUI.h>
#import "TMT_API_Calls.h"
#import "TMTAnnotation.h"

@interface TMTEventDetailViewController () <MKMapViewDelegate>

@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation TMTEventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = self.event.eventName;
    self.location.text = self.event.eventLocationName;
    self.date.text = [self.event.eventDate description];
    self.description.text = self.event.eventDescription;
    
    // Do any additional setup after loading the view.
    // event.eventlocationname
    self.geoCoder = [[CLGeocoder alloc] init];
    self.map.delegate = self;
    __block CLLocationCoordinate2D location;
    __block double latitude = 0;
    __block double longitude;
    [self.geoCoder geocodeAddressString:self.event.eventLocationName completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%@", placemarks);
        if (placemarks.count > 0 && error == nil) {
            NSLog(@"Found %lu placemarks", (unsigned long)[placemarks count]);
            CLPlacemark *thePlacemark = placemarks[0];
            latitude = thePlacemark.location.coordinate.latitude;
            longitude = thePlacemark.location.coordinate.longitude;
            location = CLLocationCoordinate2DMake(latitude, longitude);
            [self updateMapViewWithCLLocationCoordinate2D:location];
            [self plotLocationPinWithCLLocationCoordinate2D:location];
        }
    }];

    
}

- (void)updateMapViewWithCLLocationCoordinate2D:(CLLocationCoordinate2D)location {
    // create a region and pass it to the Map View
    MKCoordinateRegion region;
    region.center.latitude = location.latitude;
    region.center.longitude = location.longitude;
    region.span.latitudeDelta = .01;
    region.span.longitudeDelta = .01;
    
    [self.map setRegion:region animated:YES];
    
}

- (void)plotLocationPinWithCLLocationCoordinate2D:(CLLocationCoordinate2D)location {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    double latitudeDouble = location.latitude;
    double longitudeDouble = location.longitude;
    point.coordinate = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble);
    point.title = self.event.eventName;
    point.subtitle = self.event.eventLocationName;
    [self.map addAnnotation:point];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToCalander:(id)sender {
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if (!granted) {
             return;
         }
         EKEvent *event = [EKEvent eventWithEventStore:store];
         event.title = self.event.eventName;
         event.location = self.event.eventLocationName;
         event.startDate = self.event.eventDate; //today
         event.endDate = [event.startDate dateByAddingTimeInterval:60 * 60];  //set 1 hour meeting
         [event setCalendar:[store defaultCalendarForNewEvents]];
         NSError *err = nil;
         [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
     }];
}

- (IBAction)postToFB:(id)sender {
    //run this on a background thread
    NSOperationQueue *newQueue = [[NSOperationQueue alloc]init];
    [newQueue addOperationWithBlock:^{
        // retrieve current user from parse
        [TMT_API_Calls retrieveCurrentUserWithUserObject:self.currentUser WithCompletion:^(BOOL success) {
            if (success) {
                // present share dialog box to user
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               self.event.eventName, @"name",
                                               self.event.eventLocationName, @"caption",
                                               self.event.eventDescription, @"description",
                                               @"https://developers.facebook.com/docs/ios/share/", @"link",
                                               self.event.imageURL, @"picture",
                                               nil];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [TMT_API_Calls postNotUsingNativeFacebookAppWithUserObject:self.currentUser WithParams:params];
                }];
            }
        }];
    }];
    
}

@end
