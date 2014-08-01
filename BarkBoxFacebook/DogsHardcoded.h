//
//  DogsHardcoded.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface DogsHardcoded : NSObject

@property (strong, nonatomic) NSMutableArray *dogs;
@property (strong, nonatomic) PFObject *currentUser;

+ (id)sharedManager;

@end
