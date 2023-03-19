//
//  FridaFileDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/4.
//

import SwiftUI

struct FridaFileDetectionView: View {
    
    @ObservedObject var flush: FridaFileDetectionListRefresh = FridaFileDetectionListRefresh()
    
    var body: some View {
        List {
            // 遍历所有 Frida 相关文件
            ForEach(self.flush.paths, id: \.self) { path in
                HStack{
                    Text(path)
                    Spacer()
                    
                    // 文件路径检测
                    let detection = FridaDetection();
                    if detection.checkFileIsExists(byNSFileManager: path) ||
                        detection.checkFileIsExists(byAccess: path)     ||
                        detection.checkFileIsExists(byStat: path)       ||
                        detection.checkFileIsExists(byLstat: path)      ||
                        detection.checkFileIsExists(byStatfs: path)     ||
                        detection.checkFileIsExists(byOpen: path)       ||
                        detection.checkFileIsExists(byFopen: path)
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
        .navigationTitle(Text("Frida 文件检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FridaFileDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FridaFileDetectionView()
    }
}

// 刷新当前界面
class FridaFileDetectionListRefresh : ObservableObject {
    
    @Published var paths = [
        "/usr/sbin/frida-server",
        "/usr/lib/frida/frida-server",
        "/usr/lib/frida/frida-agent.dylib",
    ]

    func refresh() {
        paths.append("1")
        paths.removeLast()
    }
}
