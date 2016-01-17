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
#import "PhotoViewController.h"



@implementation PhotosCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[PhotoModel instance] getPhotosForWedding:@"96smXQDaUo"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailPhotogSegue"]) {
        PhotoViewController* newSVC = segue.destinationViewController;
        
        //CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
       // NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        
        Photo* pto = nil;
        //PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)sender;
        //[[PhotoModel instance] getPhoto:cell.ptoId block:^(Photo* pto)
       // {
        //    newSVC.workPhoto =pto;
        //}];
        newSVC.workPhoto = self.data[0];
        newSVC.delegate = self;
    }
    
    //if ([segue.identifier isEqualToString:@"detailPhotogSegue"]) {
        //DetailsPhotoController* DetailSVC = segue.destinationViewController;
        //PhotoTableViewCell *cell = (PhotoTableViewCell*)sender;
        
        //Photo* st = [[PhotoImpl instance] getPhoto:cell.Id];
        
        //DetailSVC.DetailPhoto = st;
    //}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell"  forIndexPath:indexPath];

    Photo* pto = [self.data objectAtIndex:indexPath.row];
    
    cell.image.image = [UIImage imageNamed:pto.imageName];
    cell.ptoId = pto.ptoId;

    
    return cell;
    

    
    return cell;
}

@end
