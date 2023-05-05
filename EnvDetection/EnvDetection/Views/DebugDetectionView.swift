//
//  DebugDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct DebugDetectionView: View {
    
    @StateObject var viewModel: DebugDetectionViewModel = DebugDetectionViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // 常规反调试函数
                VStack(alignment: .leading) {
                    Text("常规反调试函数")
                        .font(.headline)
                        .padding(.vertical)
                    
                    Picker("AntiFuns", selection: $viewModel.defaultAntiFun) {
                        ForEach(viewModel.antiFuns, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    //
                    if viewModel.defaultAntiFun == "ptrace" {
                        Ptrace_Toggle_View(isPtrace: $viewModel.isPtrace, isPtraceSvc: $viewModel.isPtraceSvc, isPtraceXor: $viewModel.isPtraceXor)
                    } else if viewModel.defaultAntiFun == "syscall" {
                        Syscall_Toggle_View(isSyscall: $viewModel.isSyscall, isSyscallSvc: $viewModel.isSyscallSvc, isSyscallXor: $viewModel.isSyscallXor)
                    } else if viewModel.defaultAntiFun == "sysctl" {
                        Sysctl_Toggle_View(isSysctl: $viewModel.isSysctl, isSysctlSvc: $viewModel.isSysctlSvc, isSysctlXor: $viewModel.isSysctlXor)
                    }
                }
                
                // 非常规反调试函数
                VStack(alignment: .leading) {
                    Text("非常规反调试函数（待开发）")
                        .font(.headline)
                        .padding(.vertical)
                    
                    Picker("OtherAntiFuns", selection: $viewModel.otherAntiFun) {
                        ForEach(viewModel.otherAntiFuns, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if viewModel.otherAntiFun == "isatty" {
                        Toggle(isOn: $viewModel.isIsattyDebug){
                            Text("isatty")
                                .font(.headline)
                                .padding()
                        }
                    } else if viewModel.otherAntiFun == "ioctl" {
                        Toggle(isOn: $viewModel.isIoctlDebug){
                            Text("ioctl")
                                .font(.headline)
                                .padding()
                        }
                    }
                }   // VStack
            }  // List
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("调试检测")
        }
    }
}

struct DebugDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        DebugDetectionView()
    }
}

// ptrace
struct Ptrace_Toggle_View: View {
        
    @StateObject var viewModel: DebugDetectionViewModel = DebugDetectionViewModel()
    @Binding var isPtrace: Bool
    @Binding var isPtraceSvc: Bool
    @Binding var isPtraceXor: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $isPtrace){
                Text("ptrace")
            }
            if isPtrace {
                if viewModel.ori_ptrace() {
                    // TODO
                }
            }
            
            Toggle(isOn: $isPtraceSvc){
                Text("ptrace + svc")
            }
            if isPtraceSvc {
                if viewModel.svc_ptrace() {
                    // TODO
                }
            }
            
            Toggle(isOn: $isPtraceXor){
                Text("ptrace + xor")
            }
            if isPtraceXor {
                if viewModel.xor_ptrace() {
                    // TODO
                }
            }
        }
        .font(.headline)
        .padding()
    }
}

// syscall
struct Syscall_Toggle_View: View {
        
    @StateObject var viewModel: DebugDetectionViewModel = DebugDetectionViewModel()
    @Binding var isSyscall: Bool
    @Binding var isSyscallSvc: Bool
    @Binding var isSyscallXor: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $isSyscall){
                Text("syscall")
            }
            if isSyscall {
                if viewModel.ori_syscall() {
                    // TODO
                }
            }
            
            Toggle(isOn: $isSyscallSvc){
                Text("syscall + svc")
            }
            if isSyscallSvc {
                if viewModel.svc_syscall() {
                    // TODO
                }
            }
            
            Toggle(isOn: $isSyscallXor){
                Text("syscall + xor")
            }
            if isSyscallXor {
                if viewModel.xor_syscall() {
                    // TODO
                }
            }
        }
        .font(.headline)
        .padding()
    }
}

// sysctl
struct Sysctl_Toggle_View: View {
        
    @StateObject var viewModel: DebugDetectionViewModel = DebugDetectionViewModel()
    @Binding var isSysctl: Bool
    @Binding var isSysctlSvc: Bool
    @Binding var isSysctlXor: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $isSysctl){
                Text("sysctl")
            }
            if isSysctl {
                if viewModel.ori_sysctl() {
                    exit(0)
                }
            }
            
            Toggle(isOn: $isSysctlSvc){
                Text("sysctl + svc")
            }
            if isSysctlSvc {
                if viewModel.svc_sysctl() {
                    exit(0)
                }
            }
            
            Toggle(isOn: $isSysctlXor){
                Text("sysctl + xor")
            }
            if isSysctlXor {
                if viewModel.xor_sysctl() {
                    exit(0)
                }
            }
        }
        .font(.headline)
        .padding()
    }
}
