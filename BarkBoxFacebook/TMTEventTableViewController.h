//
//  TMTEventTableViewController.h
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/4/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DummyDataStore.h"

@interface TMTEventTableViewController : UITableViewController
@property (strong, nonatomic) DummyDataStore *dataStore;

@end
