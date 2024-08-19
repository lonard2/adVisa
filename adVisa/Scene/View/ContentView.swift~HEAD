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
        
        GeometryReader { geo in
            if openCamera {
                CameraView(image: $cameraVm.currentFrame)
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
    }
}

#Preview {
    ContentView()
}
