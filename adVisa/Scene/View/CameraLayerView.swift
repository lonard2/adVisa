//
//  CameraLayerView.swift
//  adVisa
//
//  Created by Lonard Steven on 19/08/24.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation

struct CameraLayerView: UIViewControllerRepresentable {
    
    var selectedDocument: DocumentTypeDetailed
    @Binding var showDocumentSheet: Bool
    var savedDocumentViewModel = SavedDocumentViewModel()
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {

    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController(showDocumentSheetBinding: $showDocumentSheet)
        cameraViewController.selectedDocument = selectedDocument
        cameraViewController.identityCardRepository = IdentityCardRepository()
        cameraViewController.passportRepository = PassportRepository()
        
        return cameraViewController
    }
}
