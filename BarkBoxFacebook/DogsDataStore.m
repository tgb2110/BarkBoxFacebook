//
//  DogsHardcoded.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "DogsDataStore.h"
#import "TMTDog.h"

@implementation DogsDataStore

+ (instancetype)sharedDataStore {
    static DogsDataStore * sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataStore = [[self alloc] init];
    });
    return sharedDataStore;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentUser = [PFUser currentUser];
        [self makeDogs];
    }
    return self;
}

- (void)makeDogs {
    self.dogs = [NSMutableArray new];
    TMTDog *dogOne = [TMTDog new];
    dogOne.image = [UIImage imageNamed:@"1.jpg"];
    dogOne.name = @"Sugar";
    dogOne.breed = @"PitBull/Mastiff mix";
    dogOne.age = @"4 years young";
    dogOne.distance = @"San Diego, CA";
    dogOne.bio = @"Sugar enjoys walks in the park and strokes on her belly.  Also, peanut butter.";
    dogOne.imageURL = @"http://leapdogtraining.com/images/1.jpg";
    [self.dogs addObject:dogOne];
    TMTDog *dogTwo = [TMTDog new];
    dogTwo.image = [UIImage imageNamed:@"2.jpg"];
    dogTwo.name = @"Leila";
    dogTwo.breed = @"Pit Mix";
    dogTwo.age = @"2 years young";
    dogTwo.distance = @"Morningside Heights, NY (formerly Moscow, Russia)";
    dogTwo.bio = @"Leila was once a secret agent for the KGB she's now laying low in the UWS";
    dogTwo.imageURL = @"http://leapdogtraining.com/images/2.jpg";
    [self.dogs addObject:dogTwo];
    TMTDog *dogThree = [TMTDog new];
    dogThree.image = [UIImage imageNamed:@"3.jpg"];
    dogThree.name = @"Sally";
    dogThree.breed = @"Anatolian Shepherd Dog";
    dogThree.age = @"3 years young";
    dogThree.distance = @"Brooklyn, NY";
    dogThree.bio = @"Sally likes walks through McCarren and then Sunday Fundays at Northern Territory";
    dogThree.imageURL = @"http://leapdogtraining.com/images/3.jpg";
    [self.dogs addObject:dogThree];
    TMTDog *dogFour = [TMTDog new];
    dogFour.image = [UIImage imageNamed:@"4.jpg"];
    dogFour.name = @"Reese";
    dogFour.breed = @"Bernese Mountain Dog";
    dogFour.age = @"4 years young";
    dogFour.distance = @"Warren, NJ";
    dogFour.bio = @"Reese is a ";
    dogFour.imageURL = @"http://leapdogtraining.com/images/4.jpg";
    [self.dogs addObject:dogFour];
    TMTDog *dogFive = [TMTDog new];
    dogFive.image = [UIImage imageNamed:@"5.jpg"];
    dogFive.name = @"Zamia";
    dogFive.breed = @"Caucasian sheep dog";
    dogFive.age = @"8 years young";
    dogFive.distance = @"Tempe, NM";
    dogFive.bio = @"former US Customs bomb sniffe";
    dogFive.imageURL = @"http://leapdogtraining.com/images/5.jpg";
    [self.dogs addObject:dogFive];
    TMTDog *dogSix = [TMTDog new];
    dogSix.image = [UIImage imageNamed:@"6.jpg"];
    dogSix.name = @"Frank";
    dogSix.breed = @"The Man";
    dogSix.age = @"4 years young";
    dogSix.distance = @"San Diego, CA";
    dogSix.bio = @"Frank figured life out early. Broke out, hasn't looked back.";
    dogSix.imageURL = @"http://leapdogtraining.com/images/6.jpg";
    [self.dogs addObject:dogSix];
    TMTDog *dogSeven = [TMTDog new];
    dogSeven.image = [UIImage imageNamed:@"7.jpg"];
    dogSeven.name = @"Peppermint Patty";
    dogSeven.breed = @"Malamute";
    dogSeven.age = @"12 years young";
    dogSeven.distance = @"Princeton, NJ";
    dogSeven.bio = @"Ivy league frat house mascot";
    dogSeven.imageURL = @"http://leapdogtraining.com/images/7.jpg";
    [self.dogs addObject:dogSeven];
    TMTDog *dogEight = [TMTDog new];
    dogEight.image = [UIImage imageNamed:@"8.jpg"];
    dogEight.name = @"Rufus";
    dogEight.breed = @"Old English Sheepdog";
    dogEight.age = @"4 years young";
    dogEight.distance = @"Gloucester, MA";
    dogEight.bio = @"Rufus lkes the better parts of life. Fine cigars and an occassional ball throw.";
    dogEight.imageURL = @"http://leapdogtraining.com/images/8.jpg";
    [self.dogs addObject:dogEight];
    TMTDog *dogNine = [TMTDog new];
    dogNine.image = [UIImage imageNamed:@"9.jpg"];
    dogNine.name = @"Monroe";
    dogNine.breed = @"Plott";
    dogNine.age = @"4 years young";
    dogNine.distance = @"North Caldwell, NJ";
    dogNine.bio = @"Monroe, active, loyal, knows how to have a good time. But also knows when to keep calm and carry on.";
    dogNine.imageURL = @"http://leapdogtraining.com/images/9.jpg";
    [self.dogs addObject:dogNine];
}

@end
