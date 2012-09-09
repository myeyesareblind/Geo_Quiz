//
//  BYSQLLeaderBoardWrapper.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/9/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYLeaderBoardDataBaseRecord : NSObject {
}

@property (readonly) NSTimeInterval        timeSince1970;
@property (readonly, strong) NSDate*       date;
@property (readonly, strong) NSString*     name;
@property (readonly) NSInteger     pts;

- (id) initWithName: (NSString *) name points: (NSInteger) pts date: (NSDate*) date;
- (id) initWithName: (NSString *) name points: (NSInteger) pts timeInterval: (NSTimeInterval) timeSince1970;
@end


@class FMDatabase;

@interface BYSQLLeaderBoardWrapper : NSObject {
    FMDatabase*         _db;
    NSMutableArray*     _records;
}

+ (BYSQLLeaderBoardWrapper*) sharedDataBaseWrapper;

- (void)        pushRecord: (BYLeaderBoardDataBaseRecord*) record;
- (NSArray*)    dataBaseRecords;
@end
