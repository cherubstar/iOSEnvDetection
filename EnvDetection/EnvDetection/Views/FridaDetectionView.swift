//
//  FridaDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct FridaDetectionView: View {
    
    @StateObject var viewModel = FridaDetectionViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: FridaFileDetectionView()){
                        HStack {
                            Image(systemName: "doc")
                                .imageScale(.large)
                            Text("文件检测")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                    .padding()
                    
                    // 端口检测
                    HStack {
                        Image(systemName: "p.circle")
                            .imageScale(.large)
                        Text("端口检测")
                            .font(.headline)
                        
                        Spacer()
                        
                        
                        
                        // 端口检测
                        if viewModel.isOpen27042 {
                            Text("发现")
                                .font(.headline)
                                .foregroundColor(.red)
                        } else {
                            Text("未发现")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }   // List
                .listStyle(InsetGroupedListStyle())
            
                // 刷新
                Button {
                    viewModel.checkListeningPort27042()
                } label: {
                    HStack {
                        Image(systemName: "hand.tap")
                            .imageScale(.large)
                        Text("检测")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.cornerRadius(10).shadow(radius: 10))
                }
                .padding([.horizontal, .bottom])
            }   // VStack
            .navigationTitle("Frida检测")
        }
    }
}

struct FridaDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FridaDetectionView()
    }
}
