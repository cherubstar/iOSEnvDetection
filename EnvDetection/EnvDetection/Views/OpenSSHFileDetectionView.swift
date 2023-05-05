//
//  OpenSSHFileDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct OpenSSHFileDetectionView: View {
    
    @StateObject var viewModel = OtherDetectionViewModel()
    @StateObject var utils = CommonUtils()
    
    var body: some View {
        List {
            // 遍历所有 OpenSSH 相关文件
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
                .padding([.leading, .trailing])
            }
        }   // List
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("OpenSSH 文件检测"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: viewModel.refresh
        )
    }
}

struct OpenSSHFileDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSSHFileDetectionView()
    }
}
