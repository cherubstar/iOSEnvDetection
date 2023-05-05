//
//  OtherDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct OtherDetectionView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DynamicLibraryInjectionDetectionView()){
                    HStack{
                        HStack {
                            Image(systemName: "repeat")
                                .imageScale(.large)
                            Text("动态库注入检测")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                
                NavigationLink(destination: OpenSSHDetectionView()){
                    HStack {
                        Image(systemName: "key.icloud")
                            .imageScale(.large)
                        Text("OpenSSH 服务检测")
                            .font(.headline)
                    }
                    .foregroundColor(.blue)
                }
                .padding()

                NavigationLink(destination: Text("待开发")){
                    HStack{
                        HStack {
                            Image(systemName: "questionmark.circle")
                                .imageScale(.large)
                            Text("重签名检测（待开发）")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()

                NavigationLink(destination: Text("待开发")){
                    HStack{
                        HStack {
                            Image(systemName: "questionmark.circle")
                                .imageScale(.large)
                            Text("函数 Hook 检测（待开发）")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
            }   // List
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("其他检测")
        }
    }
}

struct OtherDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        OtherDetectionView()
    }
}
