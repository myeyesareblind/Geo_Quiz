//
//  BYGameEngine.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYGameEngine.h"
#import "BYQuiz.h"
#import "BYSQLQuizDataWrapper.h"
#import "BYSQLLeaderBoardWrapper.h"

const   NSUInteger          QuizDifficultyMultiplier   =   500;
const   NSTimeInterval      TimePerQuiz                =   30.0; /// seconds
const   NSUInteger          CBY_MaxDistance            =   226;  /// sqrt( 2 * 160 * 160);

@interface BYGameEngine ()

- (void) quizFailHandler;
- (NSUInteger)  _pointsForQuiz: (BYQuiz *) quiz WithAnswer: (CLLocationCoordinate2D) answCoord;

@end


@implementation BYGameEngine

@synthesize delegate;
@synthesize totalPoints         = _pointsGained;
@synthesize pointsForLastQuiz   = _pointsForLastQuiz;


- (id) init {
    self = [super init];
    if (self) {
        [self reload];
        _quizDataWrapper = [[BYSQLQuizDataWrapper alloc] init];
    }
    return self;
}

- (void) reload {
    _state                  = BYGameQuizState_NotStarted;
    _pointsGained           = 0;
    _quiz                   = NULL;
    _numberQuiz             = 0;
    _quizStartTimeInterval  = 0;
    _quizPauseTimeLeft    = 0;
    [_quizFailTimer invalidate];
}

- (BYGameQuizState) gameQuizState {
    return _state;
}

- (NSString *) quizTask {
    return _quiz.task;
}

- (NSTimeInterval) quizTimeLeft {
    if (_state == BYGameQuizState_Paused) {
        return _quizPauseTimeLeft;
    }
    
    if (_state == BYGameQuizState_Running) {
        /// ordinary proccess
        NSTimeInterval timeLeftTillFinish = _quizPauseTimeLeft > 0? _quizPauseTimeLeft : TimePerQuiz;
        
        NSTimeInterval timeLeft = (timeLeftTillFinish
                                   - ([NSDate timeIntervalSinceReferenceDate] - _quizStartTimeInterval)); /// time passed
        return timeLeft > 0 ? timeLeft : 0;
    }
    return 0;
}

- (BOOL) canStartNewQuiz {
    return (_state == BYGameQuizState_Running
            && _numberQuiz < (CBY_NumberOfQuizesPerRound * BYQuizDifficulty_Hard));
}


- (void) pauseQuiz {
    if (_state == BYGameQuizState_Running) {
        _quizPauseTimeLeft = [self quizTimeLeft];
        [_quizFailTimer invalidate];
        _state = BYGameQuizState_Paused;
    } else {
        BYLOG(@"cant pause game, its not in the running state");
    }
}



- (void) startQuiz {
    if (_state == BYGameQuizState_Paused) {
        _quizStartTimeInterval = [NSDate timeIntervalSinceReferenceDate];
        _quizFailTimer         = [NSTimer scheduledTimerWithTimeInterval:_quizPauseTimeLeft
                                                                  target:self
                                                                selector:@selector(quizFailHandler)
                                                                userInfo:NULL
                                                                 repeats:NO];
        _state                 = BYGameQuizState_Running;
    } else {
        BYLOG(@"cant continue quiz, its not in paused state");
    }
}


- (void) startNewGame {
    [self reload];
    [_quizDataWrapper loadQuizData];
    _state                 = BYGameQuizState_Running;
}


- (void) startNewQuiz {
    [_quizFailTimer invalidate];
    
    NSAssert( [self canStartNewQuiz],
             @"Trying to start quiz, start new game first, or check for quiz counter");
    
    _quizStartTimeInterval = [NSDate timeIntervalSinceReferenceDate];

    _quizFailTimer         = [NSTimer scheduledTimerWithTimeInterval:TimePerQuiz
                                                              target:self
                                                   selector:@selector(quizFailHandler)
                                                            userInfo:NULL
                                                             repeats:NO];
    _quiz                  = [_quizDataWrapper randomQuizWithDifficulty: [self _currentQuizDifficulty]];
    _pointsGainedForLastQuiz = 0;
    _quizPauseTimeLeft     = 0;
    
    _numberQuiz ++;
    [delegate BYGameEngineQuizStarted: self];
}


- (void) quizFailHandler {
    [self processQuizAnswerCoordinate: CLLocationCoordinate2DInfinity() ];
}



- (void) processQuizAnswerCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [_quizFailTimer invalidate];
    
    /// process quiz, get poins
    _pointsForLastQuiz = [self _pointsForQuiz: _quiz
                                   WithAnswer: coordinate];
    _pointsGained += _pointsForLastQuiz;
    
    /// check for if this is last quiz
    if ( _numberQuiz == CBY_NumberOfQuizesPerRound * BYQuizDifficulty_Hard) {
        
        _state  = BYGameQuizState_Finished;
        
        [[BYSQLLeaderBoardWrapper sharedDataBaseWrapper] pushRecord:
         [[BYLeaderBoardDataBaseRecord alloc] initWithName:[[NSUserDefaults standardUserDefaults] objectForKey:UDBY_UserName]
                                                    points:[self totalPoints]
                                                      date:[NSDate date]]];

        [delegate BYGameEngineLastQuizFinished: self];
        
    } else {
        
        [delegate BYGameEngineQuizFinished: self];
    }
    
    [delegate BYGameEngineProcessQuizAnswerCoordinateAnimation: _quiz.answerCoordinate];
}



- (NSUInteger)  _pointsForQuiz: (BYQuiz *) quiz WithAnswer: (CLLocationCoordinate2D) answCoord {
#warning TODO: pts < 0 fix!
    if (CLLocationCoordinate2DIsValid(answCoord)) {     /// on timer finished loading infinity coordinate
        /// get distance %
        double distance = sqrt( pow(abs(quiz.answerCoordinate.latitude - answCoord.latitude),2)
                               +  pow(abs(quiz.answerCoordinate.longitude - answCoord.longitude),2));
        float distancePercent = 1 - distance / CBY_MaxDistance;
        
        /// get time %
        double timePercent = [self quizTimeLeft] / TimePerQuiz;
        
        return  timePercent * distancePercent * quiz.difficulty * QuizDifficultyMultiplier;
    } else {
        return 0;
    }
}



- (BYQuizDifficulty) _currentQuizDifficulty {
    return 1 + ( _numberQuiz / CBY_NumberOfQuizesPerRound);
}


- (void) dealloc {
    [_quizFailTimer invalidate];
}

@end