//
//  PhotoscollectionViewController.m
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "NewPhotoViewController.h"
#import "PhotoModel.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoViewController.h"



@implementation PhotosCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndic stopAnimating];
 
    [[PhotoModel instance] getAsynch:[self wdId] block:^(NSArray * photos) {
        self.data = photos;
        [self.collectionView reloadData];
        [self.activityIndic stopAnimating];
        self.activityIndic.hidden = YES;
    }];
    
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
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        PhotoViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destViewController.workPhoto = self.data[indexPath.row];
       
        //destViewController.workPhoto = self.data[0];
        //destViewController.delegate = self;
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    
    if ([segue.identifier isEqualToString:@"addPhotoSegue"]) {
        NewPhotoViewController* newPhotoVC = segue.destinationViewController;
        newPhotoVC.wdId = [self wdId];
        newPhotoVC.delegate = self;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell"  forIndexPath:indexPath];

    // Init photo cell values
    Photo* pto = [self.data objectAtIndex:indexPath.row];
    cell.imageName = pto.imageName;
    cell.ptoId = pto.ptoId;
    cell.image.image = [UIImage imageNamed:pto.imageName];
    
    /*if (cell.image.image == nil)
    {
         cell.image.image = [UIImage imageNamed:@"no_photo.jpg"];
    }*/
    
   
    // Fetch the image by name
    cell.image.image = nil;
    [cell.activityIndic startAnimating];
    if(pto.imageName != nil && ![pto.imageName isEqualToString:@""]){
        [[PhotoModel instance] getImage:pto block:^(UIImage *image) {
            if ([cell.imageName isEqualToString:pto.imageName]){
                cell.activityIndic.hidden = YES;
                if (image != nil) {
                    cell.image.image = image;
                    [cell.activityIndic stopAnimating];
                }else{
                    cell.image.image = [UIImage imageNamed:@"no_photo.jpg"];
                }
            }
        }];
    }else{
       cell.image.image = [UIImage imageNamed:@"no_photo.jpg"];
    }
    
    return cell;
}

-(void)onSave:(Photo*)pto uiImage:(UIImage*)uiImage {
    
    [[PhotoModel instance] getAsynch:[self wdId] block:^(NSArray * photos) {
        self.data = photos;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.data count] - 1) inSection:0];
         //[self.collectionView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.collectionView insertItemsAtIndexPaths: @[indexPath]];
        
        //[self.collectionView reloadData];
        //[self.activityIndic stopAnimating];
        //self.activityIndic.hidden = YES;
    }];
    
    //[self.activityIndic stopAnimating];
    //[self.btnAdd setEnabled:YES];
}

@end
