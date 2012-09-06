//
//  BYAnnotation.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/6/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BYAnnotation : NSObject <MKAnnotation>

- (id) initWithCoordinate: (CLLocationCoordinate2D) coordinate Tag: (int) tag;

@property int tag;        /// tag is used to distingiush ! and ?. Should i add image here?

@end
