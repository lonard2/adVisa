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
    private var isCapturingImage = false
    private var deviceInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var instructions: UILabel!
    private var bottomLayer = UIView()
    private var topLayer = UIView()
    private var backButton = UIButton(type: .system)
    
    private var instructionGuidelineImage = UIImage()
    private var instructionGuidelineImageView = UIImageView()
    
    private var flashButton = UIButton(type: .system)
    private var flashButtonBorder = UIView()
    
    private let circularButton = UIButton(type: .system)
    private var circularButtonBorder = UIView()
    
    private var sessionQueue = DispatchQueue(label: "advisa.camerascanner.preview.scene")
    
    var screenRect: CGRect! = nil
    
    private var previewLayer = AVCaptureVideoPreviewLayer()
    
    var addToPreviewStream: ((CGImage) -> Void)?
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.textAlignment = .center
        instructions.text = "Use a solid background and put the object within the frame."
        instructions.font = UIFont.systemFont(ofSize: 18)
        instructions.textColor = .black
        instructions.numberOfLines = 0
        
        instructionGuidelineImage = UIImage(named: "passport_bio_camera_guide.png")!
        
        instructionGuidelineImageView = UIImageView(image: instructionGuidelineImage)
        instructionGuidelineImageView.translatesAutoresizingMaskIntoConstraints = false
        instructionGuidelineImageView.tintColor = .white
        instructionGuidelineImageView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        
        circularButton.backgroundColor = .blue
        
        circularButton.layer.cornerRadius = 30
        circularButton.clipsToBounds = true
        circularButton.translatesAutoresizingMaskIntoConstraints = false
        circularButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        
        circularButtonBorder = UIView()
        circularButtonBorder.layer.cornerRadius = 30
        circularButtonBorder.clipsToBounds = true
        circularButtonBorder.translatesAutoresizingMaskIntoConstraints = false
        
        circularButtonBorder.tintColor = .none
        circularButtonBorder.backgroundColor = .none
        circularButtonBorder.layer.borderWidth = 2
        circularButtonBorder.layer.borderColor = UIColor.gray.cgColor
        
        topLayer = UIView()
        topLayer.backgroundColor = .white
        topLayer.translatesAutoresizingMaskIntoConstraints = false
        topLayer.alpha = 0.2
        
        let chevronImage = UIImage(systemName: "chevron.backward")
        backButton.setImage(chevronImage, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backButton.tintColor = .blue
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.contentHorizontalAlignment = .leading

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let flashIcon = UIImage(systemName: "bolt.circle.fill")
        flashButton.setImage(flashIcon, for: .normal)
        flashButton.tintColor = .black
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        
        flashButton.addTarget(self, action: #selector(toggleTorch), for: .touchUpInside)
        
        flashButtonBorder = UIView()
        flashButtonBorder.layer.cornerRadius = 21
        flashButtonBorder.clipsToBounds = true
        
        flashButtonBorder.tintColor = .none
        flashButtonBorder.backgroundColor = .none
        flashButtonBorder.layer.borderWidth = 2
        flashButtonBorder.layer.borderColor = UIColor.gray.cgColor
        flashButtonBorder.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLayer = UIView()
        bottomLayer.translatesAutoresizingMaskIntoConstraints = false
        bottomLayer.backgroundColor = .white
        
        bottomLayer.addSubview(circularButton)
        bottomLayer.addSubview(circularButtonBorder)
        bottomLayer.addSubview(flashButton)
        bottomLayer.addSubview(flashButtonBorder)
        bottomLayer.addSubview(instructions)
        
        bottomLayer.bringSubviewToFront(flashButton)
        bottomLayer.bringSubviewToFront(circularButton)

        view.addSubview(topLayer)
        view.addSubview(instructionGuidelineImageView)
        view.addSubview(bottomLayer)
        view.addSubview(backButton)
        view.addSubview(circularButton)
        
        NSLayoutConstraint.activate([
            topLayer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
            
            topLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLayer.topAnchor.constraint(equalTo: view.topAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: topLayer.leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: topLayer.bottomAnchor, constant: -16),
            
            instructionGuidelineImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionGuidelineImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            bottomLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomLayer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            circularButton.bottomAnchor.constraint(equalTo: bottomLayer.bottomAnchor, constant: -32),
            circularButton.centerXAnchor.constraint(equalTo: bottomLayer.centerXAnchor),
            circularButton.widthAnchor.constraint(equalToConstant: 60),
            circularButton.heightAnchor.constraint(equalToConstant: 60),
            
            circularButtonBorder.centerXAnchor.constraint(equalTo: circularButton.centerXAnchor),
            circularButtonBorder.centerYAnchor.constraint(equalTo: circularButton.centerYAnchor),
            circularButtonBorder.widthAnchor.constraint(equalToConstant: 68),
            circularButtonBorder.heightAnchor.constraint(equalToConstant: 68),
            
            flashButton.bottomAnchor.constraint(equalTo: bottomLayer.bottomAnchor, constant: -40),
            flashButton.trailingAnchor.constraint(equalTo: bottomLayer.trailingAnchor, constant: -32),
            flashButton.widthAnchor.constraint(equalToConstant: 50),
            flashButton.heightAnchor.constraint(equalToConstant: 50),
            
            flashButtonBorder.centerXAnchor.constraint(equalTo: flashButton.centerXAnchor),
            flashButtonBorder.centerYAnchor.constraint(equalTo: flashButton.centerYAnchor),
            flashButtonBorder.widthAnchor.constraint(equalToConstant: 50),
            flashButtonBorder.heightAnchor.constraint(equalToConstant: 50),
            
            instructions.bottomAnchor.constraint(equalTo: circularButton.topAnchor, constant: -20),
            instructions.centerXAnchor.constraint(equalTo: bottomLayer.centerXAnchor),
            instructions.leadingAnchor.constraint(equalTo: bottomLayer.leadingAnchor, constant: 20),
            instructions.trailingAnchor.constraint(equalTo: bottomLayer.trailingAnchor, constant: -20),
        ])
    }
    
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
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        previewLayer.connection?.videoRotationAngle = 90
        
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.insertSublayer(self!.previewLayer, at: 0)
        }
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: any UIViewControllerTransitionCoordinator) {
        screenRect = UIScreen.main.bounds
        previewLayer.frame = view.bounds
        
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
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func toggleTorch() {
        guard let device = AVCaptureDevice.userPreferredCamera else {
            print("Capture device couldn't be initialized.")
            return
        }
        guard device.hasTorch else {
            print("Torch functionality isn't available right now.")
            return
        }
        
        do {
            try device.lockForConfiguration()
            
            let torchOn = !device.isTorchActive
            try device.setTorchModeOn(level: 1.0)
            device.torchMode = torchOn ? .on : .off
            
            device.unlockForConfiguration()
        } catch {
            print("Error occurred while toggling torch feature, due to \(error)")
    @objc private func captureImage() {
        isCapturingImage = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard isCapturingImage else { return }
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        // Reset the flag after capturing the image
        isCapturingImage = false

        DispatchQueue.main.async {
            self.processCapturedImage(ciImage)
        }
    }
    
    private func processCapturedImage(_ image: CIImage) {
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Extract recognized text
            let recognizedTexts = observations.compactMap { $0.topCandidates(1).first?.string }
            self.extractIdentityCardData(from: recognizedTexts)
        }
        
        request.recognitionLevel = .accurate
        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform text recognition: \(error.localizedDescription)")
            }
        }
    }
    
    private func extractIdentityCardData(from recognizedTexts: [String]) {
        var identityId: String?
        var maritalStatus: MaritalStatusEnum?
        
        for text in recognizedTexts {
            if text.contains("NIK") || text.range(of: #"\d{16}"#, options: .regularExpression) != nil {
                identityId = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            }
            
            if text.uppercased().contains("BELUM KAWIN") {
                maritalStatus = .single
            } else if text.uppercased().contains("KAWIN") {
                maritalStatus = .married
            }
        }
        
        if let identityId = identityId, let maritalStatus = maritalStatus {
            DispatchQueue.main.async {
                print("NIK \(identityId)")
                print("Status \(maritalStatus)")
            }
        } else {
            DispatchQueue.main.async {
                print("Could not extract identity data.")
            }
        }
    }
    
}
