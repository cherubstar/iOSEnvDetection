//
//  OtherDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/4.
//

import SwiftUI

struct OtherDetectionView: View {
    var body: some View {
        NavigationView {
            List {
                HStack{
                    Text("其他检测").font(.title)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5, x: 1, y: 1)
                }
                
                NavigationLink(destination: DynamicLibraryInjectionDetectionView()){
                    HStack{
                        HStack {
                            Image(systemName: "repeat")
                            Text("动态库注入检测")
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                
                NavigationLink(destination: OpenSSHDetectionView()){
                    HStack {
                        Image(systemName: "key.icloud")
                        Text("OpenSSH 服务检测")
                    }
                    .foregroundColor(.blue)
                }
                .padding()

                NavigationLink(destination: Text("待开发")){
                    HStack{
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("重签名检测（待开发）")
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()

                NavigationLink(destination: Text("待开发")){
                    HStack{
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("函数 Hook 检测（待开发）")
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                
            }
            .padding()  // List
            .navigationBarHidden(true)
        }   // NavigationView
    }
}

struct OtherDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        OtherDetectionView()
    }
}
