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
                .presentationDragIndicator(.visible)
        }
    }
    
    private func processImage() {
        guard let image = image else { return }
        
        // Convert the image to CIImage for processing
        guard let ciImage = CIImage(image: image) else {
            fatalError("Could not convert UIImage to CIImage.")
        }
        
        // Create a VNCoreMLModel with the AdVisaClassificationModel
        let model = try! VNCoreMLModel(for: AdVisaClassificationModel().model)
        
        // Create a VNCoreMLRequest to classify the image
        let classificationRequest = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Classification error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.classifiedText = "Classification failed."
                }
                return
            }
            
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                DispatchQueue.main.async {
                    self.classifiedText = "No classification result."
                }
                return
            }
            
            // Update classifiedText with the top result's identifier
            DispatchQueue.main.async {
                self.classifiedText = "\(topResult.identifier) with \(topResult.confidence)"
            }
        }
        
        // Run the classification request on the image
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
}

struct TestCameraView_Previews: PreviewProvider {
    static var previews: some View {
        TestCameraView()
    }
}
