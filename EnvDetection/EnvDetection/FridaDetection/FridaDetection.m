//
//  FridaDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "FridaDetection.h"
#include <sys/mount.h>
#include <sys/stat.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>


@implementation FridaDetection

// 文件检测
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

// 端口检测
int checkListeningPort() {
    
    int fd = socket(AF_INET, SOCK_STREAM, 0);
    if(fd == -1){
        NSLog(@"socket fail!");
        close(fd);
        return -1;
    }
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;          // AF_INET ipv4
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(27042);       // 终端输入 ns -l 27042
    
    /**
        1 发送一个信号给服务端，在吗（ACK）
        2 服务端回一个（ACK）我在
        3 客服端，那我们就开始吧
     
        0: 连接成功  -1: 连接失败
     */
    int result = connect(fd, (struct sockaddr *)&addr, sizeof(addr));
    if (result == -1) {
        NSLog(@"connect fail");
        close(fd);
        return result;
    }
    
    close(fd);
    return result;
}

// 进程检测
int checkProcess() {
    
    
    char cmd[256];
    memset(cmd, 0, 256);
    
    sprintf(cmd, "ps -e | grep frida-server");
    
    
    
    return 0;
}

@end
