//  ContentView.swift
//  adVisa
//
//  Created by Lonard Steven on 12/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
//    @State private var cameraVm = CameraViewModel()
    @State private var openCamera = false
    @State var selectedBar = 1
    
    @StateObject var agreementViewModel = DataPolicyViewModel()
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $selectedBar) {
//                    ZStack {
//                        VStack {
//                            Button {
//                                openCamera.toggle()
//                            } label: {
//                                Text("Open camera")
//                            }
//                        }
//                    }
//                    .frame(width: geo.size.width, height: geo.size.height)
//                    .fullScreenCover(isPresented: $openCamera) {
//                        CameraLayerView(selectedDocument: .ktp)
//                            .ignoresSafeArea()
//                    }
                ZStack {
                    DiscoverPage(selectedBar: $selectedBar)
                }
                    .tabItem {
                        Label("Discover", systemImage: "map.circle.fill")
                    }.tag(1)
                
                ZStack {
                    HistoryPage()
                }
                    .tabItem {
                        Label("History", systemImage: "clock.fill")
                    }.tag(2)
                
                ZStack {
                    SavedDocumentPage()
                }
                    .tabItem {
                        Label("Documents", systemImage: "doc")
                    }.tag(3)
            }
        }
        .onAppear(perform: {
            let appearance = UITabBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            
            appearance.backgroundColor = .primaryWhite
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        })
        .task {
            SwiftDataContextManager()
        }
        .sheet(isPresented: $agreementViewModel.showSheet, content: {
            DataPolicySheet(viewModel: agreementViewModel)
                .presentationDragIndicator(.visible)
        })

    }
}

#Preview {
    ContentView()
}
