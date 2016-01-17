//
//  GreetingsTableViewController.m
//  Class4Demo2
//
//  Created by Admin on 11/18/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "GreetingsTableViewController.h"
#import "GreetingModel.h"
#import "GreetingTableViewCell.h"
#import "GreetingViewController.h"
#import "CommentsTableViewController.h"

@implementation GreetingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[GreetingModel instance] getGreetingsforWedding:@"96smXQDaUo"];
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
       [[GreetingModel instance] deleteGreeting:(Greeting*)[self.data objectAtIndex:indexPath.row] block:^(NSError *xxx)
       {
           self.data = [[GreetingModel instance] getGreetingsforWedding:@"96smXQDaUo"];
           
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
    GreetingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"greetingCell" forIndexPath:indexPath];
    Greeting* grt = [self.data objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *result = [formatter stringFromDate:(NSDate *)grt.date];
    
    cell.grtId = grt.grtId;
    cell.title.text = [NSString stringWithFormat:@"%@ by /%@", grt.title, grt.usId];
    cell.date.text = result;
    cell.greeting.text = grt.greeting;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NewGreetingSegue"]) {
       GreetingViewController* newSVC = segue.destinationViewController;
        newSVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"detailGreetingSegue"]) {
        //DetailsGreetingController* DetailSVC = segue.destinationViewController;
        //GreetingTableViewCell *cell = (GreetingTableViewCell*)sender;
        
        //Greeting* st = [[greetingImpl instance] getGreeting:cell.Id];

        //DetailSVC.DetailGreeting = st;
    }
    
    if ([segue.identifier isEqualToString:@"showComments"]) {
        CommentsTableViewController* commentsVC = segue.destinationViewController;
        
        GreetingTableViewCell *cell = (GreetingTableViewCell*)sender;
        commentsVC.grtId = cell.grtId;
    }
}

-(void)onSave:(Greeting *)std{
    [[GreetingModel instance] addGreeting:std block:^(NSError *xxx)
    {
        self.data = [[GreetingModel instance] getGreetingsforWedding:@"96smXQDaUo"];

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.data count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
   
}
-(void)onCancel{
    //self.myLabel.text = @"cancel";
}

@end
