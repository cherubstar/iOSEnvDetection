//
//  ContentView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

import SwiftUI

struct EnvDetection: View {

    var body: some View {
        TabView(selection: .constant(1)) {
            JailbreakDetectionView()
                .tabItem {
                    Image(systemName: "lock.open").imageScale(.large)
                    Text("越狱检测")
            }.tag(1)
            FridaDetectionView()
                .tabItem {
                    Image(systemName: "f.circle").imageScale(.large)
                    Text("Frida检测")
            }.tag(2)
            AgentDetectionView()
                .tabItem {
                    Image(systemName: "network").imageScale(.large)
                    Text("代理检测")
            }.tag(3)
            DebugDetectionView()
                .tabItem {
                    Image(systemName: "hammer").imageScale(.large)
                    Text("调试检测")
            }.tag(4)
            OtherDetectionView()
                .tabItem {
                    Image(systemName: "bolt").imageScale(.large)
                    Text("其他检测")
            }.tag(5)
        }
    }
}

struct EnvDetection_Previews: PreviewProvider {
    static var previews: some View {
        EnvDetection()
    }
}
