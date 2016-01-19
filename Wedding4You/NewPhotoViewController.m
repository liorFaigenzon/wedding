//
//  NewPhotoViewController.m
//  Wedding4You
//
//  Created by Admin on 1/16/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "NewPhotoViewController.h"
#import "PhotoModel.h"
#import "UserPhoto.h"
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
        UINavigationController *nav = [segue destinationViewController];
        UserPhoto *firmyVC = (UserPhoto *)nav.topViewController;
        firmyVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"detailWeddingSegue"]) {
        // DetailsWeddingController* DetailSVC = segue.destinationViewController;
        //WeddingTableViewCell *cell = (WeddingTableViewCell*)sender;
        
        // Wedding* st = [[weddingImpl instance] getWedding:cell.Id];
        
        //DetailSVC.DetailWedding = st;
    }
}

-(void)onSave:(NSString *)imageName uiImage:(UIImage *)uiImage{
    self.imageView.image  =uiImage;
    
    NSError* xxx  = nil;
    self.workPhoto =[[Photo alloc] init:@"n" title:self.uititle.text date:[NSDate date] descriptionPt:self.descriptionPt.text imageName:imageName wdId:@"cv1pwjXc6w" usId:@"T7TGFelzuj"];
    //.text imageName:imageName wdId:self.wdId usId:self.usId];
 
    
   
    

     
}

- (IBAction)savePhoto:(id)sender {
    //self.workPhoto.imageName = self.imageView.
    NSError* xxx  = nil;
    self.workPhoto.title = self.uititle.text;
    self.workPhoto.descriptionPt = self.descriptionPt.text;
    [[PhotoModel instance] saveImage:(Photo *)self.workPhoto image:(UIImage *)self.imageView.image block:^(NSError *xxx)
     {
         
     }];
 
    
}
@end
