//
//  JailbreakDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "JailbreakDetection.h"
#include <sys/mount.h>
#include <sys/stat.h>

@implementation JailbreakDetection

// NSFileManager
- (BOOL)checkFileIsExistsByNSFileManager:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    
    return result;
}

// access
- (BOOL)checkFileIsExistsByAccess:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    // 函数执行成功返回 0，失败则返回 -1
    if(0 == access(c, F_OK)) {
        return YES;
    }
    
    return NO;
}

// stat
- (BOOL)checkFileIsExistsByStat:(NSString *)path {
    
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
- (BOOL)checkFileIsExistsByLstat:(NSString *)path {
    
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
- (BOOL)checkFileIsExistsByStatfs:(NSString *)path {
    
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
- (BOOL)checkFileIsExistsByOpen:(NSString *)path {
    
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
- (BOOL)checkFileIsExistsByFopen:(NSString *)path {
    
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

// popen
/*
- (BOOL)checkFileIsExistsByPopen:(NSString *)path {
    
    // NSString ➡️ const char *
    const char * c = [path UTF8String];
    
    FILE *f;
    if((f = popen(c, "r")) == NULL){
        return NO;
    }
    
    pclose(f);
    
    return YES;
}
 */

@end
