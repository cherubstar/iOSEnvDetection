//
//  AgentApplicationDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct AgentApplicationDetectionView: View {
    
    @StateObject var viewModel = AgentDetectionViewModel()
    
    var body: some View {
        List {
            // 代理 APP 检测
            let isInstalled = viewModel.isInstalled()
            
            // 遍历所有 代理 APP
            ForEach(viewModel.agent_apps.indices, id: \.self) { index in
                HStack{
                    // AppIcon60x60@2x
                    Image(viewModel.agent_apps[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    
                    Text(viewModel.agent_apps[index])
                        .font(.headline)
                    
                    Spacer()

                    // 判断是否安装代理 APP
                    if isInstalled[index]
                    {
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
        .navigationTitle(Text("代理 APP 检测"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: viewModel.refresh
        )
    }
}

struct AgentApplicationDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        AgentApplicationDetectionView()
    }
}
