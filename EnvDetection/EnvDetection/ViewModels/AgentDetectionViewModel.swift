//
//  AgentDetectionViewModel.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

class AgentDetectionViewModel: ObservableObject {
    
    @Published var agent_apps = [
        "HTTP Catcher",
        "Kitsunebi",
        "Potatso Lite",
        "Quantumult",
        "Quantumult X",
        "Shadowrocket",
        "Surge",
        "Thor"
    ]
    
    @Published var isCFNetworkCopySystemProxySettings = false
    @Published var isConnectionProxyDictionary = false
    @Published var showCFNetworkCopySystemProxySettingsDetails: Bool = false
    @Published var showConnectionProxyDictionaryDetails: Bool = false
    @Published var showAlert: Bool = false
    @Published var contentAlert: String = ""
    
    @Published var agentDetection = AgentDetection()
    
    // 获取所有代理 APP 是否安装
    func isInstalled() -> Array<Bool> {
        return agentDetection.checkAgentAppIsInstalled() as! Array<Bool>
    }
    
    // 检测当前代理状态
    func checkProxyStatus(){
        
        if agentDetection.checkProxyStatusByCFNetworkCopySystemProxySettings() {
            contentAlert = "检测到代理工具. 😂"
        } else {
            contentAlert = "未检测到代理工具. 🥳"
        }
    }
    
    // 设置 connectionProxyDictionary 值为 空（默认为 null）
    func setConnectionProxyDictionary() {
        contentAlert = "已经发出请求. 😘"
        agentDetection.setConnectionProxyDictionary()
    }
    
    // 获取 CFNetworkCopySystemProxySettings 详细
    func getCFNetworkCopySystemProxySettingsDetails() -> ActionSheet {
        
        /**
            // 无代理
            {
                kCFProxyTypeKey = kCFProxyTypeNone;
            }
            
            有代理
            {
                kCFProxyHostNameKey = "127.0.0.1";
                kCFProxyPortNumberKey = 1082;
                kCFProxyTypeKey = kCFProxyTypeHTTPS;
            }
         */
        let status: NSDictionary = agentDetection.getCFNetworkCopySystemProxySettingsDetails() as NSDictionary
        let kCFProxyTypeKey: String = status["kCFProxyTypeKey"] as! String
        
        let cancelButton: ActionSheet.Button = .cancel()
        
        return ActionSheet(
            title: Text("kCFProxyTypeKey"),
            message: Text("\(kCFProxyTypeKey)"),
            buttons: [cancelButton])
    }
    
    // 获取 connectionProxyDictionary 详细
    func getConnectionProxyDictionaryDetails() -> ActionSheet {
        
        let cancelButton: ActionSheet.Button = .cancel()
        
        // 默认是 null
        var status = "(null)"
        
        if isConnectionProxyDictionary {
            status = "{}"
        }
        
        return ActionSheet(
            title: Text("connectionProxyDictionary"),
            message: Text(status),
            buttons: [cancelButton])
    }
    
    // 弹窗
    func getAlert() -> Alert {

        return Alert(
            title: Text("温馨提示"),
            message: Text(contentAlert),
            dismissButton: .default(Text("OK")))
    }

    // 刷新
    var refresh: some View {
        Button {
            self.agent_apps.append("1")
            self.agent_apps.removeLast()
        } label: {
            Image(systemName: "arrow.counterclockwise")
        }
    }
}
