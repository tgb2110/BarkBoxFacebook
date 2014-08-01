//
//  TMTDog.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTDog.h"

@implementation TMTDog

- (instancetype)init {
    return [self initWithName:@"Jacob" WithBreed:@"Boxer/Greyhound" WithAge:@"5 years young" WithDistance:@"Too Far" WithBio:@"Jacob is simply amazing" WithDogImage:[UIImage imageNamed:@"dogPlaceholder.png"]];
}

- (instancetype)initWithName:(NSString *)initName WithBreed:(NSString *)initBreed WithAge:(NSString *)initAge WithDistance:(NSString *)initDistance WithBio:(NSString *)initBio WithDogImage:(UIImage *)dogImage {
    self = [super init];
    if (self) {
        _name = initName;
        _breed = initBreed;
        _age = initAge;
        _distance = initDistance;
        _bio = initBio;
        _image = dogImage;
    }
    return self;
}

@end
