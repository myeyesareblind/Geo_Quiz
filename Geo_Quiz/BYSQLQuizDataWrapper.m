//
//  BYSQLQuizDataWrapper.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/8/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYSQLQuizDataWrapper.h"
#import "FMDatabase.h"
#import "BYQuiz.h"


NSString * const TaskValue = @"TaskValue";
NSString * const LatiValue = @"LatiValue";
NSString * const LongValue = @"LongValue";
NSString * const Difficulty = @"Difficulty";
NSString * const kSizeLimit = @"kSizeLimit";


NSString * const kRowTask = @"Task";
NSString * const kRowCoor_Latitute = @"Coordinate_Latitude";
NSString * const kRowCoor_Longtitude = @"Coordinate_Longtitude";
NSString * const kRowDifficulty = @"Difficulty";

@implementation BYSQLQuizDataWrapper
- (id) init {
    self = [super init];
    if (self) {
        _fmDataBase = [[FMDatabase alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"Quiz"
                                                                                       ofType:@"db"]];
        BOOL dbOpened = [_fmDataBase open];
        NSAssert(dbOpened, [_fmDataBase lastErrorMessage]);
    }
    return self;
}

- (void) loadQuizData {
    /// load 3 quiz difficulty with different querys
    _quizesArray = [[NSMutableArray alloc] initWithCapacity: CBY_NumberOfQuizesPerRound * 3];
    
    NSMutableDictionary *paramDictionary = [NSMutableDictionary dictionaryWithDictionary: @{
    kSizeLimit : [NSNumber numberWithInt:CBY_NumberOfQuizesPerRound]
    }];
    
    for (BYQuizDifficulty dif = BYQuizDifficulty_Easy; dif <= BYQuizDifficulty_Hard; dif ++) {
        [paramDictionary setObject:[NSNumber numberWithInt:dif] forKey:Difficulty];
        FMResultSet *resultSet = [_fmDataBase executeQuery:
                                  @"SELECT * FROM Quiz where Difficulty == :Difficulty ORDER BY random() LIMIT :kSizeLimit" withParameterDictionary:paramDictionary];
                
        while ([resultSet next]) {
            BYQuiz *quiz = [[BYQuiz alloc] initWithDescription:[resultSet stringForColumn:kRowTask]
                                              AnswerCoordinate:CLLocationCoordinate2DMake([resultSet doubleForColumn:kRowCoor_Latitute], [resultSet doubleForColumn:kRowCoor_Longtitude])
                                                    Difficulty:[resultSet intForColumn:kRowDifficulty]
                                                   ZoneMapRect:MKMapRectNull];
            [_quizesArray addObject: quiz];
        }
    }
}


- (BYQuiz*) randomQuizWithDifficulty: (BYQuizDifficulty) difficulty_ {
    id retValue = NULL;
    for (BYQuiz* quiz in _quizesArray) {
        if (difficulty_ == quiz.difficulty) {
            retValue = quiz;
            break ;
        }
    }
    [_quizesArray removeObject: retValue];
    return retValue;
}

- (void) dealloc {
    [_fmDataBase close];
}
@end
