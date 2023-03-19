//
//  DynamicLibraryInjectionDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/15.
//

import SwiftUI

struct DynamicLibraryInjectionDetectionView: View {
    
    @ObservedObject var flush: DynamicLibraryInjectionDetectionListRefresh = DynamicLibraryInjectionDetectionListRefresh()
    
    var body: some View {
        
        List {
            // 遍历非法注入的动态库
            ForEach(self.flush.dyld_array, id: \.self) { path in
                HStack{
                    Text(path)
                    Spacer()
                    
                    Text("发现")
                        .foregroundColor(.red)
                }
                .padding([.leading, .trailing])
            }
        }
        .padding()  // List
        .navigationTitle(Text("动态库注入检测"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DynamicLibraryInjectionDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicLibraryInjectionDetectionView()
    }
}

// 刷新当前界面
class DynamicLibraryInjectionDetectionListRefresh : ObservableObject {
    
    // 检测所有非法注入的动态库
    @Published var dyld_array = DynamicLibraryInjectionDetection.checkAllDylibIsInject() as! Array<String>

}
