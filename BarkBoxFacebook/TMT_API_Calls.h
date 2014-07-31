//
//  TMT_API_Calls.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 7/31/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMTLoginViewController.h"

@interface TMT_API_Calls : NSObject

+(void)retrieveCurrentUserWithUserObject:(PFObject *)userObject WithCompletion:(void (^)(BOOL))retrieveUser;

+(void)presentFacebookShareWithUserObject:(PFObject *)userObject;

+(void)postNotUsingNativeFacebookAppWithUserObject:(PFObject *)userObject;

+(void)postUsingNativeFacebookAppWithUserObject:(PFObject *)userObject;

+(NSDictionary*)parseURLParams:(NSString *)query;

@end
