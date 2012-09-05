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

typedef enum  {
    BYGameQuizState_NotStarted,
    BYGameQuizState_Running,
    BYGameQuizState_Paused,
    BYGameQuizState_Finished,
} BYGameQuizState;

@interface BYGameEngine : NSObject {
    
    NSTimeInterval      _quizStartTimeInterval;
    BYQuiz*             _quiz;          /// current quiz
    NSUInteger          _pointsGained;
    NSUInteger          _pointsGainedForLastQuiz;
    NSUInteger          _numberQuiz;
    NSTimer*            _quizFailTimer;
    BYGameQuizState     _state;
}

- (id) init;
- (void) reload;        /// on init, after all quizes finished

- (void) pauseQuiz;     /// go background
- (void) startQuiz;     /// come back from bgd

- (void) startNewGame;
- (void) startNewQuiz;

- (BOOL) canStartNewQuiz;
- (void) processQuizAnswerCoordinate: (CLLocationCoordinate2D) coordinate; /// user tapped mapView

@property (readonly) NSTimeInterval     quizTimeLeft;
@property (readonly) NSString*          quizTask;
@property (readonly) NSUInteger         totalPoints;
@property (readonly) NSUInteger         pointsForLastQuiz;
@property (readonly) BYGameQuizState    gameQuizState;

@property (weak) id <BYGameEngineProtocol> delegate;

@end



@protocol BYGameEngineProtocol <NSObject>

@required

- (void) BYGameEngineTimeRanOut:        (BYGameEngine*) engine;
- (void) BYGameEngineLastQuizFinished:  (BYGameEngine*) engine;
- (void) BYGameEngineQuizStarted:       (BYGameEngine*) engine;
- (void) BYGameEngineQuizFinished:      (BYGameEngine*) engine;

@end