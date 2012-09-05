//
//  BYQuiz.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYQuiz.h"
#import <MapKit/MapKit.h>


@implementation BYQuiz

- (id) initWithDescription:(NSString *)task
          AnswerCoordinate:(CLLocationCoordinate2D)ansCoord
                Difficulty:(BYQuizDifficulty)difficulty
               ZoneMapRect:(MKMapRect)zoneRect {
    
    
    NSAssert(task.length, @"BYQuiz # initWith - attemp to init with empty task");
    NSAssert(( ansCoord.latitude != 0 || ansCoord.longitude != 0 ),
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


+ (id) randomQuizWithDifficulty: (BYQuizDifficulty) difficulty {
    switch (difficulty) {
        case BYQuizDifficulty_Easy:
            return [[BYQuiz alloc] initWithDescription:@"Where is Ukraine"
                                      AnswerCoordinate:CLLocationCoordinate2DMake(50, 32)
                                            Difficulty:BYQuizDifficulty_Easy
                                           ZoneMapRect:MKMapRectNull];
            break;
        case BYQuizDifficulty_Medium:
            return [[BYQuiz alloc] initWithDescription:@"Where is London"
                                      AnswerCoordinate:CLLocationCoordinate2DMake(51, 0)
                                            Difficulty:BYQuizDifficulty_Easy
                                           ZoneMapRect:MKMapRectNull];
            break;
        case BYQuizDifficulty_Hard:
            return [[BYQuiz alloc] initWithDescription:@"Where is Goteberg"
                                      AnswerCoordinate:CLLocationCoordinate2DMake(58, 12)
                                            Difficulty:BYQuizDifficulty_Easy
                                           ZoneMapRect:MKMapRectNull];
            break;
            
        default:
            NSAssert(0, @"BYQuiz # randomQuizWithDiff - cannot create quiz with unknown diff");
            break;
    }
    return NULL;
}

@end