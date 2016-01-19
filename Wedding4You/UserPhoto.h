//
//  PhotosTableViewController.h
//  three
//
//  Created by Admin on 11/24/15.
//  Copyright © 2015 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPhoto.h"
#import "Photo.h"

@protocol getPhotoDelegate <NSObject>

-(void)onSave:(NSString*)imageName uiImage:(UIImage*)uiImage;

@end

@interface UserPhoto :UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property id<getPhotoDelegate> delegate;


@property (nonatomic, strong) NSArray* data;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;

@end
