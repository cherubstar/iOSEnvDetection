//
//  OpenSSHDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import "OpenSSHDetection.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@implementation OpenSSHDetection

// 端口检测
- (BOOL)checkListeningPort22 {
    
    int s = socket(AF_INET, SOCK_STREAM, 0);
    if(s == -1){
        NSLog(@"socket fail!");
        close(s);
        return NO;
    }
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;          // AF_INET ipv4
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(22);          // 终端输入 ns -l 22
    
    /**
        1 发送一个信号给服务端，在吗（ACK）
        2 服务端回一个（ACK）我在
        3 客服端，那我们就开始吧
     
        0: 连接成功  -1: 连接失败
     */
    int result = connect(s, (struct sockaddr *)&addr, sizeof(addr));
    
    if (result == -1) {
        NSLog(@"connect fail");
        close(s);
        return NO;
    }
    
    close(s);
    return YES;
}

@end
