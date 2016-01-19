
//
//  PhotoscollectionViewController.m
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "UserPhoto.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoViewController.h"



@implementation UserPhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndic stopAnimating];
    [[PhotoModel instance] getAsynch:@"XKUGRs9a47" block:^(NSArray * photos) {
        self.data = photos;
         self.collectionView.allowsSelection = YES;
        [self.collectionView reloadData];
        [self.activityIndic stopAnimating];
        self.activityIndic.hidden = YES;
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailPhotogSegue"]) {
        PhotoViewController* newSVC = segue.destinationViewController;
       
        //CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
       // NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        
        //Photo* pto = nil;
        //PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)sender;
        //[[PhotoModel instance] getPhoto:cell.ptoId block:^(Photo* pto)
       // {
        //    newSVC.workPhoto =pto;
        //}];
        //newSVC.workPhoto = self.data[0];
        //newSVC.delegate = self;
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

    // Init photo cell values
    Photo* pto = [self.data objectAtIndex:indexPath.row];
    cell.imageName = pto.imageName;
    cell.ptoId = pto.ptoId;
    
    cell.image.image = [UIImage imageNamed:pto.imageName];
    
    if (cell.image.image == nil)
    {
        cell.image.image = [UIImage imageNamed:@"no_photo.jpg"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selected) {
        cell.window.backgroundColor =[UIColor yellowColor]; // highlight selection
    }
    else
    {
        cell.window.backgroundColor =[UIColor yellowColor]; // Default color
    }
}



- (IBAction)SavePhoto:(id)sender {
    //[self.delegate SavePhoto:];
    
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
   
    
    [self.delegate onSave:cell.imageName uiImage:cell.image.image];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    
}
@end
