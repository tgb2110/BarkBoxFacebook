//
//  TMTDetailDogViewController.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTDetailDogViewController.h"
#import "TMT_API_Calls.h"

@interface TMTDetailDogViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *dogImage;

@property (strong, nonatomic) IBOutlet UILabel *nameInfo;

@property (strong, nonatomic) IBOutlet UILabel *breedInfo;

@property (strong, nonatomic) IBOutlet UILabel *ageInfo;

@property (strong, nonatomic) IBOutlet UILabel *distanceInfo;

@property (strong, nonatomic) IBOutlet UITextView *bioInfo;

- (IBAction)postToFB:(id)sender;

@end

@implementation TMTDetailDogViewController

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
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dogImage.image = self.dog.image;
    self.nameInfo.text = self.dog.name;
    self.ageInfo.text = self.dog.age;
    self.breedInfo.text = self.dog.breed;
    self.distanceInfo.text = self.dog.distance;
    self.bioInfo.text = self.dog.bio;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)postToFB:(id)sender {
    //run this on a background thread
    NSOperationQueue *newQueue = [[NSOperationQueue alloc]init];
    [newQueue addOperationWithBlock:^{
        // retrieve current user from parse
        [TMT_API_Calls retrieveCurrentUserWithUserObject:self.currentUser WithCompletion:^(BOOL success) {
            if (success) {
                // present share dialog box to user
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               self.dog.name, @"name",
                                               self.dog.age, @"caption",
                                               self.dog.bio, @"description",
                                               @"https://developers.facebook.com/docs/ios/share/", @"link",
                                               self.dog.imageURL, @"picture",
                                               nil];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [TMT_API_Calls postNotUsingNativeFacebookAppWithUserObject:self.currentUser WithParams:params];
                    
                }];
            }
        }];
    }];
}

//- (void)postNotUsingNativeFacebookAppWithUserObject:(PFObject *)userObject {
//    // Put together the dialog parameters
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   self.dog.name, @"name",
//                                   self.dog.age, @"caption",
//                                   self.dog.bio, @"description",
//                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
//                                   @"http://leapdogtraining.com/images/1.jpg", @"picture",
//                                   nil];
//
//    // Show the feed dialog
//    [FBWebDialogs presentFeedDialogModallyWithSession:nil
//                                           parameters:params
//                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
//
//
//
//                                                  if (error) {
//                                                      // An error occurred, we need to handle the error
//                                                      // See: https://developers.facebook.com/docs/ios/errors
//                                                      NSLog(@"Error publishing story: %@", error.description);
//                                                  } else {
//                                                      if (result == FBWebDialogResultDialogNotCompleted) {
//                                                          // User cancelled.
//                                                          NSLog(@"User cancelled.");
//                                                      } else {
//                                                          // Handle the publish feed callback
//                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
//
//                                                          if (![urlParams valueForKey:@"post_id"]) {
//                                                              // User cancelled.
//                                                              NSLog(@"User cancelled.");
//
//                                                          } else {
//                                                              __block NSInteger currentDonationAmount =  [userObject[@"DonationCounter"] integerValue];
//                                                              currentDonationAmount ++;
//                                                              userObject[@"DonationCounter"] = [NSNumber numberWithInt:currentDonationAmount];
//                                                              // object never saves to Parse
//                                                              [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                                                                  NSLog(@"%hhd", succeeded);
//                                                              }];
//                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
//                                                              NSLog(@"result %@", result);
//                                                          }
//                                                      }
//                                                  }
//                                              }];
//}
//- (NSDictionary*)parseURLParams:(NSString *)query {
//    NSArray *pairs = [query componentsSeparatedByString:@"&"];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    for (NSString *pair in pairs) {
//        NSArray *kv = [pair componentsSeparatedByString:@"="];
//        NSString *val =
//        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        params[kv[0]] = val;
//    }
//    return params;
//}
@end
