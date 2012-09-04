//
//  BYQuizViewController.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;
@class BYGameEngine;

@interface BYQuizViewController : UIViewController {
    BYGameEngine *_gameEngine;
}

@property (nonatomic, weak) IBOutlet UIButton *quitButton;
@property (nonatomic, weak) IBOutlet UIButton *helpButton;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
