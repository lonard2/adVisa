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
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return CameraViewController()
    }
}
