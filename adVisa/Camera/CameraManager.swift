//
//  CameraManager.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import Foundation
import AVFoundation

class CameraManager: NSObject {
    private let captureSession = AVCaptureSession()
    private var deviceInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private let preferredCamera = AVCaptureDevice.default(for: .video)
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    
    var addToPreviewStream: ((CGImage) -> Void)?
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    override init() {
        super.init()
        
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    private func configureSession() async {
        guard await isAuthorized,
              let preferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: preferredCamera)
        else { return }
        
        captureSession.beginConfiguration()
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard captureSession.canAddInput(deviceInput) else {
            print("Can't do input adding to the camera session.")
            return
        }
        
        guard captureSession.canAddOutput(videoOutput) else {
            print("Can't do output adding to the camera session.")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
    }
    
    private func startSession() async {
        guard await isAuthorized else { return }
        
        captureSession.startRunning()
    }
    
    
}
