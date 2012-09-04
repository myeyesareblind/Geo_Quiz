//
//  BYMainTableViewController.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYMainTableViewController.h"

@interface BYMainTableViewController ()

@end

@implementation BYMainTableViewController


typedef enum {
    BYMainMenuStartGame,
    BYMainMenuLeaderBoard,
    BYMainMenuOptions
} BYMainMenuRowEnum;


NSString * const SigMap = @"sMap";
NSString * const SigLeaderBoard = @"sLeaderBoard";
NSString * const SigOptions = @"sOptions";


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (NSString*) tableViewCellTextForRow: (BYMainMenuRowEnum) row {
    NSString * retString;
    switch (row) {
        case BYMainMenuStartGame:
            retString = NSLocalizedString(@"kStartGame_MainMenu", NULL);
            break;
        case BYMainMenuLeaderBoard:
            retString = NSLocalizedString(@"kLeaderBoard_MainMenu", NULL);
            break;
        case BYMainMenuOptions:
            retString = NSLocalizedString(@"kOptions_MainMenu", NULL);
            break;
        default:
            assert(0);
            break;
    }
    return retString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:tableView.style reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self tableViewCellTextForRow: indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BYMainMenuRowEnum row = (BYMainMenuRowEnum) indexPath.row;
    NSString *sigId;
    switch (row) {
        case BYMainMenuStartGame:
            sigId = SigMap;
            break;
        case BYMainMenuLeaderBoard:
            sigId = SigLeaderBoard;
            break;
        case BYMainMenuOptions:
            sigId = SigOptions;
            break;
        default:
            assert(0);
            break;
    }
    [self performSegueWithIdentifier:sigId sender:self];
}
@end
