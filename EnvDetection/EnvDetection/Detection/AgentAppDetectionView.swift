//
//  AgentAppDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/27.
//

import SwiftUI

struct AgentApplicationDetectionView: View {
    
    @ObservedObject var flush: AgentApplicationDetectionListRefresh = AgentApplicationDetectionListRefresh()
    
    var body: some View {
        List {
            // 遍历所有 代理 APP
            ForEach(self.flush.agent_apps, id: \.self) { agent_app in
                HStack{
                    // AppIcon60x60@2x
                    Image(agent_app)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(10)
                        // .clipShape(Circle())
                        // .overlay(Circle().stroke(Color.white, lineWidth: 0))
                        .shadow(radius: 2)
                    Text(agent_app)
                    Spacer()
                    
                    // 代理 APP 检测
                    let detection = AgentDetection()
                    if detection.checkAgentAppIsInstalled(agent_app)
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
        .navigationTitle(Text("代理 APP 检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AgentApplicationDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        AgentApplicationDetectionView()
    }
}

// 刷新当前界面
class AgentApplicationDetectionListRefresh : ObservableObject {
    
    @Published var agent_apps = [
        "Shadowrocket",
        "Quantumult",
        "Quantumult X",
        "Kitsunebi",
        "Surge-iOS",
        "Potatso",
        "Thor"
    ]

    func refresh() {
        agent_apps.append("1")
        agent_apps.removeLast()
    }
}
