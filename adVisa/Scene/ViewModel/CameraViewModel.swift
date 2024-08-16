//
//  CameraViewModel.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import Foundation
import CoreImage
import Observation

@Observable
class CameraViewModel {
    var currentFrame: CGImage?
    private let cameraManager = CameraManager()
    
    init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
}
