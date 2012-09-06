//
//  BYAnnotation.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/6/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYAnnotation.h"


@implementation BYAnnotation

@synthesize tag;
@synthesize coordinate;
@synthesize title, subtitle;

- (id) initWithCoordinate: (CLLocationCoordinate2D) coord Tag: (int) tag_ {
    self = [super init];
    if (self) {
        self.coordinate         = coord;
        self.tag                = tag_;
    }
    return self;
}

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

@end
