//
//  CommonUtils.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import Foundation

class CommonUtils: ObservableObject {
    
    @Published var detection = FileAndFolderPathDetection()
    
    // 文件/目录的路径检测
    func checkPath(path: String) -> Bool {
        if detection.checkPath(byNSFileManager: path) ||
            detection.checkPath(byAccess: path)     ||
            detection.checkPath(byStat: path)       ||
            detection.checkPath(byLstat: path)      ||
            detection.checkPath(byStatfs: path)     ||
            detection.checkPath(byOpen: path)       ||
            detection.checkPath(byFopen: path) {
            return true
        }
        
        return false
    }
    
}
