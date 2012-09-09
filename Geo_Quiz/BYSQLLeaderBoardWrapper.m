//
//  BYSQLLeaderBoardWrapper.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/9/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYSQLLeaderBoardWrapper.h"
#import "FMDataBase.h"



NSString * const kRowName = @"Name";
NSString * const kRowDate = @"Date";
NSString * const kRowPts  = @"Points";



@interface BYSQLLeaderBoardWrapper ()

- (void) _createTable;
- (void) _loadRecords;

@end

NSString * const dbName = @"GameRecords.db";

@implementation BYSQLLeaderBoardWrapper

static BYSQLLeaderBoardWrapper* sharedInstance = nil;

+ (BYSQLLeaderBoardWrapper *)sharedDataBaseWrapper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BYSQLLeaderBoardWrapper alloc] _init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


- (id) init {
    NSAssert( 0x00, @"Only usage of shared instance allowed");
    return NULL;
}


- (id) _init {
    self = [super init];
    if (self) {
        _db     = [[FMDatabase alloc] initWithPath: [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dbName]];
        
        BOOL dbOpened = [_db open];
        NSAssert(dbOpened, [_db lastErrorMessage]);
        
        [self _createTable];
        [self _loadRecords];
    }
    return self;
}


- (void)   _createTable {
    BOOL updateResult =
    [_db executeUpdate:@"CREATE TABLE Records(Name TEXT, Points INTEGER, Date REAL)"];

    /// TODO: table alreadyt exist erorr
    NSAssert1( (updateResult==0 || updateResult == 1)  , @"Create table failed with error: ", [_db lastErrorMessage]);
}


- (void)   _loadRecords {
    _records = [[NSMutableArray alloc] init];
    
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM Records ORDER BY Points DESC"];
    
    NSAssert1(! [_db lastErrorCode], @"Records initialization queury failed with error %@", [_db lastError]);
    
    while ([resultSet next]) {
        BYLeaderBoardDataBaseRecord *record = [[BYLeaderBoardDataBaseRecord alloc] initWithName:[resultSet stringForColumn:kRowName]
                                                                                         points:[resultSet intForColumn:kRowPts]
                                                                                   timeInterval:[resultSet doubleForColumn:kRowDate]];
        [_records addObject: record];
    }
}


- (NSArray*) dataBaseRecords {
    if (! _records) {
        [self _loadRecords];
    }
    return _records;
}


- (void)     pushRecord:(BYLeaderBoardDataBaseRecord *)record {
    /// release records - they shoulb be updated
    _records    = NULL;
    
    NSDictionary *paramDict = @{
    kRowName : record.name,
    kRowPts  : [NSNumber numberWithInt: record.pts],
    kRowDate : [NSNumber numberWithDouble: record.timeSince1970]
    };
    
    BOOL updateResult =
    [_db executeUpdate:@"INSERT INTO Records(Name, Points, Date) Values(:Name,:Points,:Date)"
withParameterDictionary:paramDict];
    
    NSAssert1(updateResult, @"Push record failed with error: ", [_db lastErrorMessage]);
}


- (void) dealloc {
    [_db close];
}
@end




@implementation BYLeaderBoardDataBaseRecord

@synthesize name, pts, date;

- (id) init {
    NSAssert(0, @"use initWithName...");
    return NULL;
}


- (id) initWithName:(NSString *)name_
             points:(NSInteger)pts_
               date:(NSDate *)date_ {
    self = [super init];
    if (self) {
        name = [name_ copy];
        pts  = pts_;
        date = date_;
    }
    return self;
}


- (id) initWithName:(NSString *)name_ points:(NSInteger)pts_ timeInterval:(NSTimeInterval)timeSince1970_ {
    self = [super init];
    if (self) {
        name    = [name_ copy];
        pts     = pts_;
        date    = [NSDate dateWithTimeIntervalSince1970:timeSince1970_];
    }
    return self;
}


- (NSTimeInterval) timeSince1970 {
    return [date timeIntervalSince1970];
}
@end