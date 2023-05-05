//
//  AgentDetectionView.swift
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

import SwiftUI

struct AgentDetectionView: View {
    
    @StateObject var viewModel = AgentDetectionViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: AgentApplicationDetectionView()){
                        HStack {
                            Image(systemName: "folder")
                                .imageScale(.large)
                            Text("代理 APP 检测")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("常规代理检测函数")
                                .font(.headline)
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    viewModel.showCFNetworkCopySystemProxySettingsDetails.toggle()
                                }
                        }
                        .padding(.bottom)
                        
                        Toggle(isOn: $viewModel.isCFNetworkCopySystemProxySettings){
                            Text("CFNetworkCopySystemProxySettings")
                                .font(.headline)
                        }
                    }
                    .padding()
                    .actionSheet(isPresented: $viewModel.showCFNetworkCopySystemProxySettingsDetails) {
                        // 获取 CFNetworkCopySystemProxySettings 详细
                        viewModel.getCFNetworkCopySystemProxySettingsDetails()
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        viewModel.getAlert()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("设置代理检测变量")
                                .font(.headline)
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    viewModel.showConnectionProxyDictionaryDetails.toggle()
                                }
                        }
                        .padding(.bottom)
                        .actionSheet(isPresented: $viewModel.showConnectionProxyDictionaryDetails) {
                            // 获取 connectionProxyDictionary 详细
                            viewModel.getConnectionProxyDictionaryDetails()
                        }
                        
                        Toggle(isOn: $viewModel.isConnectionProxyDictionary){
                            Text("connectionProxyDictionary")
                                .font(.headline)
                        }
                    }
                    .padding()
                }   // List
                .listStyle(InsetGroupedListStyle())
                
                // 检测当前代理状态
                Button {
                    // 都未勾选
                    if !viewModel.isCFNetworkCopySystemProxySettings && !viewModel.isConnectionProxyDictionary {
                        viewModel.contentAlert = "未勾选上面选项. 😱"
                    } else if viewModel.isCFNetworkCopySystemProxySettings && !viewModel.isConnectionProxyDictionary {
                        // 只勾选了 CFNetworkCopySystemProxySettings
                        viewModel.checkProxyStatus()
                    } else if !viewModel.isCFNetworkCopySystemProxySettings && viewModel.isConnectionProxyDictionary {
                        // 只勾选了 connectionProxyDictionary
                        viewModel.setConnectionProxyDictionary()
                    } else {
                        viewModel.contentAlert = "你怎么能都勾选上面选项呢. 😱"
                    }
                    
                    viewModel.showAlert.toggle()
                } label: {
                    HStack {
                        Image(systemName: "hand.tap")
                            .imageScale(.large)
                        Text("检测")
                            .font(.headline)
                    }
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("代理检测")
        }
    }
}

struct AgentDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        AgentDetectionView()
    }
}
