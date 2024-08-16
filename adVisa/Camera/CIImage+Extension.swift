//
//  CIImage+Extension.swift
//  adVisa
//
//  Created by Lonard Steven on 16/08/24.
//

import Foundation
import CoreImage

extension CIImage {
    
    var cgImage: CGImage? {
        let ciContext = CIContext()
        
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
            return nil
        }
        
        return cgImage
    }
    
}
