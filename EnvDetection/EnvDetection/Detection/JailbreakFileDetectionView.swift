//
//  JailbreakFileDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/4.
//

import SwiftUI

struct JailbreakFileDetectionView: View {
    
    @ObservedObject var flush: JailbreakFileDetectionListRefresh = JailbreakFileDetectionListRefresh()
    
    var body: some View {
        List {
            
            // 遍历所有越狱文件/目录
            ForEach(self.flush.paths, id: \.self) { path in
                HStack{
                    Text(path)
                    Spacer()
                    
                    // 文件路径检测
                    let detection = FileAndFolderPathDetection()
                    if detection.checkPath(byNSFileManager: path) ||
                        detection.checkPath(byAccess: path)     ||
                        detection.checkPath(byStat: path)       ||
                        detection.checkPath(byLstat: path)      ||
                        detection.checkPath(byStatfs: path)     ||
                        detection.checkPath(byOpen: path)       ||
                        detection.checkPath(byFopen: path)
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
        .navigationTitle(Text("文件/目录检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct JailbreakFileDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        JailbreakFileDetectionView()
    }
}

// 刷新当前界面
class JailbreakFileDetectionListRefresh : ObservableObject {
    
    @Published var paths = [
        "/Applications/Cydia.app",
        "/var/mobile/Library/Cydia",
        "/private/var/lib/cydia",
        "/var/lib/cydia",
        "/Library/MobileSubstrate/MobileSubstrate.dylib"
    ]

    func refresh() {
        paths.append("1")
        paths.removeLast()
    }
}
