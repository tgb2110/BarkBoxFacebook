//
//  DogsHardcoded.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "DogsHardcoded.h"
#import "TMTDog.h"

@implementation DogsHardcoded

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeTwentyDogs];
    }
    return self;
}

-(void)makeTwentyDogs {
    self.dogs = [NSMutableArray new];
}

@end
