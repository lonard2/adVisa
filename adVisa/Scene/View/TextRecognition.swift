//
//  TextRecognition.swift
//  adVisa
//
//  Created by Lonard Steven on 18/08/24.
//

import Foundation
import Vision
import VisionKit

public protocol TextRecognition: VNDocumentCameraViewControllerDelegate { }

public extension TextRecognition {
    internal func validateImage(image: UIImage?, completion: @escaping (PassportData?) -> Void) {
        guard let cgImage = image?.cgImage else { return completion(nil) }
        
        var recognizedText = [String]()
        
        var textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        
        textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
            guard let results = request.results,
                  !results.isEmpty,
                  let requestResults = request.results as? [VNRecognizedTextObservation]
            else { return completion(nil) }
            
            recognizedText = requestResults.compactMap { observation in
                return observation.topCandidates(1).first?.string
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
//            completion(parseDocument(for: recognizedText))
        } catch {
            print(error)
        }
    }
    
//    func parseDocument(for recognizedText: [String]) {
//        let nationalityName = recognizedText.first(where: { $0.contains("INDONESIA")})
//        
//        return PassportData(id: UUID().uuidString, surname: <#T##String#>, givenName: <#T##String#>, dateOfBirth: <#T##Date#>, city: <#T##String#>, state: <#T##String#>, country: <#T##String#>, gender: <#T##GenderEnum#>, nationality: nationalityName, passportType: <#T##PassportTypeEnum#>, passportID: <#T##String#>, placeOfIssue: <#T##String#>, dateOfIssue: <#T##Date#>, issuingAuthority: <#T##String#>, dateOfExpiry: <#T##Date#>)
//    }
}
