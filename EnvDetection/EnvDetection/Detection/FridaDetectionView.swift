//
//  FridaDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

import SwiftUI

struct FridaDetectionView: View {
    
    @ObservedObject var flush: FridaDetectionListRefresh = FridaDetectionListRefresh()
    
    var body: some View {
        NavigationView {
            List {
                HStack{
                    Text("Frida检测").font(.title)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5, x: 1, y: 1)
                }
                
                NavigationLink(destination: FridaFileDetectionView()){
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
                    if checkListeningPort() == 0 {
                        Text("发现")
                            .foregroundColor(.red)
                    } else {
                        Text("未发现")
                            .foregroundColor(.green)
                    }
                }
                .padding()
                
                HStack {
                    Text(self.flush.paths[1])
                    Spacer()

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
            .navigationBarHidden(true)
        }
    }
}

struct FridaDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FridaDetectionView()
    }
}

// 刷新当前界面
class FridaDetectionListRefresh : ObservableObject {
    
    @Published var paths = [
        "端口检测",
        "进程检测（待开发）",
        "Maps记录检测（待开发）",
        "内存特征检测（待开发）"
    ]

    func refresh() {
        paths.append("1")
        paths.removeLast()
    }
}
