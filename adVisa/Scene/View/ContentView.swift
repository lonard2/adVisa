//  ContentView.swift
//  adVisa
//
//  Created by Lonard Steven on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var cameraVm = CameraViewModel()
    @State private var openCamera = false
    
    var body: some View {
        
        TabView {
            GeometryReader { geo in
                if openCamera {
                    CameraLayerView()
                        .ignoresSafeArea()
                } else {
                    ZStack {
                        VStack {
                            Button {
                                openCamera = true
                            } label: {
                                Text("Open camera")
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
                .tabItem {
                    Label("Discover", systemImage: "map.circle.fill")
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
}

#Preview {
    ContentView()
}