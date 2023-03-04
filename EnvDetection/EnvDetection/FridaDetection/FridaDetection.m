//
//  FridaDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "FridaDetection.h"
#include <stdio.h>
#include <unistd.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@implementation FridaDetection

// 文件检测
- (BOOL)checkFridaFileIsExistsByNSFileManager:(NSString *)path {
    
    // NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    
    return result;
}

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

@end
