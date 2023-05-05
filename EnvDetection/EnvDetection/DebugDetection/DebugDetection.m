//
//  DebugDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import "DebugDetection.h"
#import "ptrace.h"
#include <sys/syscall.h>
#include <sys/sysctl.h>
#include <dlfcn.h>

@implementation DebugDetection

/**
    ptrace
    ptrace + svc
    ptrace + xor
 */
- (void)ori_ptrace {
    ptrace(PT_DENY_ATTACH, 0, 0, 0);
}

- (void)svc_ptrace {
#ifdef __arm64__
    __asm__("mov X0, #31\n"
            "mov X1, #0\n"
            "mov X2, #0\n"
            "mov X3, #0\n"
            "mov w16, #26\n"
            "svc #0x80");
#endif
}

- (void)xor_ptrace {
    
    //A 异或 B 等到 C,C 再异或 A 得到 B,隐藏 ptrace
    unsigned char str[] = {
        ('q' ^ 'p'),
        ('q' ^ 't'),
        ('q' ^ 'r'),
        ('q' ^ 'a'),
        ('q' ^ 'c'),
        ('q' ^ 'e'),
        ('q' ^ '\0')
    };
    
    unsigned char *p = str;
    while (((*p) ^= 'q') != '\0')
        p++;
    
    int (*ptrace_ptr)(int _request, pid_t _pid, caddr_t _addr, int _data);
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);   // 获得句柄
    ptrace_ptr = dlsym(handle, (const char *)str);      // 动态查找 ptrace 符号
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

/**
    syscall
    syscall + ptrace + svc
    syscall + ptrace + xor
 */
- (void)ori_syscall {
    syscall(SYS_ptrace, PT_DENY_ATTACH, 0, 0, 0);
}

- (void)svc_syscall {
#ifdef __arm64__
    __asm__("mov X0, #26\n"
            "mov X1, #31\n"
            "mov X2, #0\n"
            "mov X3, #0\n"
            "mov X4, #0\n"
            "mov w16, #0\n"
            "svc #0x80");
#endif
}

- (void)xor_syscall {
    
    //A 异或 B 等到 C,C 再异或 A 得到 B,隐藏 syscall
    unsigned char str[] = {
        ('q' ^ 's'),
        ('q' ^ 'y'),
        ('q' ^ 's'),
        ('q' ^ 'c'),
        ('q' ^ 'a'),
        ('q' ^ 'l'),
        ('q' ^ 'l'),
        ('q' ^ '\0')
    };
    
    unsigned char *p = str;
    while (((*p) ^= 'q') != '\0')
        p++;
    
    int (*syscall_ptr)(int number, ...);
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);   // 获得句柄
    syscall_ptr = dlsym(handle, (const char *)str);     // 动态查找 syscall 符号
    syscall_ptr(SYS_ptrace, PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

/**
    sysctl
    sysctl  + svc
    sysctl  + xor
 */
- (int)ori_sysctl {
    
    // 需要检测进程信息的字段数组
    int name[4];                // 里面存放字节码，查询信息
    name[0] = CTL_KERN;         // 内核查询
    name[1] = KERN_PROC;        // 进程查询
    name[2] = KERN_PROC_PID;    // 传递的参数是进程的ID(PID) 同：$ ps -A
    name[3] = getpid();         // 获取 pid，据说这个可以直接传 0

    struct kinfo_proc info;             // 接受进程查询结果信息的结构体
    size_t info_size = sizeof(info);    // 结构体的大小
    info.kp_proc.p_flag = 0;

    /* 查询成功返回 0 */
    sysctl(name, sizeof(name) / sizeof(*name), &info, &info_size, NULL, 0);
    
    /*
        查询结果看info.kp_proc.p_flag 的第12位，如果为1，表示调试附加状态。
        info.kp_proc.p_flag & P_TRACED 即可获取第12位
    */
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

- (int)svc_sysctl {
    
    // 需要检测进程信息的字段数组
    int name[4];                // 里面存放字节码，查询信息
    name[0] = CTL_KERN;         // 内核查询
    name[1] = KERN_PROC;        // 进程查询
    name[2] = KERN_PROC_PID;    // 传递的参数是进程的ID(PID) 同：$ ps -A
    name[3] = getpid();         // 获取 pid，据说这个可以直接传 0
    
    struct kinfo_proc proc;
    size_t proc_size = sizeof(proc);
    memset(&proc, 0, proc_size);
    
#ifdef __arm64__
    __asm__(
        "mov x0, %[name_ptr]\n"
        "mov x1, #4\n"
        "mov x2, %[proc_ptr]\n"
        "mov x3, %[size_ptr]\n"
        "mov x4, #0x0\n"
        "mov x5, #0x0\n"
        "mov w16, #202\n"
        "svc #0x80\n"
        
        :
        
        :[name_ptr]"r"(&name), [proc_ptr]"r"(&proc), [size_ptr]"r"(&proc_size)
        
    );
#endif
    
    /*
        查询结果看info.kp_proc.p_flag 的第12位，如果为1，表示调试附加状态。
        info.kp_proc.p_flag & P_TRACED 即可获取第12位
    */
    return ((proc.kp_proc.p_flag & P_TRACED) != 0);
}

- (int)xor_sysctl {
    
    int name[4];                    // 里面存放字节码，查询信息
    name[0] = CTL_KERN;             // 内核查询
    name[1] = KERN_PROC;            // 进程查询
    name[2] = KERN_PROC_PID;        // 传递的参数是进程的ID(PID) 同：$ ps -A
    name[3] = getpid();             // 获取当前进程ID
    
    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    info.kp_proc.p_flag = 0;
    
    //A 异或 B 等到 C,C 再异或 A 得到 B,隐藏 sysctl
    unsigned char str[] = {
        ('q' ^ 's'),
        ('q' ^ 'y'),
        ('q' ^ 's'),
        ('q' ^ 'c'),
        ('q' ^ 't'),
        ('q' ^ 'l'),
        ('q' ^ '\0')
    };
    
    unsigned char *p = str;
    while (((*p) ^= 'q') != '\0')
        p++;
    
    int (*sysctl_ptr)(int *, u_int, void *, size_t *, void *, size_t);
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);       // 获得句柄
    sysctl_ptr = dlsym(handle, (const char *)str);          // 动态查找 sysctl 符号
    sysctl_ptr(name, 4, &info, &info_size, 0, 0);
    dlclose(handle);
    
    /*
        查询结果看info.kp_proc.p_flag 的第12位，如果为1，表示调试附加状态。
        info.kp_proc.p_flag & P_TRACED 即可获取第12位
    */
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

@end
