//
//  FridaDetectionViewModel.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

class FridaDetectionViewModel: ObservableObject {
    
    @Published var paths = [
        "/usr/sbin/frida-server",
        "/usr/lib/frida/frida-server",
        "/usr/lib/frida/frida-agent.dylib",
        "/Library/LaunchDaemons/re.frida.server.plist",
        "/Library/dpkg/info/re.frida.server.extrainst_",
        "/Library/dpkg/info/re.frida.server.list",
        "/Library/dpkg/info/re.frida.server.prerm",
        "/Library/dpkg/info/re.frida.server.md5sums"
    ]
    
    @Published var isOpen27042 = false
    
    @Published var fridaDetection = FridaDetection()
    
    func checkListeningPort27042() {
        isOpen27042 = fridaDetection.checkListeningPort27042()
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
