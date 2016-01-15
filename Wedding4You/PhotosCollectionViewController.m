//
//  PhotoscollectionViewController.m
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "PhotoModel.h"
#import "PhotoCollectionViewCell.h"

@implementation PhotosCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[PhotoModel instance] getPhotosForWedding:@"QMJWlc1QI7"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell"  forIndexPath:indexPath];

    Photo* pto = [self.data objectAtIndex:indexPath.row];
    
    cell.image.image = [UIImage imageNamed:pto.imageName];

    
    return cell;
    

    
    return cell;
}

@end
