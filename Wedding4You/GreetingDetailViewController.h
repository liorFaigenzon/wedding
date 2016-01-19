//
//  GreetingDetailViewController.h
//  Wedding4You
//
//  Created by Admin on 1/17/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Greeting.h"

@interface GreetingDetailViewController : UIViewController


@property  Greeting* greetingToShow;
@property (weak, nonatomic) IBOutlet UIView *ViewContainer;
@property (weak, nonatomic) IBOutlet UILabel *dateGRT;
@property (weak, nonatomic) IBOutlet UILabel *titleGRT;
@property (weak, nonatomic) IBOutlet UITextView *greetingGRT;

@end
