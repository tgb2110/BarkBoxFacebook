//
//  TMTSharePupViewController.m
//  BarkBoxFacebook
//
//  Created by Troy Barrett on 8/1/14.
//  Copyright (c) 2014 TMT. All rights reserved.
//

#import "TMTSharePupViewController.h"
#import "TMTSharePupCollectionViewCell.h"
#import "TMTDetailDogViewController.h"
#import "TMTDog.h"

@interface TMTSharePupViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *dogCollectionView;

@end

@implementation TMTSharePupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataStore = [DummyDataStore sharedDataStore];
    
    self.dogCollectionView.dataSource = self;
    self.dogCollectionView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.dataStore.dogs count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMTSharePupCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"dogCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    TMTDog *dog = self.dataStore.dogs[indexPath.row];
    cell.dogImage.image = dog.image;
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize retval = CGSizeMake(80, 80);
    retval.height += 10;
    retval.width += 10;
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *ip = [self.dogCollectionView indexPathForCell:sender];
    TMTDog *dog = self.dataStore.dogs[ip.row];;
    TMTDetailDogViewController *nextVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"detailDogSegue"]) {
        nextVC.currentUser = self.dataStore.currentUser;
        nextVC.dog = dog;
    }
}

@end
