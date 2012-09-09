//
//  BYLeaderBoardTableViewCell.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/9/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYLeaderBoardTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet    UILabel     *placeLabel;
@property (nonatomic, strong) IBOutlet    UILabel     *dateLabel;
@property (nonatomic, strong) IBOutlet    UILabel     *nameLabel;
@property (nonatomic, strong) IBOutlet    UILabel     *ptsGainedLabel;
@end