//
//  PluginApplicationDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/24.
//

import SwiftUI

struct PluginApplicationDetectionView: View {
    
    @ObservedObject var flush: PluginApplicationDetectionListRefresh = PluginApplicationDetectionListRefresh()
    
    var body: some View {
        List {
            // 遍历所有插件 APP，包括越狱工具 APP，以及 Cydia/Sileo 商店安装的 APP
            ForEach(self.flush.plugin_apps, id: \.self) { plugin_app in
                HStack{
                    // AppIcon60x60@2x
                    Image(plugin_app)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    Text(plugin_app)
                    Spacer()
                    
                    // 文件路径检测
                    let detection = JailbreakDetection()
                    if detection.checkPluginAppIsInstalled(plugin_app) {
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
        .navigationTitle(Text("插件 APP 检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PluginApplicationDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        PluginApplicationDetectionView()
    }
}

// 刷新当前界面
class PluginApplicationDetectionListRefresh : ObservableObject {
    
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

    func refresh() {
        plugin_apps.append("1")
        plugin_apps.removeLast()
    }
}
