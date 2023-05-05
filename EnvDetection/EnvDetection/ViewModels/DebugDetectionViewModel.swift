//
//  DebugDetectionViewModel.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

class DebugDetectionViewModel: ObservableObject {
    
    // 常规反调试函数
    @Published var defaultAntiFun = "ptrace"
    var antiFuns = ["ptrace", "syscall", "sysctl"]
    
    // ptrace
    @Published var isPtrace = false
    @Published var isPtraceSvc = false
    @Published var isPtraceXor = false
    
    // syscall
    @Published var isSyscall = false
    @Published var isSyscallSvc = false
    @Published var isSyscallXor = false
    
    // sysctl
    @Published var isSysctl = false
    @Published var isSysctlSvc = false
    @Published var isSysctlXor = false
    
    // 非常规反调试函数
    @Published var otherAntiFun = "isatty"
    var otherAntiFuns = ["isatty", "ioctl"]
    
    @Published var isIsattyDebug = false
    @Published var isIoctlDebug = false
    
    @Published var debugDetection = DebugDetection()
    
    // ptrace
    func ori_ptrace() -> Bool {
        debugDetection.ori_ptrace()
        return true
    }
    func svc_ptrace() -> Bool {
        debugDetection.svc_ptrace()
        return true
    }
    func xor_ptrace() -> Bool {
        debugDetection.xor_ptrace()
        return true
    }
    
    // syscall
    func ori_syscall() -> Bool {
        debugDetection.ori_syscall()
        return true
    }
    func svc_syscall() -> Bool {
        debugDetection.svc_syscall()
        return true
    }
    func xor_syscall() -> Bool {
        debugDetection.xor_syscall()
        return true
    }

    // sysctl
    func ori_sysctl() -> Bool {
        return debugDetection.ori_sysctl() == 1
    }
    func svc_sysctl() -> Bool {
        return debugDetection.svc_sysctl() == 1
    }
    func xor_sysctl() -> Bool {
        return debugDetection.xor_sysctl() == 1
    }
    
}
