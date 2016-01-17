//
//  DetailWeddingViewController.h
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wedding.h"

@interface DetailWeddingViewController : UIViewController

@property Wedding* wedding;

@property (weak, nonatomic) IBOutlet UILabel *marriedCouple;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property NSString* imageName;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;

@end