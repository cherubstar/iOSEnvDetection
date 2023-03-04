//
//  DebugDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebugDetection : NSObject

int ori_ptrace();
int svc_ptrace();
int xor_ptrace();

int ori_syscall();
int svc_syscall();
int xor_syscall();

int ori_sysctl();
int svc_sysctl();
int xor_sysctl();

@end

NS_ASSUME_NONNULL_END
