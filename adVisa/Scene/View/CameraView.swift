//
//  CameraView.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import SwiftUI

struct CameraView: View {
    
    @Binding var image: CGImage?
    
    var body: some View {
        GeometryReader { geo in
            if let image = image {
                Image(decorative: image, scale: 1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
            } else {
                ContentUnavailableView("Camera not available...", systemImage: "xmark.circle.fill")
                    .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

//#Preview {
//    CameraView(image: Binding<CGImage?>)
//}
