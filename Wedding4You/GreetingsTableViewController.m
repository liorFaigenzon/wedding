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

@implementation GreetingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //uiac1YRCiz
    self.data = [[GreetingModel instance] getGreetingsforWedding:@"QMJWlc1QI7"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if (editing) {
       // addButton.enabled = NO;
    } else {
        //addButton.enabled = YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
   // if (editingStyle == UITableViewCellEditingStyleDelete) {
     //   [[greetingImpl instance] deleteGreeting:(Greeting*)[self.data objectAtIndex:indexPath.row]];
      //  [self.tableView reloadData];
    //}
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //GreetingTableViewCell *cell = (GreetingTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GreetingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"greetingCell" forIndexPath:indexPath];
    Greeting* grt = [self.data objectAtIndex:indexPath.row];
    
    cell.title.text = grt.title;
    //cell.date.text =grt.date;
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
}

-(void)onSave:(Greeting *)std{
    NSError* xxx  = nil;;
    [[GreetingModel instance] addGreeting:std block:^(NSError *xxx)
    {
        [self.tableView reloadData];
    }];
}
-(void)onCancel{
    //self.myLabel.text = @"cancel";
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
