//
//  WeddingTableViewController.m
//  Wedding4You
//
//  Created by Admin on 1/14/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "WeddingsTableViewController.h"
#import "WeddingModel.h"
#import "WeddingTableViewCell.h"

@implementation WeddingsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[WeddingModel instance] getWeddingsHostGuest:@"uiac1YRCiz" block:^(NSArray * stArray) {
        self.data = stArray;
    }];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    //[super setEditing:editing animated:animated];
    //[self.tableView setEditing:editing animated:animated];
    if (editing) {
        // addButton.enabled = NO;
    } else {
        //addButton.enabled = YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[[WeddingModel instance] deleteWedding:(Wedding*)[self.data objectAtIndex:indexPath.row]];
        //[self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //WeddingTableViewCell *cell = (WeddingTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeddingCell" forIndexPath:indexPath];
    Wedding* st = [self.data objectAtIndex:indexPath.row];
    
    //cell.Id = st.stId;
    //cell.fname.text = st.fname;
    //cell.lname.text = st.lname;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NewWeddingSegue"]) {
        //NewWeddingController* newSVC = segue.destinationViewController;
        ///newSVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"detailWeddingSegue"]) {
        // DetailsWeddingController* DetailSVC = segue.destinationViewController;
        //WeddingTableViewCell *cell = (WeddingTableViewCell*)sender;
        
        // Wedding* st = [[weddingImpl instance] getWedding:cell.Id];
        
        //DetailSVC.DetailWedding = st;
    }
}

-(void)onSave:(Wedding *)std{
    //[[weddingImpl instance] addWedding:std];
    //[self.tableView reloadData];
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
