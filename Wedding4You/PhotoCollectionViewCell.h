//
//  PhotoTableViewCell.h
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView* image;

@property NSString* ptoId;
@property NSString* wdId;


@end
