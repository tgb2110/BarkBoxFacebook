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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dogImage.image = self.dog.image;
    self.nameInfo.text = self.dog.name;
    self.ageInfo.text = self.dog.age;
    self.breedInfo.text = self.dog.breed;
    self.distanceInfo.text = self.dog.distance;
    self.bioInfo.text = self.dog.bio;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
