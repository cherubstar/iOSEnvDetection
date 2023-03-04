//
//  DebugDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

import SwiftUI

struct DebugDetectionView: View {
    
    // 常规反调试函数
    @State private var defaultAntiFun = "ptrace"
    var antiFuns = ["ptrace", "syscall", "sysctl"]
    
    // ptrace
    @State var isPtrace = false
    @State var isPtraceSvc = false
    @State var isPtraceXor = false
    
    // syscall
    @State var isSyscall = false
    @State var isSyscallSvc = false
    @State var isSyscallXor = false
    
    // sysctl
    @State var isSysctl = false
    @State var isSysctlSvc = false
    @State var isSysctlXor = false
    
    // 非常规反调试函数
    @State private var otherAntiFun = "isatty"
    var otherAntiFuns = ["isatty", "ioctl"]
    
    @State var isIsattyDebug = false
    @State var isIoctlDebug = false
    
    var body: some View {
        List{
            HStack{
                Text("调试检测").font(.title)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5, x: 1, y: 1)
            }
            
            // Toast 提示弹窗
            let toast = ToastUtil();
            
            /**
                常规反调试函数
             */
            VStack(alignment: .leading) {
                
                Text("常规反调试函数").font(.headline)
                    .padding(.bottom)
                
                Picker("AntiFuns", selection: $defaultAntiFun) {
                    ForEach(antiFuns, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                if defaultAntiFun == "ptrace" {
                    //
                    Toggle(isOn: $isPtrace){
                        Text("ptrace")
                    }
                    if self.isPtrace && toast.showToast("开启 ptrace 反调试") == 1 {
                        if ori_ptrace() == 1 {
                            
                        }
                    }
                    
                    //
                    Toggle(isOn: $isPtraceSvc) {
                        Text("ptrace + svc")
                    }
                    if self.isPtraceSvc && toast.showToast("开启 ptrace + svc 反调试") == 1 {
                        if svc_ptrace() == 1 {
                            
                        }
                    }
                    
                    //
                    Toggle(isOn: $isPtraceXor) {
                        Text("ptrace + xor")
                    }
                    if self.isPtraceXor && toast.showToast("开启 ptrace + xor 反调试") == 1 {
                        if xor_ptrace() == 1 {
                            
                        }
                    }
                    
                } else if defaultAntiFun == "syscall" {
                    //
                    Toggle(isOn: $isSyscall){
                        Text("syscall")
                    }
                    if self.isSyscall && toast.showToast("开启 syscall 反调试") == 1  {
                        if ori_syscall() == 1 {
                            
                        }
                    }
                    
                    //
                    Toggle(isOn: $isSyscallSvc){
                        Text("syscall + svc")
                    }
                    if self.isSyscallSvc && toast.showToast("开启 syscall + svc 反调试") == 1 {
                        if svc_syscall() == 1 {
                            
                        }
                    }
                    
                    //
                    Toggle(isOn: $isSyscallXor){
                        Text("syscall + xor")
                    }
                    if self.isSyscallXor && toast.showToast("开启 syscall + xor 反调试") == 1 {
                        if xor_syscall() == 1 {
                            
                        }
                    }
                } else if defaultAntiFun == "sysctl" {
                    Toggle(isOn: $isSysctl) {
                        Text("sysctl")
                    }
                    if self.isSysctl && toast.showToast("开启 sysctl 反调试") == 1 {
                        if ori_sysctl() == 1 {
                            exit(0)
                        }
                    }
                    
                    //
                    Toggle(isOn: $isSysctlSvc) {
                        Text("sysctl + svc")
                    }
                    if self.isSysctlSvc && toast.showToast("开启 sysctl + svc 反调试") == 1 {
                        if svc_sysctl() == 1 {
                            exit(0)
                        }
                    }
                    
                    //
                    Toggle(isOn: $isSysctlXor) {
                        Text("sysctl + xor")
                    }
                    if self.isSysctlXor && toast.showToast("开启 sysctl + xor 反调试") == 1 {
                        if xor_sysctl() == 1 {
                            exit(0)
                        }
                    }
                }
            }
            .padding()
            
            /**
                非常规反调试函数
             */
            VStack(alignment: .leading) {
                
                Text("非常规反调试函数（待开发）").font(.headline)
                    .padding(.bottom)
                
                Picker("AntiFuns", selection: $otherAntiFun) {
                    ForEach(otherAntiFuns, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom)

                if otherAntiFun == "isatty" {
                    Toggle(isOn: $isIsattyDebug){
                        Text("isatty")
                    }
                } else if otherAntiFun == "ioctl" {
                    Toggle(isOn: $isIoctlDebug){
                        Text("ioctl")
                    }
                }
            }
            .padding()
        }
        .padding()      // List
    }
}

struct DebugDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        DebugDetectionView()
    }
}
