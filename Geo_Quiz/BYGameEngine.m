//
//  BYGameEngine.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYGameEngine.h"
#import "BYQuiz.h"

const   NSUInteger          NumberOfQuizesPerRound     =   2;
const   NSUInteger          QuizDifficultyMultiplier   =   500;
const   NSTimeInterval      TimePerQuiz                =   30.0; /// seconds
const   NSUInteger          CBY_MaxDistance            =   226; /// sqrt( 2 * 160 * 160);

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
    }
    return self;
}

- (void) reload {
    _state                  = BYGameQuizState_NotStarted;
    _pointsGained           = 0;
    _quiz                   = NULL;
    _numberQuiz             = 0;
    _quizStartTimeInterval  = 0;
    
    [_quizFailTimer invalidate];
}

- (BYGameQuizState) gameQuizState {
    return _state;
}

- (NSString *) quizTask {
    return _quiz.task;
}

- (NSTimeInterval) quizTimeLeft {
    
    return (TimePerQuiz - (
            [NSDate timeIntervalSinceReferenceDate] - _quizStartTimeInterval)); /// time passed
}

- (BOOL) canStartNewQuiz {
    return (_state == BYGameQuizState_Running
            && _numberQuiz < (NumberOfQuizesPerRound * BYQuizDifficulty_Hard));
}


- (void) pauseQuiz {
    
}

- (void) startQuiz {
    
}


- (void) startNewGame {
    [self reload];
    _state                 = BYGameQuizState_Running;
}

- (void) startNewQuiz {
    NSAssert( [self canStartNewQuiz],
             @"Trying to start quiz, start new game first, or check for quiz counter");
    
    _quizStartTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    _quizFailTimer         = [NSTimer timerWithTimeInterval:TimePerQuiz
                                                     target:self
                                                   selector:@selector(quizFailHandler)
                                                   userInfo:NULL
                                                    repeats:NO];
    _quiz                  = [BYQuiz randomQuizWithDifficulty: [self _currentQuizDifficulty]];
    _pointsGainedForLastQuiz = 0;
    
    _numberQuiz ++;
    [delegate BYGameEngineQuizStarted: self];
}


- (void) quizFailHandler {
    [delegate BYGameEngineTimeRanOut: self];
}



- (void) processQuizAnswerCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [_quizFailTimer invalidate];
    
    /// process quiz, get poins
    _pointsForLastQuiz = [self _pointsForQuiz: _quiz
                                   WithAnswer: coordinate];
    _pointsGained += _pointsForLastQuiz;
    
    [delegate BYGameEngineQuizFinished: self];
    
    /// check for if this is last quiz
    if ( _numberQuiz == NumberOfQuizesPerRound * BYQuizDifficulty_Hard) {
        
        _state  = BYGameQuizState_Finished;
        
        [delegate BYGameEngineLastQuizFinished: self];
        
        return ;
    }
}



- (NSUInteger)  _pointsForQuiz: (BYQuiz *) quiz WithAnswer: (CLLocationCoordinate2D) answCoord {
    /// get distance etc
    double distance = sqrt( pow(abs(quiz.answerCoordinate.latitude - answCoord.latitude),2)
                           +  pow(abs(quiz.answerCoordinate.longitude - answCoord.longitude),2));
    float distancePercent = 1 - distance / CBY_MaxDistance;
    
    return  distancePercent * quiz.difficulty * QuizDifficultyMultiplier;
}



- (BYQuizDifficulty) _currentQuizDifficulty {
    return 1 + ( _numberQuiz / NumberOfQuizesPerRound);
}


- (void) dealloc {
    [_quizFailTimer invalidate];
}

@end