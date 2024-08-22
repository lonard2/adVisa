//
//  ImagePicker.swift
//  adVisa
//
//  Created by hendra on 19/08/24.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        
        // Overlay the cropping guide
        let overlay = UIView(frame: picker.cameraOverlayView!.frame)
        overlay.backgroundColor = UIColor.clear
        overlay.isUserInteractionEnabled = false
        
        // Create the crop rectangle
        let cropRect = CGRect(x: (overlay.frame.width - 250) / 2, y: (overlay.frame.height - 250) / 2, width: 250, height: 250)
        let cropView = UIView(frame: cropRect)
        cropView.layer.borderColor = UIColor.white.cgColor
        cropView.layer.borderWidth = 2.0
        overlay.addSubview(cropView)
        
        picker.cameraOverlayView = overlay
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                // Crop the image to 250x250 from the center
                let screenSize = UIScreen.main.bounds.size
                let overlaySize = CGSize(width: 250, height: 250)
                let croppedImage = cropImageToSquare(image: uiImage, overlaySize: overlaySize, previewSize: screenSize)
                parent.image = croppedImage
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        private func cropImageToSquare(image: UIImage, overlaySize: CGSize, previewSize: CGSize) -> UIImage? {
            let originalWidth = image.size.width
            let originalHeight = image.size.height
            
            // Calculate the scale factors
            let widthScale = originalWidth / previewSize.width
            let heightScale = originalHeight / previewSize.height
            
            // Calculate the cropping rectangle in terms of the original image's dimensions
            let cropRect = CGRect(
                x: ((previewSize.width - overlaySize.width) / 2) * widthScale,
                y: ((previewSize.height - overlaySize.height) / 2) * heightScale,
                width: overlaySize.width * widthScale,
                height: overlaySize.height * heightScale
            )
            
            // Crop the image
            guard let cgImage = image.cgImage?.cropping(to: cropRect) else { return nil }
            
            // Return the cropped image
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
    }
}
