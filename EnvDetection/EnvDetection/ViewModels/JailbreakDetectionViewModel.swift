//
//  JailbreakDetectionViewModel.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

class JailbreakDetectionViewModel: ObservableObject {
    
    @Published var paths = [
        "/Applications/Cydia.app",
        "/var/mobile/Library/Cydia",
        "/private/var/lib/cydia",
        "/var/lib/cydia",
        "/Library/MobileSubstrate/MobileSubstrate.dylib"
    ]
    
    @Published var plugin_apps = [
        "unc0ver",
        "checkra1n",
        "Cydia",
        "Sileo",
        "Substitute",
        "CrackerXI+",
        "DumpDecrypter",
        "Flex"
    ]
    
    @Published var jailbreakDetection = JailbreakDetection()
    
    func checkPluginAppIsInstalled(plugin_app: String) -> Bool {
        return jailbreakDetection.checkPluginAppIsInstalled(plugin_app)
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
    
    var refresh_app: some View {
        Button {
            self.plugin_apps.append("1")
            self.plugin_apps.removeLast()
        } label: {
            Image(systemName: "arrow.counterclockwise")
        }
    }
}
