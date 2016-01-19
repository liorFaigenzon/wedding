//
//  PhotosTableViewController.h
//  three
//
//  Created by Admin on 11/24/15.
//  Copyright © 2015 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"

@interface PhotosCollectionViewController :UICollectionViewController <NewPhotoDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property NSString* wdId;
@property (nonatomic, strong) NSArray* data;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;

@end
