//
//  Helper.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import CoreImage
import AVFoundation

extension PassportData {
    func getPlaceOfBirth() -> String {
        return "\(self.city), \(self.state), \(self.country)"
    }
}

extension TravelHistoryData {
    func getDuration() -> String {
        return "\(self.travelDuration) days"
    }
}

extension GuarantorData {

}

extension GuarantorData {
    func getOccupation() -> String {
        return "\(self.guarantorOccupation) as \(self.guarantorPosition)"
    }
    
    func getNationalityAndImmigrationStatus() -> String {
        return "\(self.guarantorNationality), \(self.guarantorImmigrationStatus)"
    }
}

extension InviterData {
    func getOccupation() -> String {
        return "\(self.inviterOccupation) as \(self.inviterPosition)"
    }
    
    func getNationalityAndImmigrationStatus() -> String {
        return "\(self.inviterNationality), \(self.inviterImmigrationStatus)"
    }
}


extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else {
            return nil
        }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}

//extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let currentFrame = sampleBuffer.cgImage else { return }
//        addToPreviewStream?(currentFrame)
//    }
//}
