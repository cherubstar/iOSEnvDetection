//
//  AgentDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

import SwiftUI

struct AgentDetectionView: View {
    
    @State private var isCFNetworkCopySystemProxySettings = false
    @State private var showToast = false
    
    var body: some View {
        List {
            HStack{
                Text("代理检测").font(.title)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5, x: 1, y: 1)
            }
            
            VStack(alignment: .leading) {
                Text("常规代理检测函数").font(.headline)
                    .padding(.bottom)
                
                Toggle(isOn: $isCFNetworkCopySystemProxySettings){
                    Text("CFNetworkCopySystemProxySettings")
                }
            }
            .padding()
            
            // Toast 提示弹窗
            let toast = ToastUtil();
            
            Button(action: {
                if isCFNetworkCopySystemProxySettings {
                    let detection = AgentDetection()
                    // 检测当前代理状态
                    if detection.checkProxyStatusByCFNetworkCopySystemProxySettings() {
                        showToast = true
                    } else {
                        toast.showToast("未检测到代理工具")
                    }
                } else {
                    toast.showToast("未勾选上面选项")
                }
                // 检测到代理后，将 Toast 设置为 false
                if showToast {
                    toast.showToast("[+] 检测到代理工具")
                    showToast = false
                }
            }, label: {
                HStack {
                    Image(systemName: "hand.tap")
                    Text("检测").font(.headline)
                }
                .padding()
                .foregroundColor(.blue)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            })
        }
        .padding()  // List
    }
}

struct AgentDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        AgentDetectionView()
    }
}
