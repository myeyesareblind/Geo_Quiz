//
//  BYLeaderBoardTableViewCell.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/9/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYLeaderBoardTableViewCell.h"

@implementation BYLeaderBoardTableViewCell
@synthesize placeLabel, nameLabel, dateLabel, ptsGainedLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
