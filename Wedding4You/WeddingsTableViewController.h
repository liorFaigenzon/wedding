//
//  WeddingTableViewController.h
//  Wedding4You
//
//  Created by Admin on 1/14/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeddingsTableViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray* data;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
