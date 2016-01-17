//
//  WeddingTableViewController.m
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "WeddingTableViewController.h"
#import "DetailWeddingViewController.h"
#import "WeddingTableViewCell.h"
#import "GreetingsTableViewController.h"
#import "PhotosCollectionViewController.h"
#import "WeddingModel.h"
#import "LoginModel.h"
#import "GreetingModel.h"
#import "Utilities.h"
#import "Greeting.h"
#import "Comment.h"
#import "CommentModel.h"
#import "PhotoModel.h"
#import "Photo.h"

@interface WeddingTableViewController () {
    NSArray* data;
}

@end

@implementation WeddingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self activityIndic] startAnimating];
    
    // Load weddings to data source
    [[WeddingModel instance] getWeddingsHostGuest:^(NSArray * weddings) {
        data = weddings;
        [self.tableView reloadData];
        [[self activityIndic] stopAnimating];
        [self activityIndic].hidden = YES;
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get reusable cell for wedding
    WeddingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeddingCell" forIndexPath:indexPath];
    
    // Init wedding cell values
    Wedding* wd = [data objectAtIndex:indexPath.row];
    cell.wdId = wd.wdId;
    cell.name.text = [NSString stringWithFormat:@"%@ %@'s wedding", wd.usCouple.fName, wd.usCouple.lName];
    cell.dateString.text = [Utilities getDateStringFromDate:wd.date];
    cell.imageName = wd.imageName;
    
    // Fetch the image by name
    cell.image.image = nil;
    [cell.activityIndic startAnimating];
    if(wd.imageName != nil && ![wd.imageName isEqualToString:@""]){
        [[WeddingModel instance] getImage:wd block:^(UIImage *image) {
            if ([cell.imageName isEqualToString:wd.imageName]){
                cell.activityIndic.hidden = YES;
                if (image != nil) {
                    cell.image.image = image;
                    [cell.activityIndic stopAnimating];
                }else{
                    cell.image.image = [UIImage imageNamed:@"wedding.jpg"];
                }
            }
        }];
    }else{
        cell.image.image = [UIImage imageNamed:@"wedding.jpg"];
    }
    
    return cell;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailWeddingSegue"]) {
        // Get wedding of selected cell
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Wedding* wedding = [data objectAtIndex:indexPath.row];
        
        UITabBarController* tabVC = segue.destinationViewController;
        
        DetailWeddingViewController* detailVC = [tabVC.viewControllers objectAtIndex:0];
        [tabVC navigationItem].title = [NSString stringWithFormat:@"%@ %@'s wedding", wedding.usCouple.fName, wedding.usCouple.lName];
        detailVC.wedding = wedding;
        
        GreetingsTableViewController* greetingsVC = [tabVC.viewControllers objectAtIndex:1];
        greetingsVC.wdId = wedding.wdId;
        
        PhotosCollectionViewController* photosVC = [tabVC.viewControllers objectAtIndex:2];
        photosVC.wdId = wedding.wdId;
        //WeddingTableViewCell *cell = (WeddingTableViewCell*)sender;
    }
}


- (IBAction)logout:(id)sender {
    [self.activityIndic startAnimating];
    self.activityIndic.hidden = NO;
    [[LoginModel instance] logout: ^(void) {
        self.activityIndic.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
