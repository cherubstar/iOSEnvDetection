//
//  DebugDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebugDetection : NSObject

- (void)ori_ptrace;
- (void)svc_ptrace;
- (void)xor_ptrace;

- (void)ori_syscall;
- (void)svc_syscall;
- (void)xor_syscall;

- (int)ori_sysctl;
- (int)svc_sysctl;
- (int)xor_sysctl;

@end

NS_ASSUME_NONNULL_END
