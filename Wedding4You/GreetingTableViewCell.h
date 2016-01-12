//
//  GreetingTableViewCell.h
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GreetingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel title;
@property (weak, nonatomic) IBOutlet UILabel date;
@property (weak, nonatomic) IBOutlet UILabel greeting;

@property (weak, nonatomic) IBOutlet UILabel grtId;

@end
