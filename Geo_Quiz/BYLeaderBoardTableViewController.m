//
//  BYLeaderBoardTableViewController.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/9/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYLeaderBoardTableViewController.h"
#import "BYSQLLeaderBoardWrapper.h"
#import "BYLeaderBoardTableViewCell.h"

@interface BYLeaderBoardTableViewController ()

- (void)backNavigationItemHandler:(id)sender;

@end

@implementation BYLeaderBoardTableViewController
@synthesize backNavigationItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [BYSQLLeaderBoardWrapper sharedDataBaseWrapper];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataSource = [BYSQLLeaderBoardWrapper sharedDataBaseWrapper]; 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backNavigationItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                       target:self
                                                                       action:@selector(backNavigationItemHandler:)];
    self.navigationItem.rightBarButtonItem = backNavigationItem;
}

- (void)viewDidUnload
{
    [self setBackNavigationItem:nil];
    self.backNavigationItem = NULL;
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
    return [_dataSource dataBaseRecords].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"defCell";
    BYLeaderBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == NULL) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BYLeaderBoardTableViewCell"
                                                                 owner:nil
                                                               options:nil];
        cell = (BYLeaderBoardTableViewCell*) [topLevelObjects objectAtIndex:0];
    }
    
    BYLeaderBoardDataBaseRecord *record = [[_dataSource dataBaseRecords] objectAtIndex:indexPath.row];
    cell.nameLabel.text  = record.name;
    cell.placeLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    cell.dateLabel.text  = [record.date description];
    cell.ptsGainedLabel.text = [NSString stringWithFormat:@"%d", record.pts];
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)backNavigationItemHandler:(id)sender {
    
    [self performSegueWithIdentifier:SigToMain
                              sender:self];
}
@end
