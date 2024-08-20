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
    
    var body: some View {
        GeometryReader { geo in
            TabView {
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
                    .tabItem {
                        Label("Discover", systemImage: "map.circle.fill")
                    }
                    .fullScreenCover(isPresented: $openCamera) {
                        CameraLayerView()
                            .ignoresSafeArea()
                    }
                
                Text("History Page")
                    .tabItem {
                        Label("History", systemImage: "clock.fill")
                    }
                
                
                Text("Saved Document Page")
                    .tabItem {
                        Label("Discover", systemImage: "doc")
                    }
            }
        }
        .task {
            SwiftDataContextManager()
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(for: Document.self)
}
