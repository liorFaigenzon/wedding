//
//  NewPhotoViewController.m
//  Wedding4You
//
//  Created by Admin on 1/16/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "NewPhotoViewController.h"
#import "APPViewController.h"
#import "PhotoModel.h"
@import UIKit;
@import Photos;

@interface NewPhotoViewController ()

@end

@implementation NewPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"GetPhotoSegue"]) {
        APPViewController* newSVC = segue.destinationViewController;
        newSVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"detailWeddingSegue"]) {
        // DetailsWeddingController* DetailSVC = segue.destinationViewController;
        //WeddingTableViewCell *cell = (WeddingTableViewCell*)sender;
        
        // Wedding* st = [[weddingImpl instance] getWedding:cell.Id];
        
        //DetailSVC.DetailWedding = st;
    }
}

-(void)onSave:(NSURL*)newPho uiImage:(UIImage*)uiImage{
    
    // Then get the file name.
    NSString *imageName = [newPho lastPathComponent];
    //NSLog(@"image name is %@", imageName);
   
    //ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //__block UIImage *returnValue = nil;
    //[library assetForURL:newPho resultBlock:^(ALAsset *asset) {
   //     returnValue = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
   // } failureBlock:^(NSError *error) {
    //    NSLog(@"error : %@", error);
    //}];
   
   
    //self.imageView.image = [UIImage imageWithData:data];
   
;
  
    NSError* xxx  = nil;
    self.workPhoto =[[Photo alloc] init:@"n" title:@"n" date:[NSDate date] descriptionPt:@"n" imageName:imageName wdId:imageName usId:imageName];
    UIImage* imageforload = nil;
    Photo* po= nil;
 
    
    [[PhotoModel instance] saveImage:(Photo *)self.workPhoto image:(UIImage *)uiImage block:^(NSError *xxx)
     {
         
     }];
    
    //[[PhotoModel instance] getImage:(Photo *)self.workPhoto block:^(UIImage *uiImage)
     //{
     //    imageforload = imageforload;
    // }];
     
}

- (IBAction)savePhoto:(id)sender {
    //self.workPhoto.imageName = self.imageView.
    NSError* xxx  = nil;

    [[PhotoModel instance] addPhoto:self.workPhoto block:^(NSError *xxx)
     {

     }];
 
    
}
@end
