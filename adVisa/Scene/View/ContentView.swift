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
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $selectedBar) {
                    ZStack {
                        VStack {
                            Button {
                                openCamera.toggle()
                            } label: {
                                Text("Open camera")
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .fullScreenCover(isPresented: $openCamera) {
                        CameraLayerView()
                            .ignoresSafeArea()
                    }
                
                DiscoverPage(selectedBar: $selectedBar)
                    .tabItem {
                        Label("Discover", systemImage: "map.circle.fill")
                    }.tag(1)
                
                Text("History Page")
                    .tabItem {
                        Label("History", systemImage: "clock.fill")
                    }.tag(2)
                
                
                SavedDocumentPage()
                    .tabItem {
                        Label("Discover", systemImage: "doc")
                    }.tag(3)
            }
        }
        .task {
            SwiftDataContextManager()
        }

    }
    
}

#Preview {
    ContentView()
}
