//
//  DocumentScannerView.swift
//  adVisa
//
//  Created by Lonard Steven on 18/08/24.
//

import Foundation
import Vision
import VisionKit
import SwiftUI

public struct DocumentScannerView: UIViewControllerRepresentable {
    public func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    private let completionHandler: (PassportData?) -> Void
    
    init(completionHandler: @escaping (PassportData?) -> Void) {
        self.completionHandler = completionHandler
    }
    
    
    public func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }

    
    public typealias UIViewControllerType = VNDocumentCameraViewController

    final public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate, TextRecognition {
        private let completionHandler: (PassportData?) -> Void
        
        init(completionHandler: @escaping (PassportData?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document scanning finished with", scan)
            let image = scan.imageOfPage(at: 0)
            
            validateImage(image: image) { passportData in
                self.completionHandler(passportData)
            }
        }
        
        public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            print("Document scanning has been canceled!")
            completionHandler(nil)
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: any Error) {
            print("Document scanning has failed..., due to", error)
            completionHandler(nil)
        }
    }
    
}


