//
//  ConfirmUploadDocumentPage.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct ConfirmUploadDocumentPage: View {
    
    @State var documentName: String
    @State var uploadedImageName: String
    
    var body: some View {
        VStack {
            
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Text("Retake")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 14)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                }
                
                Text(documentName)
                    .padding(.horizontal)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.primaryWhite))
                
                Button {
                    
                } label: {
                    Text("Save")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 14)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(.primaryBlue))
            
            VStack {
                
                Spacer()
                
                Image(uploadedImageName)
                    .padding(10)
                
                Spacer()
            }
            .background(Color(.primaryWhite))
            
        }
    }
}

#Preview {
    ConfirmUploadDocumentPage(documentName: "Passport (Bio Page)", uploadedImageName: "passport_bio_guide")
}
