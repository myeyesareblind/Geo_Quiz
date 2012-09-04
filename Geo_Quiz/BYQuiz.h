//
//  BYQuiz.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKGeometry.h>

typedef enum {
    BYQuizDifficulty_Undefined,
    BYQuizDifficulty_Easy,
    BYQuizDifficulty_Medium,
    BYQuizDifficulty_Hard
} BYQuizDifficulty;

@interface BYQuiz : NSObject {
    
    NSString * _quizTask;
    CLLocationCoordinate2D _answerCoordinate;
    MKMapRect  _mapRect;  /// answerCoordinate shoubl be in, mapView will be locked if setted
    BYQuizDifficulty _difficulty;
}

- (id) initWithDescription: (NSString*) task
          AnswerCoordinate: (CLLocationCoordinate2D) ansCoord
                Difficulty: (BYQuizDifficulty) difficulty
               ZoneMapRect: (MKMapRect) zoneRect;  /// or NULL


+ (id) quizWithDifficulty: (BYQuizDifficulty) difficulty;


@property (readonly) BYQuizDifficulty difficulty;
@property (readonly) NSString * task;
@property (readonly) CLLocationCoordinate2D answerCoordinate;
@property (readonly) MKMapRect lockZoneRect;


@end
