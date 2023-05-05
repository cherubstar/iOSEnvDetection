//
//  OtherDetectionViewModel.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

class OtherDetectionViewModel: ObservableObject {
    
    @Published var paths = [
        "/etc/ssh/moduli",
        "/etc/ssh/ssh_config",
        "/etc/ssh/ssh_host_dsa_key",
        "/etc/ssh/ssh_host_dsa_key.pub",
        "/etc/ssh/ssh_host_rsa_key",
        "/etc/ssh/ssh_host_rsa_key.pub",
        "/usr/bin/scp",
        "/usr/bin/sftp",
        "/usr/bin/ssh",
        "/usr/bin/ssh-add",
        "/usr/bin/ssh-agent",
        "/usr/bin/ssh-keygen",
        "/usr/bin/ssh-keyscan",
        "/usr/libexec/ssh-keysign",
        "/usr/libexec/ssh-pkcs11-helper",
        "/usr/libexec/ssh-sk-helper",
        "/etc/ssh/sshd_config",
        "/Library/LaunchDaemons/com.openssh.sshd.plist",
        "/usr/libexec/sftp-server",
        "/usr/libexec/sshd-keygen-wrapper",
        "/usr/sbin/sshd"
    ]
    
    @Published var isOpen22 = false
    
    @Published var dynamicLibraryInjectionDetection = DynamicLibraryInjectionDetection()
    @Published var openSSHDetection = OpenSSHDetection()
    
    // 获取加载到 APP 虚拟内存中的所有动态库
    func getDyldArray() -> Array<String> {
        return dynamicLibraryInjectionDetection.checkAllDylibIsInject() as! Array<String>
    }
    
    func checkListeningPort22() {
        isOpen22 = openSSHDetection.checkListeningPort22()
    }
    
    // 刷新
    var refresh: some View {
        Button {
            self.paths.append("1")
            self.paths.removeLast()
        } label: {
            Image(systemName: "arrow.counterclockwise")
        }
    }
}
