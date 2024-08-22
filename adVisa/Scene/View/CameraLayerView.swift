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
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.selectedDocument = selectedDocument
        cameraViewController.identityCardRepository = IdentityCardRepository()
        cameraViewController.passportRepository = PassportRepository()
        
        return cameraViewController
    }
}
