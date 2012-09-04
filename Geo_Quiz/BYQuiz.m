//
//  BYQuiz.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYQuiz.h"


@implementation BYQuiz

- (id) initWithDescription:(NSString *)task
          AnswerCoordinate:(CLLocationCoordinate2D)ansCoord
                Difficulty:(BYQuizDifficulty)difficulty
               ZoneMapRect:(MKMapRect)zoneRect {
    
    
    NSAssert(task.length, @"BYQuiz # initWith - attemp to init with empty task");
    NSAssert(CLLocationCoordinate2DIsValid(ansCoord) && ( ansCoord.latitude != 0 || ansCoord.longitude != 0 ),
             @"BYQuiz # initWith - attemp to init with incorrect answer coordinate");
    NSAssert(difficulty != BYQuizDifficulty_Undefined, @"BYQuiz # initWith - attemp to init with incorrect difficulty");
    
    self = [super init];
    if (self) {
        _difficulty         = difficulty;
        _answerCoordinate   = ansCoord;
        _task               = [task copy];
        if (! MKMapRectIsEmpty(zoneRect)) {
            _mapRect = zoneRect;
        }
    }
    
    return self;
}



- (id) init {
    NSAssert(0, @"BYQuiz # init - use initWithDesc: Coord: Diff: ZoneMapRect: only");
    return NULL;
}


+ (id) quizWithDifficulty: (BYQuizDifficulty) difficulty {
    assert(0);
    return NULL;
}

@end
