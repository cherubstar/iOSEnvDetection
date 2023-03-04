//
//  JailbreakDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

import SwiftUI

struct JailbreakDetectionView: View {
    
    var body: some View {
        NavigationView {
            List {
                HStack{
                    Text("越狱检测").font(.title)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5, x: 1, y: 1)
                }
                
                NavigationLink(destination: JailbreakFileDetectionView()){
                    HStack {
                        Image(systemName: "doc")
                        Text("文件/目录检测")
                    }
                    .foregroundColor(.blue)
                }
                .padding()
                
            }
            .padding()  // List
            .navigationBarHidden(true)
            
        }   //NavigationView
    }
}

struct JailbreakDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        JailbreakDetectionView()
    }
}
