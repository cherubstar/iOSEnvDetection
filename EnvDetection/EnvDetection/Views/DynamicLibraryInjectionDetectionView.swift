//
//  DynamicLibraryInjectionDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct DynamicLibraryInjectionDetectionView: View {
    
    @StateObject var viewModel = OtherDetectionViewModel()
    
    var body: some View {
        List {
            // 检测所有非法注入的动态库
            let dyld_array = viewModel.getDyldArray()
            
            // 遍历非法注入的动态库
            ForEach(dyld_array, id: \.self) { path in
                HStack{
                    Text(path)
                        .font(.headline)
                    Spacer()
                    
                    Text("发现")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
            }
        }   // List
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("动态库注入检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DynamicLibraryInjectionDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicLibraryInjectionDetectionView()
    }
}
