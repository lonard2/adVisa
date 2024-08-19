//
//  TestCameraView.swift
//  adVisa
//
//  Created by hendra on 19/08/24.
//

import SwiftUI
import AVFoundation
import CoreML
import Vision

struct TestCameraView: View {
    @State private var image: UIImage?
    @State private var classifiedText: String = ""
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 300, height: 300)
                    .overlay(
                        Text("Tap to Capture Image")
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        showingImagePicker = true
                    }
            }
            
            if !classifiedText.isEmpty {
                Text("Classified as: \(classifiedText)")
                    .padding()
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: processImage) {
            ImagePicker(image: $image)
        }
    }
    
    private func processImage() {
        guard let image = image else { return }
        
        let model = try! VNCoreMLModel(for: AdVisaClassificationModel().model)
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Extract recognized text
            let recognizedTexts = observations.compactMap { $0.topCandidates(1).first?.string }
            self.extractIdentityCardData(from: recognizedTexts)
        }

        // Set the recognition level to accurate
        request.recognitionLevel = .accurate
        guard let ciImage = CIImage(image: image) else {
            fatalError("Could not convert UIImage to CIImage.")
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    private func extractIdentityCardData(from recognizedTexts: [String]) {
        // Extract NIK and Marital Status from recognized texts
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
        
        // Ensure both values are found before creating the IdentityCardData
        if let identityId = identityId, let maritalStatus = maritalStatus {
            DispatchQueue.main.async {
                print("NIK \(identityId)")
                print("Status \(maritalStatus)")
            }
        } else {
            DispatchQueue.main.async {
                self.classifiedText = "Could not extract identity data."
            }
        }
    }
}

struct TestCameraView_Previews: PreviewProvider {
    static var previews: some View {
        TestCameraView()
    }
}
