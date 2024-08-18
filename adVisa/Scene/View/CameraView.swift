//
//  CameraView.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import SwiftUI
import Vision

struct CameraView: View {
    
    @Binding var image: CGImage?
    @State private var openMainPage = false
    
    var body: some View {
        GeometryReader { geo in
            
            if openMainPage {
                ContentView()
            } else {
                ZStack {
                    if let image = image {
                        Image(decorative: image, scale: 1)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        VStack {
                            ContentUnavailableView("Camera not available...", systemImage: "xmark.circle.fill")
                                .frame(width: geo.size.width, height: geo.size.height)
                            
                            Button {
                                openMainPage = true
                            } label: {
                                Text("Back to home")
                            }
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CameraView(image: Binding<CGImage?>)
//}
