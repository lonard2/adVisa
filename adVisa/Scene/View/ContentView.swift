//
//  ContentView.swift
//  adVisa
//
//  Created by Lonard Steven on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cameraVm = CameraViewModel()
    @State private var openCamera = false
    
    var body: some View {
        
//        GeometryReader { geo in
//            if openCamera {
//                CameraView(image: $cameraVm.currentFrame)
//            } else {
//                ZStack {
//                    VStack {
//                        Button {
//                            openCamera = true
//                        } label: {
//                            Text("Open camera")
//                        }
//                    }
//                }
//                .frame(width: geo.size.width, height: geo.size.height)
//            }
//        }
        
        TabView {
            Text("Discover Page")
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
