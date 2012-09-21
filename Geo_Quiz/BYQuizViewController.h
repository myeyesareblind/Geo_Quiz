//
//  BYQuizViewController.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYGameEngine.h"


@class MKMapView;

typedef void (^Block)();


@interface BYQuizViewController : UIViewController <BYGameEngineProtocol, MKMapViewDelegate> {
    BYGameEngine*       _gameEngine;
    NSTimer*            _viewRefreshTimer;

    Block               _onQuizFinishedBlock;
}

@property (nonatomic, weak) IBOutlet UIButton*      quitButton;
@property (nonatomic, weak) IBOutlet UIButton*      helpButton;
@property (nonatomic, weak) IBOutlet UIButton*      pauseButton;
@property (nonatomic, weak) IBOutlet MKMapView*     mapView;
@property (nonatomic, weak) IBOutlet UILabel*       timerLabel;
@property (nonatomic, weak) IBOutlet UILabel*     quizTaskLabel;

@end