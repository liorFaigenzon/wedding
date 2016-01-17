//
//  CommentsTableViewController.h
//  three
//
//  Created by Admin on 11/24/15.
//  Copyright © 2015 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentViewController.h"

@interface CommentsTableViewController :UIViewController <NewCommentDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray* data;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end