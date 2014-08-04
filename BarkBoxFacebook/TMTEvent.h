//
//  TMTEvents.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/4/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTEvent : NSObject

@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) NSString *eventLocationName;
@property (strong, nonatomic) NSDate *eventDate;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) UIImage *eventImage;
@property (strong, nonatomic) NSString *imageURL;

@end
