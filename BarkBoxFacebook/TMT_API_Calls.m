//
//  TMT_API_Calls.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 7/31/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMT_API_Calls.h"
#import <Parse/Parse.h>

@implementation TMT_API_Calls

+(void)retrieveCurrentUserWithUserObject:(PFObject *)userObject WithCompletion:(void (^)(BOOL))retrieveUser {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    PFUser *currentUser = [PFUser currentUser];
    userObject = [query getObjectWithId:currentUser.objectId];
    retrieveUser(YES);
}

+(void)presentFacebookShareWithUserObject:(PFObject *)userObject {
    // in the completion block if it is good then run ...
    
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        [self performSelectorOnMainThread:@selector(postUsingNativeFacebookAppWithUserObject:) withObject:userObject waitUntilDone:YES];
    } else {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Sharing Tutorial", @"name",
                                       @"Build great social apps and get more installs.", @"caption",
                                       @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                       @"https://developers.facebook.com/docs/ios/share/", @"link",
                                       @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                       nil];
        [self performSelectorOnMainThread:@selector(postNotUsingNativeFacebookAppWithUserObject:WithParams:) withObject:@[userObject,params] waitUntilDone:YES];
    }
}

+ (void)postNotUsingNativeFacebookAppWithUserObject:(PFObject *)userObject WithParams:(NSDictionary *)params {

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
                                                              __block NSInteger currentDonationAmount =  [userObject[@"DonationCounter"] integerValue];
                                                              currentDonationAmount ++;
                                                              userObject[@"DonationCounter"] = [NSNumber numberWithInt:currentDonationAmount];
                                                              // object never saves to Parse
                                                              [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                                  NSLog(@"%hhd", succeeded);
                                                              }];
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
}

+ (void)postUsingNativeFacebookAppWithUserObject:(PFObject *)userObject {
    
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    [FBDialogs presentShareDialogWithLink:params.link
                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                      
                                      // increment counter and push back up to parse
                                      
                                      if(error) {
                                          // An error occurred, we need to handle the error
                                          // See: https://developers.facebook.com/docs/ios/errors
                                          NSLog(@"Error publishing story: %@", error.description);
                                      } else {
                                          __block NSInteger currentDonationAmount =  [userObject[@"DonationCounter"] integerValue];
                                          currentDonationAmount ++;
                                          userObject[@"DonationCounter"] = [NSNumber numberWithInt:currentDonationAmount];
                                          [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                              NSLog(@"%hhd", succeeded);
                                          }];
                                          NSLog(@"result %@", results);
                                      }
                                  }];
}

// A function for parsing URL parameters returned by the Feed Dialog.
+ (NSDictionary*)parseURLParams:(NSString *)query {
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

@end
