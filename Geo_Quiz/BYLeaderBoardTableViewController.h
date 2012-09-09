//
//  BYLeaderBoardTableViewController.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/9/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYSQLLeaderBoardWrapper;
@interface BYLeaderBoardTableViewController : UITableViewController {
    BYSQLLeaderBoardWrapper*    _dataSource;
}

@property (strong, nonatomic) UIBarButtonItem *backNavigationItem;
@end