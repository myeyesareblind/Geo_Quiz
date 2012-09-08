//
//  BYSQLQuizDataWrapper.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/8/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYQuiz.h"

@class FMDatabase;

@interface BYSQLQuizDataWrapper : NSObject {
    FMDatabase*       _fmDataBase;
    
    NSMutableArray*   _quizesArray;
}

- (void) loadQuizData;

- (BYQuiz*) randomQuizWithDifficulty: (BYQuizDifficulty) difficulty;
@end
