//
//  BYMainScreenSegue.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYMainScreenSegue.h"

@implementation BYMainScreenSegue

- (void) perform {
    [self.destinationViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self.sourceViewController presentModalViewController:self.destinationViewController animated:YES];
}
@end