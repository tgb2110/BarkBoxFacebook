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
#import "DogsHardcoded.h"

@interface TMTSharePupViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) IBOutlet UICollectionView *dogCollectionView;

@end

@implementation TMTSharePupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DogsHardcoded *dogsToLoad = [DogsHardcoded new];
    self.dogCollectionView.dataSource = self;
    self.dogCollectionView.delegate = self;
    self.dogs = dogsToLoad.dogs;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
//    for (NSInteger i = 1; i < 19; i ++) {
//        TMTDog *dog = [TMTDog new];
//        dog.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
//        [self.dogs addObject:dog];
//    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.dogs count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMTSharePupCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"dogCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    TMTDog *dog = self.dogs[indexPath.row];
    cell.dogImage.image = dog.image;
    
    return cell;
}

// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    TMTDetailDogViewController *nextVC = [TMTDetailDogViewController new];
//    nextVC.dog = self.dogs[indexPath.row];
//    [self.navigationController pushViewController:nextVC animated:YES];
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // 2
    CGSize retval = CGSizeMake(80, 80);
    retval.height += 10;
    retval.width += 10;
    return retval;
}
// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *ip = [self.dogCollectionView indexPathForCell:sender];
    TMTDog *dog = self.dogs[ip.row];;
    TMTDetailDogViewController *nextVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"detailDogSegue"]) {
        nextVC.dog = dog;
    }
}

@end
