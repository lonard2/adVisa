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
import Combine

protocol CameraViewControllerProtocol {
    var passportRepository: PassportRepository? { get set }
    var identityCardRepository: IdentityCardRepository? { get set }
}

class CameraViewController : UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, CameraViewControllerProtocol, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var passportRepository: PassportRepository?
    var identityCardRepository: IdentityCardRepository?
    
    var navigationManager: NavigationManager?
    
    private var cancellables: Set<AnyCancellable> = []
    private var isAuthorized = false
    
    private let captureSession = AVCaptureSession()
    private var isCapturingImage = false
    private var deviceInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var instructions: UILabel!
    private var bottomLayer = UIView()
    private var topLayer = UIView()
    private var backButton = UIButton(type: .system)
    
    
    private var capturedImageView: UIImageView!
    private var capturedImage: UIImage?
    
    private var instructionGuidelineImage = UIImage()
    private var instructionGuidelineImageView = UIImageView()
    
    private var flashButton = UIButton(type: .system)
    private var flashButtonBorder = UIView()
    
    private var photoPickButton = UIButton(type: .system)
    private var photoPickButtonBorder = UIView()
    
    private let circularButton = UIButton(type: .system)
    private var circularButtonBorder = UIView()
    
    private var sessionQueue = DispatchQueue(label: "advisa.camerascanner.preview.scene")
    
    var screenRect: CGRect! = nil
    
    private var previewLayer = AVCaptureVideoPreviewLayer()
    
    var addToPreviewStream: ((CGImage) -> Void)?
    
    var selectedDocument: DocumentTypeDetailed = .none
    var selectedDocumentFile: String = ""
    var selectedDocumentWidth: Int = 200
    var selectedDocumentHeight: Int = 200
    
    var cropWidth: Int = 720
    var cropHeight: Int = 1200
    
    @State var alreadyTakenPicture: Bool = false
    var savedDocumentViewModel = SavedDocumentViewModel()
    var showDocumentSheetBinding: Binding<Bool>
    var captureCompleteBinding: Binding<Bool>

    init(showDocumentSheetBinding: Binding<Bool>, captureCompleteBinding: Binding<Bool>) {
        self.showDocumentSheetBinding = showDocumentSheetBinding
        self.captureCompleteBinding = captureCompleteBinding
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        capturedImageView = UIImageView()
        capturedImageView.translatesAutoresizingMaskIntoConstraints = false
        capturedImageView.contentMode = .scaleAspectFit
        capturedImageView.clipsToBounds = true
        capturedImageView.isHidden = true
        capturedImageView.transform = CGAffineTransform(rotationAngle: .pi/2)
        capturedImageView.sizeToFit()
        
        view.addSubview(capturedImageView)
        
        instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.textAlignment = .center
        instructions.text = "Use a solid background and put the object within the frame."
        instructions.font = UIFont.systemFont(ofSize: 18)
        instructions.textColor = .black
        instructions.numberOfLines = 0
        
        switch(selectedDocument) {
        case .passport_bio:
            selectedDocumentFile = "passport_bio_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .passport_endorsement:
            selectedDocumentFile = "passport_endorsement_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .ktp:
            selectedDocumentFile = "identity_card_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .self_portrait:
            selectedDocumentFile = "self_portrait_guideline_camera.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .bank_statement:
            selectedDocumentFile = "generic_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .none:
            selectedDocumentFile = "generic_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .tiket_pesawat:
            selectedDocumentFile = "generic_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .hotel:
            selectedDocumentFile = "generic_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        case .family_card:
            selectedDocumentFile = "generic_camera_guide.png"
            selectedDocumentWidth = 250
            selectedDocumentHeight = 250
        }
        
        instructionGuidelineImage = UIImage(named: selectedDocumentFile)!
        
        instructionGuidelineImageView = UIImageView(image: instructionGuidelineImage)
        instructionGuidelineImageView.translatesAutoresizingMaskIntoConstraints = false
        instructionGuidelineImageView.tintColor = .white
        instructionGuidelineImageView.frame = CGRect(x: 0, y: 0, width: selectedDocumentWidth, height: selectedDocumentHeight)
        
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
        
        let photoPickIcon = UIImage(systemName: "photo.badge.plus")
        photoPickButton.setImage(photoPickIcon, for: .normal)
        photoPickButton.tintColor = .black
        photoPickButton.translatesAutoresizingMaskIntoConstraints = false
        photoPickButton.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        
        photoPickButtonBorder = UIView()
        photoPickButtonBorder.layer.cornerRadius = 21
        photoPickButtonBorder.clipsToBounds = true
        
        photoPickButtonBorder.tintColor = .none
        photoPickButtonBorder.backgroundColor = .none
        photoPickButtonBorder.layer.borderWidth = 2
        photoPickButtonBorder.layer.borderColor = UIColor.gray.cgColor
        photoPickButtonBorder.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLayer = UIView()
        bottomLayer.translatesAutoresizingMaskIntoConstraints = false
        bottomLayer.backgroundColor = .white
        
        bottomLayer.addSubview(circularButton)
        bottomLayer.addSubview(circularButtonBorder)
        bottomLayer.addSubview(flashButton)
        bottomLayer.addSubview(flashButtonBorder)
        bottomLayer.addSubview(instructions)
        bottomLayer.addSubview(photoPickButton)
        bottomLayer.addSubview(photoPickButtonBorder)
        
        bottomLayer.bringSubviewToFront(flashButton)
        bottomLayer.bringSubviewToFront(circularButton)
        bottomLayer.bringSubviewToFront(photoPickButton)

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
            
            capturedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            capturedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            capturedImageView.topAnchor.constraint(equalTo: view.topAnchor),
            capturedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            
            photoPickButton.bottomAnchor.constraint(equalTo: bottomLayer.bottomAnchor, constant: -40),
            photoPickButton.leadingAnchor.constraint(equalTo: bottomLayer.leadingAnchor, constant: 32),
            photoPickButton.widthAnchor.constraint(equalToConstant: 50),
            photoPickButton.heightAnchor.constraint(equalToConstant: 50),
            
            photoPickButtonBorder.centerXAnchor.constraint(equalTo: photoPickButton.centerXAnchor),
            photoPickButtonBorder.centerYAnchor.constraint(equalTo: photoPickButton.centerYAnchor),
            photoPickButtonBorder.widthAnchor.constraint(equalToConstant: 50),
            photoPickButtonBorder.heightAnchor.constraint(equalToConstant: 50),
            
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
        videoOutput.videoSettings = [AVVideoWidthKey: 3840, AVVideoHeightKey: 2160]
        
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
            preferredCamera.videoZoomFactor = 1
            preferredCamera.autoFocusRangeRestriction = .none
            preferredCamera.unlockForConfiguration()
        } catch {
            print("Couldn't set zoom due to: \(error)")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        
        screenRect = UIScreen.main.bounds
        
        DispatchQueue.main.async { [weak self] in
            self!.previewLayer = AVCaptureVideoPreviewLayer(session: self!.captureSession)
            self!.previewLayer.frame = self!.view.bounds
            self!.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            self!.previewLayer.connection?.videoRotationAngle = 90
            
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
            
        }
    }
    
    @objc private func captureImage() {
        isCapturingImage = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard isCapturingImage else { return }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let ciImage = CIImage(cvPixelBuffer: imageBuffer)
            
            let context = CIContext()
            
            let rect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(imageBuffer), height: CVPixelBufferGetHeight(imageBuffer))
            if let cgImage = context.createCGImage(ciImage, from: rect) {
                var image = UIImage(cgImage: cgImage, scale: 1.0, orientation: .up)
                
                switch(selectedDocument) {
                case .passport_bio:
                    cropWidth = 960
                    cropHeight = 1400
                    self.savedDocumentViewModel.processedDocumentType = .passport_bio
                case .passport_endorsement:
                    cropWidth = 1150
                    cropHeight = 780
                    self.savedDocumentViewModel.processedDocumentType = .passport_endorsement
                case .ktp:
                    cropWidth = 960
                    cropHeight = 1400
                    self.savedDocumentViewModel.processedDocumentType = .ktp
                case .self_portrait:
                    self.savedDocumentViewModel.processedDocumentType = .self_portrait
                    return
                case .bank_statement:
                    self.savedDocumentViewModel.processedDocumentType = .bank_statement
                    return
                case .none:
                    self.savedDocumentViewModel.processedDocumentType = .passport_bio
                    cropWidth = 1080
                    cropHeight = 780
                case .tiket_pesawat:
                    self.savedDocumentViewModel.processedDocumentType = .tiket_pesawat
                    cropWidth = 1150
                    cropHeight = 780
                case .hotel:
                    self.savedDocumentViewModel.processedDocumentType = .hotel
                    cropWidth = 1150
                    cropHeight = 780
                case .family_card:
                    self.savedDocumentViewModel.processedDocumentType = .family_card
                    return
                }
                if let croppedImage = cropMiddlePartOfImage(image: image, cropWidth: CGFloat(cropWidth), cropHeight: CGFloat(cropHeight)) {
                    if let image = CIImage(image: croppedImage) {
                        self.processCapturedImage(image)
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    return
                }
            }
        }
        isCapturingImage = false
    }
    
    func fixOrientation(_ image: UIImage) -> UIImage {
        if image.imageOrientation == .up {
            return image
        }

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    private func convertPixelBufferToUIImage(_ pixelBuffer: CVPixelBuffer) -> UIImage {
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()

        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return UIImage()
        }
    }
    
//    private func displayCapturedImage(_ image: UIImage) {
//        DispatchQueue.main.async {
//            self.capturedImage = image
//            self.capturedImageView.image = image
//            self.capturedImageView.clipsToBounds = true
//            self.capturedImageView.isHidden = false
//        }
//    }
    
    private func cropMiddlePartOfImage(image: UIImage, cropWidth: CGFloat, cropHeight: CGFloat) -> UIImage? {
        let originalWidth = image.size.width
        let originalHeight = image.size.height

        let cropWidth = min(cropWidth, originalWidth)
        let cropHeight = min(cropHeight, originalHeight)
        
        let xOffset = (originalWidth - cropWidth) / 2
        let yOffset = (originalHeight - cropHeight) / 2
        
        let cropRect = CGRect(x: xOffset, y: yOffset, width: cropWidth, height: cropHeight)
        
        guard let cgImage = image.cgImage?.cropping(to: cropRect) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    private func cropImage(_ image: CIImage) -> CIImage {
        // Convert instructionGuidelineImageView frame to the previewLayer's coordinate system
        let guidelineFrameInPreviewLayer = previewLayer.layerRectConverted(fromMetadataOutputRect: instructionGuidelineImageView.frame)
        
        // Calculate the normalized cropping rect in the CIImage space
        let normalizedCropRect = CGRect(
            x: guidelineFrameInPreviewLayer.origin.x / view.bounds.width,
            y: guidelineFrameInPreviewLayer.origin.y / view.bounds.height,
            width: guidelineFrameInPreviewLayer.width / view.bounds.width,
            height: guidelineFrameInPreviewLayer.height / view.bounds.height
        )
        
        // Convert normalized crop rect to the CIImage's coordinate space
        let cropRect = normalizedCropRect.applying(CGAffineTransform(scaleX: image.extent.width, y: image.extent.height))
        
        // Crop the image
        return image.cropped(to: cropRect)
    }
    
//    private func cropImage(_ image: CIImage) -> CIImage {
//        // Convert instructionGuidelineImageView frame to the previewLayer's coordinate system
//        let guidelineFrame = instructionGuidelineImageView.frame
//        
//        // Calculate the normalized cropping rect in the CIImage space
//        let normalizedCropRect = CGRect(
//            x: guidelineFrame.origin.x / view.bounds.width,
//            y: guidelineFrame.origin.y / view.bounds.height,
//            width: guidelineFrame.width / view.bounds.width,
//            height: guidelineFrame.height / view.bounds.height
//        )
//        
//        // Convert normalized crop rect to the CIImage's coordinate space
//        let cropRect = normalizedCropRect.applying(CGAffineTransform(scaleX: image.extent.width, y: image.extent.height))
//        
//        // Crop the image
//        return image.cropped(to: cropRect)
//    }
    
    private func processCapturedImage(_ image: CIImage) {
        // Step 1: Attempt to load the model
        guard let model = try? AdVisaClassificationModel(configuration: .init()).model else {
            print("Failed to load AdVisaClassificationModel")
            return
        }
        
        do {
            // Step 2: Create a Vision request to classify the image
            let request = try VNCoreMLRequest(model: VNCoreMLModel(for: model)) { [weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first else {
                    print("Model classification error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                DispatchQueue.main.async {
                    switch topResult.identifier {
                    case "ktp":
                        self?.performTextRecognition(on: image, with: .ktp)
                    case "passport":
                        self?.performTextRecognition(on: image, with: .passport)
                    case "hotel":
                        self?.performTextRecognition(on: image, with: .hotel)
                    case "tiket_pesawat":
                        self?.performTextRecognition(on: image, with: .tiket_pesawat)
                    default:
                        print("Unhandled document type: \(topResult.identifier)")
                    }
                }
            }
            
            // Step 3: Perform the classification request
            let handler = VNImageRequestHandler(ciImage: image, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Failed to perform classification: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to create VNCoreMLRequest: \(error.localizedDescription)")
        }
    }
    
    private func performTextRecognition(on image: CIImage, with documentType: DocumentType) {
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var recognizedTextByPosition = [(text: String, boundingBox: CGRect)]()
            
            for observation in observations {
                if let topCandidate = observation.topCandidates(1).first {
                    recognizedTextByPosition.append((text: topCandidate.string, boundingBox: observation.boundingBox))
                }
            }
            
            for (text, boundingBox) in recognizedTextByPosition {
                print("Recognized Text: \(text)")
                print("Bounding Box: \(boundingBox)")
                print("------")
            }
            
            let recognizedTexts = observations.compactMap { $0.topCandidates(1).first?.string }
            
            switch documentType {
            case .ktp:
                self?.extractIdentityCardData(from: recognizedTexts)
            case .passport:
                self?.extractPassportDataWithGeometry(from: recognizedTextByPosition)
            case .hotel:
                self?.extractAccomodationData(from: recognizedTexts)
            case .tiket_pesawat:
                self?.extractFlightTicketData(from: recognizedTexts)
            case .none:
                self?.extractIdentityCardData(from: recognizedTexts)
            }
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
            identityCardRepository?.save(param: IdentityCardData(id: UUID().uuidString, identityId: identityId, maritalStatus: maritalStatus))
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.savedDocumentViewModel.alreadyTakenPicture = true
                                self.dismiss(animated: true)
                            }
                            self.captureCompleteBinding.wrappedValue = true
                            self.showDocumentSheetBinding.wrappedValue = false
                            print("Save successful")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.navigationManager?.shouldNavigate = true
                            }
                        case .failure(let error):
                            // Handle the error
                            DispatchQueue.main.async {
                                print("Error saving identity card: \(error.localizedDescription)")
                            }
                        }
                    }, receiveValue: { success in
                        // Handle the success case if needed (though here it is not strictly necessary)
                    })
                    .store(in: &cancellables) // Store the cancellable in a Set<AnyCancellable>
        } else {
            DispatchQueue.main.async {
                print("Could not extract identity data.")
            }
        }
    }
    
    private func extractPassportDataWithGeometry(from recognizedTextByPosition: [(text: String, boundingBox: CGRect)]) {
        var passportNumber: String?
        var givenName: String?
        var surname: String?
        var nationality: String?
        var dateOfBirth: String?
        var dateOfIssue: String?
        var dateOfExpiry: String?
        var placeOfIssue: String?
        var state: String?
        var city: String?
        var gender: GenderEnum?
        var issuingAuthority: String?
        
        for (text, boundingBox) in recognizedTextByPosition {
            if isInNameRegion(boundingBox) {
                if let components = extractNameComponents(from: text) {
                    surname = components.surname
                    givenName = components.givenName
                }
            } else if isInPlaceOfIssueRegion(boundingBox) {
                placeOfIssue = text
                issuingAuthority = "Kantor Imigrasi \(placeOfIssue ?? "")"
            }
            else if isInPassportNumberRegion(boundingBox) {
                passportNumber = text
                    .replacingOccurrences(of: ".", with: "")
                    .replacingOccurrences(of: " ", with: "")
            } else if isInNationalityRegion(text: text) {
                nationality = "INDONESIAN"
            } else if isInDateOfBirthRegion(boundingBox) {
                dateOfBirth = extractDate(from: text)
            } else if isInDateOfIssueRegion(boundingBox) {
                dateOfIssue = extractDate(from: text)
            } else if isInDateOfExpiryRegion(boundingBox) {
                dateOfExpiry = extractDate(from: text)
            } else if isInCityRegion(boundingBox) {
                city = text
                state = text
            } else if isInGenderRegion(boundingBox) || text.contains("P/F") || text.contains("L/M") {
                gender = text.genderFromText()
            }
        }
        
        DispatchQueue.main.async {
            print("Passport Number: \(passportNumber ?? "")")
            print("Surname: \(surname ?? "")")
            print("Given Name: \(givenName ?? "")")
            print("Nationality: \(nationality ?? "")")
            print("Date of Birth: \(dateOfBirth ?? "")")
            print("Date of Issue: \(dateOfIssue ?? "")")
            print("Date of Expiry: \(dateOfExpiry ?? "")")
            print("City: \(city ?? "")")
            print("State: \(state ?? "")")
            print("Gender: \(gender?.rawValue ?? "")")
            print("Place of Issue: \(placeOfIssue ?? "")")
            print("Issuing Authority: \(issuingAuthority ?? "")")
        }

        // Output the recognized information
        if let dateOfBirth = dateOfBirth?.convertToDate(),
           let dateOfIssue = dateOfIssue?.convertToDate(),
           let dateOfExpiry = dateOfExpiry?.convertToDate(),
           let surname = surname,
           let givenName = givenName,
           let city = city,
           let state = state,
           let gender = gender,
           let nationality = nationality,
           let passportNumber = passportNumber,
           let placeOfIssue = placeOfIssue,
           let issuingAuthority = issuingAuthority {
            passportRepository?.save(param: PassportData(
                id: UUID().uuidString,
                surname: surname,
                givenName: givenName,
                dateOfBirth: dateOfBirth,
                city: city, 
                state: state,
                country: "INDONESIA",
                gender: gender,
                nationality: nationality,
                passportType: .ordinary,
                passportID: passportNumber,
                placeOfIssue: placeOfIssue,
                dateOfIssue: dateOfIssue,
                issuingAuthority: issuingAuthority,
                dateOfExpiry: dateOfExpiry
            ))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Handle successful completion, if needed
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.savedDocumentViewModel.alreadyTakenPicture = true
                        self.dismiss(animated: true)
                    }
                    self.captureCompleteBinding.wrappedValue = true
                    self.showDocumentSheetBinding.wrappedValue = false
                    print("Save successful")
                case .failure(let error):
                    // Handle the error, for example by logging it
                    print("Failed to save passport data: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                // Handle the success case, if needed
                print("Save operation result: \(success)")
            })
            .store(in: &cancellables)
        } else {
            // Handle the case where required values are nil
            print("Required data is missing or invalid.")
        }
    }
    
    private func extractAccomodationData(from recognizedTexts: [String]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.savedDocumentViewModel.alreadyTakenPicture = true
            self.dismiss(animated: true)
        }
        self.captureCompleteBinding.wrappedValue = true
        self.showDocumentSheetBinding.wrappedValue = false
        print("Save successful")
    }
    
    private func extractFlightTicketData(from recognizedTexts: [String]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.savedDocumentViewModel.alreadyTakenPicture = true
            self.dismiss(animated: true)
        }
        self.captureCompleteBinding.wrappedValue = true
        self.showDocumentSheetBinding.wrappedValue = false
        print("Save successful")
    }
    
    @objc func pickPhoto() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        DispatchQueue.main.async {
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            print("Image selected: \(selectedImage)")
            
            if let ciImage = CIImage(image: selectedImage) {
                
                switch(selectedDocument) {
                case .passport_bio:
                    self.savedDocumentViewModel.processedDocumentType = .passport_bio
                case .passport_endorsement:
                    self.savedDocumentViewModel.processedDocumentType = .passport_endorsement
                case .ktp:
                    self.savedDocumentViewModel.processedDocumentType = .ktp
                case .self_portrait:
                    self.savedDocumentViewModel.processedDocumentType = .self_portrait
                case .bank_statement:
                    self.savedDocumentViewModel.processedDocumentType = .bank_statement
                case .none:
                    self.savedDocumentViewModel.processedDocumentType = .passport_bio
                case .tiket_pesawat:
                    self.savedDocumentViewModel.processedDocumentType = .tiket_pesawat
                case .hotel:
                    self.savedDocumentViewModel.processedDocumentType = .hotel
                case .family_card:
                    self.savedDocumentViewModel.processedDocumentType = .family_card
                }
                
                self.processCapturedImage(ciImage)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                print("Picture from picker processed.")
            } else {
                print("Picture from picker couldn't be processed.")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController, mediaInfo: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
    }
    
    func extractDate(from text: String) -> String? {
        let dateRegex = #"\b\d{2} (JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC) \d{4}\b"#
        if let match = text.range(of: dateRegex, options: .regularExpression) {
            let date = String(text[match])
            return date
        }
        return nil
    }

    private func extractNameComponents(from nameText: String) -> (givenName: String, surname: String)? {
        let nameComponents = nameText.split(separator: " ")
        guard nameComponents.count >= 2 else { return nil }
        
        // Surname is the first name, given name is the rest
        let surname = nameComponents.first ?? ""
        let givenName = nameComponents.dropFirst().joined(separator: " ")
        return (givenName: givenName, surname: String(surname))
    }

    // Adjusted geometric region functions
    private func isInNameRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.3 && boundingBox.origin.y < 0.4 && boundingBox.origin.x > 0.25 && boundingBox.origin.x < 0.35
    }

    private func isInNationalityRegion(text: String) -> Bool {
        return text.contains("IDN") || text.uppercased().contains("INDONESIA")
    }

    private func isInDateOfBirthRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.3 && boundingBox.origin.y < 0.4 && boundingBox.origin.x > 0.45 && boundingBox.origin.x < 0.55
    }

    private func isInDateOfIssueRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.3 && boundingBox.origin.y < 0.4 && boundingBox.origin.x > 0.55 && boundingBox.origin.x < 0.65
    }

    private func isInDateOfExpiryRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.7 && boundingBox.origin.y < 0.8 && boundingBox.origin.x > 0.5 && boundingBox.origin.x < 0.65
    }

    private func isInCityRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.75 && boundingBox.origin.y < 0.85 && boundingBox.origin.x > 0.4 && boundingBox.origin.x < 0.55
    }

    private func isInGenderRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.8 && boundingBox.origin.y < 0.9 && boundingBox.origin.x > 0.2 && boundingBox.origin.x < 0.35
    }

    private func isInPassportNumberRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.7 && boundingBox.origin.y < 0.9 && boundingBox.origin.x > 0.15 && boundingBox.origin.x < 0.25
    }

    private func isInPlaceOfIssueRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.5 && boundingBox.origin.y < 0.7 && boundingBox.origin.x > 0.6 && boundingBox.origin.x < 0.75
    }
}
