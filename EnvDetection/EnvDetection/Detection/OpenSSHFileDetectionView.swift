//
//  OpenSSHFileDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/24.
//

import SwiftUI

struct OpenSSHFileDetectionView: View {
    
    @ObservedObject var flush: OpenSSHFileDetectionListRefresh = OpenSSHFileDetectionListRefresh()
    
    var body: some View {
        List {
            // 遍历所有 Frida 相关文件
            ForEach(self.flush.paths, id: \.self) { path in
                HStack{
                    Text(path)
                    Spacer()
                    
                    // 文件路径检测
                    let detection = FileAndFolderPathDetection()
                    if detection.checkPath(byNSFileManager: path) ||
                        detection.checkPath(byAccess: path)     ||
                        detection.checkPath(byStat: path)       ||
                        detection.checkPath(byLstat: path)      ||
                        detection.checkPath(byStatfs: path)     ||
                        detection.checkPath(byOpen: path)       ||
                        detection.checkPath(byFopen: path)
                    {
                        Text("发现")
                            .foregroundColor(.red)
                    } else {
                        Text("未发现")
                            .foregroundColor(.green)
                    }
                }
                .padding([.leading, .trailing])
            }
            
            // 刷新当前页面的检测
            Button(action: {
                self.flush.refresh()
            }, label: {
                HStack {
                    Image(systemName: "hand.tap")
                    Text("刷新").font(.headline)
                }
                .padding()
                .foregroundColor(.blue)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            })
        }
        .padding()  // List
        .navigationTitle(Text("OpenSSH 文件检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OpenSSHFileDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSSHFileDetectionView()
    }
}

// 刷新当前界面
class OpenSSHFileDetectionListRefresh : ObservableObject {
    
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

    func refresh() {
        paths.append("1")
        paths.removeLast()
    }
}
