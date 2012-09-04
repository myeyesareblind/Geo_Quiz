//
//  BYGameEngine.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYGameEngine.h"
#import "BYQuiz.h"

const   NSUInteger          NumberOfQuizesPerRound     =   5;
const   NSUInteger          QuizDifficultyMultiplier   =   500;
const   NSTimeInterval      TimePerQuiz                =   30.0; /// seconds

@interface BYGameEngine ()

- (void) quizFailHandler;

@end


@implementation BYGameEngine

@synthesize delegate;

- (id) init {
    self = [super init];
    if (self) {
        [self reload];
    }
    return self;
}

- (void) reload {
    
    _pointsGained           = 0;
    _quiz                   = NULL;
    _numberQuiz             = 0;
    _quizStartTimeInterval  = 0;
    
    [_quizFailTimer invalidate];
}


- (NSString *) quizTask {
    return _quiz.task;
}

- (NSTimeInterval) quizTimePassed {
    return ([NSDate timeIntervalSinceReferenceDate] - _quizStartTimeInterval);
}


- (void) pauseQuiz {
    
}

- (void) startQuiz {
    
}

- (void) startNewQuiz {
    _numberQuiz ++;
    
    _quizStartTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    _quizFailTimer         = [NSTimer timerWithTimeInterval:TimePerQuiz
                                                     target:self
                                                   selector:@selector(quizFailHandler)
                                                   userInfo:NULL
                                                    repeats:NO];
}


- (void) quizFailHandler {
    
    [delegate BYGameEngineTimeRanOut: self];
}



- (void) processQuizAnswerCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [_quizFailTimer invalidate];
    
    /// process quiz, get poins
    
    [delegate BYGameEngineQuizFinished: self];
    
    /// check for if this is last quiz
    if ( _numberQuiz == NumberOfQuizesPerRound * BYQuizDifficulty_Hard - 1) {
        
        [delegate BYGameEngineLastQuizFinished: self];
        
        [self reload];
        return ;
    }
    
}


- (BYQuizDifficulty) _currentQuizDifficulty {
    return BYQuizDifficulty_Undefined + ( _numberQuiz % NumberOfQuizesPerRound);
}


- (void) dealloc {
    [_quizFailTimer invalidate];
}

@end