//
//  TMTAnnotation.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/4/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTAnnotation.h"

@implementation TMTAnnotation

- (instancetype) initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)title subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        _coordinate = coord;
        _title = title;
        _subtitle = subtitle;
    }
    return self;
}

@end
