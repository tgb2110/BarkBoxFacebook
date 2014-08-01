//
//  TMTDog.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTDog : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *breed;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *imageURL;

- (instancetype)init;
-(instancetype)initWithName:(NSString *)initName WithBreed:(NSString *)initBreed WithAge:(NSString *)initAge WithDistance:(NSString *)initDistance WithBio:(NSString *)initBio WithDogImage:(UIImage *)dogImage;

@end
