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

private enum DocumentType {
    case ktp, passport
}

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
    
    private var capturedImageView: UIImageView!
    private var capturedImage: UIImage?
    
    
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
        
        capturedImageView = UIImageView()
        capturedImageView.translatesAutoresizingMaskIntoConstraints = false
        capturedImageView.contentMode = .scaleAspectFit
        capturedImageView.clipsToBounds = true
        capturedImageView.isHidden = true
        capturedImageView.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        view.addSubview(capturedImageView)
        
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
        DispatchQueue.main.async {
            self.processCapturedImage(ciImage)
        }
        if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let ciImage = CIImage(cvPixelBuffer: imageBuffer)
            
            let context = CIContext()
            
            let imageOrientation: UIImage.Orientation
            switch UIDevice.current.orientation {
            case .portrait:
                imageOrientation = .up
            case .landscapeLeft:
                imageOrientation = .right
            case .landscapeRight:
                imageOrientation = .left
            case .portraitUpsideDown:
                imageOrientation = .down
            default:
                imageOrientation = .up
            }
            
            let rect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(imageBuffer), height: CVPixelBufferGetHeight(imageBuffer))
            print("CI Image Extent : \(ciImage.extent)")
            if let cgImage = context.createCGImage(ciImage, from: rect) {
                var image = UIImage(cgImage: cgImage, scale: 1.0, orientation: .up)
                let desiredHeight: CGFloat = 250
                
                if let croppedImage = cropMiddlePartOfImage(image: image, cropWidth: 960, cropHeight: 1400) {
                    displayCapturedImage(croppedImage)
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
    
    private func displayCapturedImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.capturedImage = image
            self.capturedImageView.image = image
            self.capturedImageView.clipsToBounds = true
            self.capturedImageView.isHidden = false
        }
    }
    
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
                
                let identifier = topResult.identifier
                let confidence = topResult.confidence

                print("Detected: \(identifier) with confidence: \(confidence * 100)%")
                
                DispatchQueue.main.async {
                    switch topResult.identifier {
                    case "ktp":
                        self?.performTextRecognition(on: image, with: .ktp)
                    case "passport":
                        self?.performTextRecognition(on: image, with: .passport)
                    case "hotel", "tiket_pesawat":
                        print("Detected a \(topResult.identifier). Handling is not implemented yet.")
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
    
    private func extractPassportData(from recognizedTexts: [String]) {
        var passportNumber: String?
        var fullName: String?
        var nationality: String?
        var dateOfBirth: String?

        for text in recognizedTexts {
            // Check for passport number (assuming it follows a specific pattern, e.g., 9 alphanumeric characters)
            if text.range(of: #"[A-Z0-9]{9}"#, options: .regularExpression) != nil {
                passportNumber = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }

            // Check for nationality (common keywords to identify it)
            if text.uppercased().contains("INDONESIA") {
                nationality = "Indonesia"
            }

            // Check for full name (this can vary, so you might need a more advanced method based on the location in the text)
            if text.uppercased().contains("NAME") || (text.range(of: #"[A-Z]+ [A-Z]+"#, options: .regularExpression) != nil && text.count > 5) {
                fullName = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }

            // Check for date of birth (common format)
            if text.range(of: #"\d{2}\s[a-zA-Z]{3}\s\d{4}"#, options: .regularExpression) != nil {
                dateOfBirth = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        if let passportNumber = passportNumber, let fullName = fullName, let nationality = nationality, let dateOfBirth = dateOfBirth {
            DispatchQueue.main.async {
                print("Passport Number: \(passportNumber)")
                print("Full Name: \(fullName)")
                print("Nationality: \(nationality)")
                print("Date of Birth: \(dateOfBirth)")
            }
        } else {
            DispatchQueue.main.async {
                print("Could not extract passport data.")
            }
        }
    }
    
    private func extractPassportDataWithGeometry(from recognizedTextByPosition: [(text: String, boundingBox: CGRect)]) {
        var passportNumber: String?
        var fullName: String?
        var givenName: String?
        var surname: String?
        var nationality: String?
        var dateOfBirth: String?
        var dateOfIssue: String?
        var dateOfExpiry: String?
        var placeOfIssue: String?
        var city: String?
        var gender: String?
        var issuingAuthority: String?

        for (text, boundingBox) in recognizedTextByPosition {
            if isInNameRegion(boundingBox) {
                if let components = extractNameComponents(from: text) {
                    surname = components.surname
                    givenName = components.givenName
                }
            } else if isInNationalityRegion(boundingBox) {
                nationality = text
            } else if isInDateOfBirthRegion(boundingBox) {
                dateOfBirth = text
            } else if isInDateOfIssueRegion(boundingBox) {
                dateOfIssue = text
            } else if isInDateOfExpiryRegion(boundingBox) {
                dateOfExpiry = text
            } else if isInCityRegion(boundingBox) {
                city = text
            } else if isInGenderRegion(boundingBox) {
                gender = text
            } else if isInPassportNumberRegion(boundingBox) {
                passportNumber = text
            } else if isInPlaceOfIssueRegion(boundingBox) {
                placeOfIssue = text
                issuingAuthority = "Kantor Imigrasi \(placeOfIssue ?? "")"
            }
        }

        // Output the recognized information
        DispatchQueue.main.async {
            print("Passport Number: \(passportNumber ?? "")")
            print("Surname: \(surname ?? "")")
            print("Given Name: \(givenName ?? "")")
            print("Nationality: \(nationality ?? "")")
            print("Date of Birth: \(dateOfBirth ?? "")")
            print("Date of Issue: \(dateOfIssue ?? "")")
            print("Date of Expiry: \(dateOfExpiry ?? "")")
            print("City: \(city ?? "")")
            print("Gender: \(gender ?? "")")
            print("Place of Issue: \(placeOfIssue ?? "")")
            print("Issuing Authority: \(issuingAuthority ?? "")")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    private func extractNameComponents(from nameText: String) -> (givenName: String, surname: String)? {
        let nameComponents = nameText.split(separator: " ")
        guard nameComponents.count >= 2 else { return nil }
        
        let givenName = nameComponents.dropLast().joined(separator: " ")
        let surname = nameComponents.last ?? ""
        return (givenName: givenName, surname: String(surname))
    }

    // Example geometric region functions
    private func isInNameRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.7 && boundingBox.origin.y < 0.8
    }

    private func isInNationalityRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.6 && boundingBox.origin.y < 0.7
    }

    private func isInDateOfBirthRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.5 && boundingBox.origin.y < 0.6
    }

    private func isInDateOfIssueRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.4 && boundingBox.origin.y < 0.5
    }

    private func isInDateOfExpiryRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.3 && boundingBox.origin.y < 0.4
    }

    private func isInCityRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.2 && boundingBox.origin.y < 0.3
    }

    private func isInGenderRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.1 && boundingBox.origin.y < 0.2
    }

    private func isInPassportNumberRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.9 && boundingBox.origin.y < 1.0
    }

    private func isInPlaceOfIssueRegion(_ boundingBox: CGRect) -> Bool {
        return boundingBox.origin.y > 0.0 && boundingBox.origin.y < 0.1
    }
}
