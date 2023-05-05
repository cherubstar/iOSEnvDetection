//
//  JailbreakDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct JailbreakDetectionView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: JailbreakFileAndFolderDetectionView()){
                    HStack {
                        Image(systemName: "doc")
                            .imageScale(.large)
                        
                        Text("文件/目录检测")
                            .font(.headline)
                    }
                    .foregroundColor(.blue)
                }
                .padding()
                
                NavigationLink(destination: PluginApplicationDetectionView()){
                    HStack {
                        Image(systemName: "folder")
                            .imageScale(.large)
                        Text("插件 APP 检测")
                            .font(.headline)
                    }
                    .foregroundColor(.blue)
                }
                .padding()

                NavigationLink(destination: Text("待开发")){
                    HStack {
                        Image(systemName: "r.circle")
                            .imageScale(.large)
                        Text("内核相关检测（待开发）")
                            .font(.headline)
                    }
                    .foregroundColor(.blue)
                }
                .padding()
            }   // List
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("越狱检测")
        }
    }
}

struct JailbreakDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        JailbreakDetectionView()
    }
}
