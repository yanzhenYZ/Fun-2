//
//  YZDBManager.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZDBManager.h"
#import "YZNoteModel.h"
#import "YZYKDBModel.h"
#import "FMDB.h"

static FMDatabaseQueue * _databaseQueue;
@implementation YZDBManager

+(void)load{
    [self creatDB];
}

+ (FMDatabaseQueue *)sharedDatabaseQueue;
{
    if (!_databaseQueue) {
        NSString *path = [DocumentsPath stringByAppendingPathComponent:@"FunnyNote"];
        path = [path stringByAppendingPathComponent:@"note.db"];
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return _databaseQueue;
}

+(void)creatDB{
    NSString *path = [DocumentsPath stringByAppendingPathComponent:@"FunnyNote"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [[self sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        NSString *sql = @"create table if not exists FunnyNote(ID integer primary key,time bigint,title nvarchar(4000))";
        NSString *sql1 = @"create table if not exists FunnyLive(ID integer primary key,name nvarchar(4000),liveAddress nvarchar(4000))";
        [db executeUpdate:sql];
        [db executeUpdate:sql1];
    }];
}
#pragma mark - Live
+ (void)addLive:(YZYKDBModel *)model{
    NSString *sql = @"select * from FunnyLive where (liveAddress = ?)";
    NSMutableArray *models = [NSMutableArray array];
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet * res = [db executeQuery:sql,model.liveAddress];
        while ([res next]) {
            YZYKDBModel *model = [[YZYKDBModel alloc] init];
            model.name = [res stringForColumn:@"name"];
            model.liveAddress = [res stringForColumn:@"liveAddress"];
            [models addObject:model];
        }
        [res close];
    }];
    if (models.count > 0) {
        [self updateLive:model];
        return;
    }
    sql = @"insert into FunnyLive (name,liveAddress) values(?,?)";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,model.name,model.liveAddress];
    }];
}

+ (void)deleteLive:(YZYKDBModel *)model{
    NSString *sql = @"delete from FunnyLive where liveAddress = ?";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,model.liveAddress];
    }];
}

+ (void)updateLive:(YZYKDBModel *)model{
    NSString *sql = @"update FunnyLive set name = ? where liveAddress = ?";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,model.name,model.liveAddress];
    }];
}

+ (NSMutableArray <YZYKDBModel *>*)allLive{
    NSMutableArray *models = [[NSMutableArray alloc] init];
    NSString *sql = @"select * from FunnyLive";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            YZYKDBModel *model = [[YZYKDBModel alloc] init];
            model.name = [result stringForColumn:@"name"];
            model.liveAddress = [result stringForColumn:@"liveAddress"];
            [models addObject:model];
        }
        [result close];
    }];
    return models;
}

#pragma mark - note
+ (void)addNote:(YZNoteModel *)model{
    NSString *sql = @"insert into FunnyNote (time,title) values(?,?)";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,@(model.time),model.title];
    }];
}

+ (void)deleteNote:(YZNoteModel *)model{
    NSString *sql = @"delete from FunnyNote where time = ?";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,@(model.time)];
    }];
}

+ (void)updateNote:(YZNoteModel *)model{
    NSString *sql = @"update FunnyNote set title = ? where time = ?";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,model.title,@(model.time)];
    }];
}

+ (NSMutableArray <YZNoteModel *>*)allNote{
    NSMutableArray *models = [[NSMutableArray alloc] init];
    NSString *sql = @"select * from FunnyNote";
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            YZNoteModel *model = [[YZNoteModel alloc] init];
            model.title = [result stringForColumn:@"title"];
            model.time = [result longLongIntForColumn:@"time"];
            [models addObject:model];
        }
        [result close];
    }];
    return models;
}
@end
