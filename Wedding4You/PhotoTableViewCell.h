//
//  PhotoTableViewCell.h
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* title;
@property (weak, nonatomic) IBOutlet UILabel*date;
@property (weak, nonatomic) IBOutlet UILabel* descriptionPt;
@property (weak, nonatomic) IBOutlet UILabel* imageName;

@property (weak, nonatomic) IBOutlet UILabel* ptoId;;
@property (weak, nonatomic) IBOutlet UILabel* wdId;

@end
