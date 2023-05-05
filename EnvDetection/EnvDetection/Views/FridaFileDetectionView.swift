//
//  FridaFileDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct FridaFileDetectionView: View {
    
    @StateObject var viewModel = FridaDetectionViewModel()
    @StateObject var utils = CommonUtils()
    
    var body: some View {
        List {
            // 遍历所有 Frida 相关文件
            ForEach(viewModel.paths, id: \.self) { path in
                HStack{
                    Text(path)
                        .font(.headline)
                    
                    Spacer()
                    
                    // 文件路径检测
                    if utils.checkPath(path: path) {
                        Text("发现")
                            .font(.headline)
                            .foregroundColor(.red)
                    } else {
                        Text("未发现")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }
            }
        }   // List
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Frida 文件检测"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: viewModel.refresh
        )
    }
}

struct FridaFileDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FridaFileDetectionView()
    }
}
