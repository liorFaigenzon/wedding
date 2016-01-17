//
//  CommentsTableViewController.m
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "CommentModel.h"
#import "CommentTableViewCell.h"
#import "CommentViewController.h"

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.data = [[CommentModel instance] getCommentsForGreeting:@"A65KUSpgEE"];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    NSError* xxx = nil;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[CommentModel instance] deleteComment:(Comment*)[self.data objectAtIndex:indexPath.row] block:^(NSError *xxx)
         {
             self.data = [[CommentModel instance] getCommentsForGreeting:@"A65KUSpgEE"];
             
            
             [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    Comment* com = [self.data objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *result = [formatter stringFromDate:(NSDate *)com.date];
    
    cell.title.text = [NSString stringWithFormat:@"%@ by /%@", com.title, com.usId];
    cell.date.text = result;
    cell.comment.text = com.comment;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NewCommentSegue"]) {
        CommentViewController* newSVC = segue.destinationViewController;
        newSVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"detailCommentSegue"]) {
        //DetailsCommentController* DetailSVC = segue.destinationViewController;
        //CommentTableViewCell *cell = (CommentTableViewCell*)sender;
        
        //Comment* st = [[CommentImpl instance] getComment:cell.Id];
        
        //DetailSVC.DetailComment = st;
    }
}

-(void)onSave:(Comment *)std{
    NSError* xxx  = nil;
    [[CommentModel instance] addComment:std block:^(NSError *xxx)
     {
         self.data = [[CommentModel instance] getCommentsForGreeting:@"A65KUSpgEE"];
         
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.data count] - 1) inSection:0];
         [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     }];
    
    
}
-(void)onCancel{
    //self.myLabel.text = @"cancel";
}

@end
