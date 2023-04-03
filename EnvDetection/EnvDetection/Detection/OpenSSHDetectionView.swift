//
//  OpenSSHDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/24.
//

import SwiftUI

struct OpenSSHDetectionView: View {
    
    @ObservedObject var flush: OpenSSHDetectionListRefresh = OpenSSHDetectionListRefresh()
    
    var body: some View {
        List {
            NavigationLink(destination: OpenSSHFileDetectionView()){
                HStack{
                    HStack {
                        Image(systemName: "doc")
                        Text("文件检测")
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
            
            HStack {
                Text(self.flush.paths[0])
                Spacer()

                // 端口检测
                let detection = OpenSSHDetection()
                if detection.checkListeningPort22() {
                    Text("发现")
                        .foregroundColor(.red)
                } else {
                    Text("未发现")
                        .foregroundColor(.green)
                }
            }
            .padding()
             
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
        .navigationTitle(Text("OpenSSH 服务检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OpenSSHDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSSHDetectionView()
    }
}

// 刷新当前界面
class OpenSSHDetectionListRefresh : ObservableObject {
    
    @Published var paths = [
        "端口检测",
    ]

    func refresh() {
        paths.append("1")
        paths.removeLast()
    }
}
