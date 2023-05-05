//
//  PluginApplicationDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct PluginApplicationDetectionView: View {
    
    @StateObject var viewModel = JailbreakDetectionViewModel()
    
    var body: some View {
        List {
            // 遍历所有插件 APP，包括越狱工具 APP，以及 Cydia/Sileo 商店安装的 APP
            ForEach(viewModel.plugin_apps, id: \.self) { plugin_app in
                HStack{
                    // AppIcon60x60@2x
                    Image(plugin_app)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    
                    Text(plugin_app)
                        .font(.headline)
                    
                    Spacer()
                    
                    // 插件 APP 检测
                    if viewModel.checkPluginAppIsInstalled(plugin_app: plugin_app) {
                        Text("发现")
                            .font(.headline)
                            .foregroundColor(.red)
                    } else {
                        Text("未发现")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }
                .padding([.leading, .trailing])
            }
        }   // List
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("插件 APP 检测"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: viewModel.refresh_app
        )
    }
}

struct PluginApplicationDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        PluginApplicationDetectionView()
    }
}
