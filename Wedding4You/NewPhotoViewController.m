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
        UserPhoto *firmyVC = [segue destinationViewController];
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
    self.imageView.image = uiImage;
    
    self.workPhoto =[[Photo alloc] init:nil title:self.uititle.text date:[NSDate date] descriptionPt:self.descriptionPt.text imageName:imageName wdId:[self wdId] usId:nil];
    //.text imageName:imageName wdId:self.wdId usId:self.usId];
}

- (IBAction)savePhoto:(id)sender {
    Photo* pto = self.workPhoto;
    //self.workPhoto.imageName = self.imageView.
    pto.title = self.uititle.text;
    pto.descriptionPt = self.descriptionPt.text;
    
    UIImage* image = (UIImage *)self.imageView.image;
    [[PhotoModel instance] addPhoto:pto block:^(NSError * err) {
        [[PhotoModel instance] saveImage:pto image:image block:^(NSError *err)
         {
             if (err != nil)
                 NSLog(@"Error:%@", err.description);
             else
                 [[self delegate] onSave:pto uiImage:image];
         }];
    }];
    
    // Load photo on photos collection screen
    [self.navigationController popViewControllerAnimated:YES];
 
    /*Photo* pto1 = [[Photo alloc] init:nil title:@"kiril" date:[NSDate date] descriptionPt:@"this is kigelman and refaeli" imageName:@"k1.jpg" wdId:wd.wdId usId:nil];
    [[PhotoModel instance] addPhoto:pto1 block:^(NSError * err) {
        NSLog(@"added");
        
        [[PhotoModel instance] saveImage:pto1 image:[UIImage imageNamed:@"k1.jpg"] block:^(NSError * err) {
            NSLog(@"saved");
        }];
    }];*/
}
@end
