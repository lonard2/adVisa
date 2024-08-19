//
//  CameraManager.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

//class CameraManager: UIViewController {
//    private let captureSession = AVCaptureSession()
//    private var deviceInput: AVCaptureDeviceInput?
//    private var videoOutput: AVCaptureVideoDataOutput?
//    private let preferredCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//    private var sessionQueue = DispatchQueue(label: "advisa.camerascanner.preview.scene")
//    
//    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
//    
//    var addToPreviewStream: ((CGImage) -> Void)?
//    
//    private var isAuthorized: Bool {
//        get async {
//            let status = AVCaptureDevice.authorizationStatus(for: .video)
//            
//            var isAuthorized = status == .authorized
//            
//            if status == .notDetermined {
//                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
//            }
//            
//            return isAuthorized
//        }
//    }
//    
//    lazy var previewStream: AsyncStream<CGImage> = {
//        AsyncStream { continuation in
//            addToPreviewStream = { cgImage in
//                continuation.yield(cgImage)
//            }
//        }
//    }()
//    
//    override func viewDidLoad() {
//        Task {
//            await configureSession()
//            await startSession()
//        }
//    }
//    
//    private func configureSession() async {
//        guard await isAuthorized,
//              let preferredCamera,
//              let deviceInput = try? AVCaptureDeviceInput(device: preferredCamera)
//        else {
//            print("Camera couldn't be initialized.")
//            return
//        }
//        
//        if preferredCamera.supportsSessionPreset(.hd4K3840x2160) {
//            captureSession.sessionPreset = .hd4K3840x2160
//        } else {
//            captureSession.sessionPreset = .hd1920x1080
//        }
//        
//        captureSession.beginConfiguration()
//        
//        defer {
//            self.captureSession.commitConfiguration()
//        }
//        
//        let videoOutput = AVCaptureVideoDataOutput()
//        videoOutput.alwaysDiscardsLateVideoFrames = true
//        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
//        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange ]
//        
//        guard captureSession.canAddInput(deviceInput) else {
//            print("Can't do input adding to the camera session.")
//            return
//        }
//        
//        guard captureSession.canAddOutput(videoOutput) else {
//            print("Can't do output adding to the camera session.")
//            return
//        }
//        
//        do {
//            try preferredCamera.lockForConfiguration()
//            preferredCamera.videoZoomFactor = 2
//            preferredCamera.autoFocusRangeRestriction = .none
//            preferredCamera.unlockForConfiguration()
//        } catch {
//            print("Couldn't set zoom due to: \(error)")
//            return
//        }
//        
//        captureSession.addInput(deviceInput)
//        captureSession.addOutput(videoOutput)
//    }
//    
//    private func startSession() async {
//        guard await isAuthorized else { return }
//        
//        captureSession.startRunning()
//    }
//    
//    
//}
