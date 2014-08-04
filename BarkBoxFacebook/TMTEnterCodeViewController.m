//
//  TMTEnterCodeViewController.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/4/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTEnterCodeViewController.h"
#import <Parse/Parse.h>


@interface TMTEnterCodeViewController ()
@property (strong, nonatomic) IBOutlet UITextField *codeField;

- (IBAction)submit:(id)sender;

@end

@implementation TMTEnterCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submit:(id)sender {
    if ([self.codeField.text isEqualToString:@"1234"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SUCCESS!" message:@"You've earned $10" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Code!" message:@"The code you have entered is invalid please try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
}

@end
