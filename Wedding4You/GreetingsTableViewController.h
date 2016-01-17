//
//  GreetingsTableViewController.h
//  three
//
//  Created by Admin on 11/24/15.
//  Copyright © 2015 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreetingViewController.h"

@interface GreetingsTableViewController :UIViewController <NewGreetingDelegate,UITableViewDelegate, UITableViewDataSource>

@property NSString* wdId;
@property (nonatomic, strong) NSArray* data;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;
@end
