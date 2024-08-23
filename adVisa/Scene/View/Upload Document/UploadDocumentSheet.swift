//
//  UploadDocumentSheet.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct UploadDocumentSheet: View {
    
    @Binding var document: Document
    @Environment(\.dismiss) var dismiss
    
    @State private var openCamera = false
    @ObservedObject var viewModel = SavedDocumentViewModel()
    
    @Binding var selectedDocumentType : DocumentTypeDetailed
    @Binding var showDocumentSheet: Bool
    @Binding var goConfirmDocument: Bool
    @Binding var captureComplete: Bool
    
    var body: some View {
        
        VStack(spacing: 3) {
            
            VStack(spacing: 24) {
                Text(document.documentName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Image(document.imageName)
                
                Text(document.explanation)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            
            Spacer()
            
            VStack(spacing: 20) {
                Button {
                    openCamera.toggle()

                } label: {
                    Text("Take Picture")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                        .background(Color.primaryBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .fullScreenCover(isPresented: $openCamera) {
                    CameraLayerView(selectedDocument: selectedDocumentType, showDocumentSheet: $showDocumentSheet, captureComplete: $captureComplete)
                        .ignoresSafeArea()
                }
                
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            
        }
//        .onDisappear {
//            goConfirmDocument = true
//        }
        
        
        
    }
}

//#Preview {
//    UploadDocumentSheet()
//}
