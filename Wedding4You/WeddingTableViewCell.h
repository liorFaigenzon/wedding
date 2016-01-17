//
//  WeddingTableViewCell.h
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeddingTableViewCell : UITableViewCell

@property NSString* wdId;
@property NSString* imageName;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dateString;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;

@end
