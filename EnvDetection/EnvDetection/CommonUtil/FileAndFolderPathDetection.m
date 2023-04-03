//
//  FileAndFolderPathDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/24.
//

#import "FileAndFolderPathDetection.h"
#include <sys/mount.h>
#include <sys/stat.h>

@implementation FileAndFolderPathDetection

// NSFileManager
- (BOOL)checkPathByNSFileManager:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    
    return result;
}

// access
- (BOOL)checkPathByAccess:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    // 函数执行成功返回 0，失败则返回 -1
    if(0 == access(c, F_OK)) {
        return YES;
    }
    
    return NO;
}

// stat
- (BOOL)checkPathByStat:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    struct stat buf;
    // 函数执行成功返回 0，失败则返回 -1
    if(0 == stat(c, &buf)) {
        return YES;
    }
    
    return NO;
}

// lstat
- (BOOL)checkPathByLstat:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    struct stat buf;
    // 函数执行成功返回 0，失败则返回 -1
    if(0 == lstat(c, &buf)) {
        return YES;
    }
    
    return NO;
}

// statfs
- (BOOL)checkPathByStatfs:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    struct statfs buf;
    // 函数执行成功返回 0，失败则返回 -1
    if(0 == statfs(c, &buf)) {
        return YES;
    }
    
    return NO;
}

// open
- (BOOL)checkPathByOpen:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    int f;
    // 函数执行成功返回打开的文件句柄，-1 打开失败
    if((f = open(c, O_RDONLY)) == -1) {
        return NO;
    }
    
    close(f);
    
    return YES;
}

// fopen
- (BOOL)checkPathByFopen:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    FILE *f;
    // 函数执行成功返回打开的文件句柄，NULL 打开失败
    if((f = fopen(c, "r")) == NULL){
        return NO;
    }
    
    fclose(f);
    
    return YES;
}

@end
