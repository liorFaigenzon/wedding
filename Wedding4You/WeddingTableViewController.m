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
#import "WeddingModel.h"
#import "LoginModel.h"
#import "GreetingModel.h"
#import "Utilities.h"
#import "Greeting.h"
#import "Comment.h"
#import "CommentModel.h"

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
    
    /*
    Wedding* wd = [[Wedding alloc] init:nil usCouple:nil date:[Utilities getDateFromString:@"2016-05-19 20:00:00"] imageName:nil];
    NSArray* guests = [NSArray arrayWithObjects:@"T7TGFelzuj", @"0dT4ALBdYJ", nil];
    [[WeddingModel instance] addWedding:wd block:^(NSError * err) {
        //[[WeddingModel instance] saveImage:wd image:nil block:^(NSError * err) {
        [[WeddingModel instance] addWeddingGuests:guests toWedding:wd block:^(NSError * err2) {
            
        //}];
        }];
        
        
        Greeting* grt = [[Greeting alloc] init:nil title:@"Gretting no 2" date:[NSDate date] greeting:@"This is a greeting content" wdId:wd.wdId usId:nil];
        [[GreetingModel instance] addGreeting:grt block:^(NSError * err) {
            NSLog(@"added");
            
            Comment* cmt = [[Comment alloc] init:nil title:@"Comment no 1" date:[NSDate date] comment:@"This is the first blabla comment" grtId:grt.grtId usId:nil];
            [[CommentModel instance] addComment:cmt block:^(NSError * err) {
                NSLog(@"added");
            }];
            
            Comment* cmt2 = [[Comment alloc] init:nil title:@"Comment no 1" date:[NSDate date] comment:@"This is the second blablabla" grtId:grt.grtId usId:nil];
            [[CommentModel instance] addComment:cmt2 block:^(NSError * err) {
                NSLog(@"added");
            }];
        }];
        
        Greeting* grt2 = [[Greeting alloc] init:nil title:@"Gretting no 3" date:[NSDate date] greeting:@"This is another greeting content" wdId:wd.wdId usId:nil];
        [[GreetingModel instance] addGreeting:grt2 block:^(NSError * err) {
            NSLog(@"added");
            
            Comment* cmt = [[Comment alloc] init:nil title:@"Comment no 1" date:[NSDate date] comment:@"This is the first comment" grtId:grt2.grtId usId:nil];
            [[CommentModel instance] addComment:cmt block:^(NSError * err) {
                NSLog(@"added");
            }];
            
            Comment* cmt2 = [[Comment alloc] init:nil title:@"Comment no 1" date:[NSDate date] comment:@"This is the second comment" grtId:grt2.grtId usId:nil];
            [[CommentModel instance] addComment:cmt2 block:^(NSError * err) {
                NSLog(@"added");
            }];
        }];
        
        Greeting* grt3 = [[Greeting alloc] init:nil title:@"Gretting no 4" date:[NSDate date] greeting:@"This is the 3rd greeting content" wdId:wd.wdId usId:nil];
        [[GreetingModel instance] addGreeting:grt3 block:^(NSError * err) {
            NSLog(@"added");
            
            Comment* cmt = [[Comment alloc] init:nil title:@"Comment no 1" date:[NSDate date] comment:@"This is the first comment" grtId:grt3.grtId usId:nil];
            [[CommentModel instance] addComment:cmt block:^(NSError * err) {
                NSLog(@"added");
            }];
            
            Comment* cmt2 = [[Comment alloc] init:nil title:@"Comment no 1" date:[NSDate date] comment:@"This is the second comment" grtId:grt3.grtId usId:nil];
            [[CommentModel instance] addComment:cmt2 block:^(NSError * err) {
                NSLog(@"added");
            }];
        }];
    }];*/
    
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
        UITabBarController* tabVC = segue.destinationViewController;
        DetailWeddingViewController* detailVC = [tabVC.viewControllers objectAtIndex:0];
        //WeddingTableViewCell *cell = (WeddingTableViewCell*)sender;
        
        // Get wedding of selected cell
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Wedding* wedding = [data objectAtIndex:indexPath.row];
        [tabVC navigationItem].title = [NSString stringWithFormat:@"%@ %@'s wedding", wedding.usCouple.fName, wedding.usCouple.lName];
        detailVC.wedding = wedding;
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
