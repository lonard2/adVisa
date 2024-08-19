//
//  CameraView.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import SwiftUI
import Vision
import AVFoundation
import UIKit

class CameraViewController : UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var isAuthorized = false
    
    private let captureSession = AVCaptureSession()
    private var deviceInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var sessionQueue = DispatchQueue(label: "advisa.camerascanner.preview.scene")
    
    var screenRect: CGRect! = nil
    
    private var previewLayer = AVCaptureVideoPreviewLayer()
    
    var addToPreviewStream: ((CGImage) -> Void)?
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
        case .notDetermined:
            requestPermission()
        default:
            isAuthorized = false
        }
    }
    func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            isAuthorized = granted
            sessionQueue.resume()
        }
    }

    
//    lazy var previewStream: AsyncStream<CGImage> = {
//        AsyncStream { continuation in
//            addToPreviewStream = { cgImage in
//                continuation.yield(cgImage)
//            }
//        }
//    }()
    
    override func viewDidLoad() {
        checkPermission()
        
        sessionQueue.async {
            guard self.isAuthorized else { return }
            self.configureSession()
            self.captureSession.startRunning()
        }
    }
    
    private func configureSession() {
        guard let preferredCamera = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back)
        else {
            print("Camera couldn't be initialized.")
            return
        }
        
        if preferredCamera.supportsSessionPreset(.hd4K3840x2160) {
            captureSession.sessionPreset = .hd4K3840x2160
        } else {
            captureSession.sessionPreset = .hd1920x1080
        }
        
        captureSession.beginConfiguration()
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: preferredCamera)
        else {
            print("Device input error!")
            return
        }
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange ]
        
        guard captureSession.canAddInput(deviceInput) else {
            print("Can't do input adding to the camera session.")
            return
        }
        
        guard captureSession.canAddOutput(videoOutput) else {
            print("Can't do output adding to the camera session.")
            return
        }
        
        do {
            try preferredCamera.lockForConfiguration()
            preferredCamera.videoZoomFactor = 2
            preferredCamera.autoFocusRangeRestriction = .none
            preferredCamera.unlockForConfiguration()
        } catch {
            print("Couldn't set zoom due to: \(error)")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        
        screenRect = UIScreen.main.bounds
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        previewLayer.connection?.videoRotationAngle = 90
        
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.addSublayer(self!.previewLayer)
        }
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: any UIViewControllerTransitionCoordinator) {
        screenRect = UIScreen.main.bounds
        self.previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        
        switch UIDevice.current.orientation {
        case UIDeviceOrientation.portraitUpsideDown:
            self.previewLayer.connection?.videoRotationAngle = 270
        case UIDeviceOrientation.landscapeLeft:
            self.previewLayer.connection?.videoRotationAngle = 0
        case UIDeviceOrientation.landscapeRight:
            self.previewLayer.connection?.videoRotationAngle = 180
        case UIDeviceOrientation.portrait:
            self.previewLayer.connection?.videoRotationAngle = 90
        default:
            break
        }
    }
    
}

//struct CameraView: View {
//    
//    @Binding var image: CGImage?
//    @State private var openMainPage = false
//    
//    var body: some View {
//        GeometryReader { geo in
//            
//            if openMainPage {
//                ContentView()
//            } else {
//                ZStack {
//                    if let image = image {
//                        Image(decorative: image, scale: geo.size.height)
//                            .resizable()
//                            .rotationEffect(.degrees(90))
//                            .scaledToFit()
//                            .frame(width: geo.size.width, height: geo.size.height)
//                    } else {
//                        VStack {
//                            ContentUnavailableView("Camera not available...", systemImage: "xmark.circle.fill")
//                                .frame(width: geo.size.width, height: geo.size.height)
//                            
//                            Button {
//                                openMainPage = true
//                            } label: {
//                                Text("Back to home")
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

//#Preview {
//    CameraView(image: Binding<CGImage?>)
//}
