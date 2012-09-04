//
//  BYGameEngine.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKGeometry.h>

@class      BYQuiz;
@protocol   BYGameEngineProtocol;


@interface BYGameEngine : NSObject {
    
    NSTimeInterval      _quizStartTimeInterval;
    BYQuiz*             _quiz;          /// current quiz
    NSUInteger          _pointsGained;
    NSUInteger          _numberQuiz;
    NSTimer*            _quizFailTimer;
}

- (id) init;
- (void) reload;        /// on init, after all quizes finished

- (void) pauseQuiz;     /// go background
- (void) startQuiz;     /// come back from bgd

- (void) startNewQuiz;

- (void) processQuizAnswerCoordinate: (CLLocationCoordinate2D) coordinate; /// user tapped mapView

@property (readonly) NSTimeInterval     quizTimePassed;
@property (readonly) NSString*          quizTask;
@property (readonly) NSUInteger         totalPoints;
@property (readonly) NSUInteger         pointsForLastQuiz;

@property (weak) id <BYGameEngineProtocol> delegate;

@end



@protocol BYGameEngineProtocol <NSObject>

@required

- (void) BYGameEngineTimeRanOut:        (BYGameEngine*) engine;
- (void) BYGameEngineLastQuizFinished:  (BYGameEngine*) engine;
- (void) BYGameEngineQuizFinished:      (BYGameEngine*) engine;

@end