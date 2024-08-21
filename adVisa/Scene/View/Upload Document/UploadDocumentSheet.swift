//
//  UploadDocumentSheet.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct UploadDocumentSheet: View {
    
    @Binding var document: Document
    
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
                NavigationLink {
                    
                } label: {
                    Text("Take Picture")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryWhite))
                        .background(Color.primaryBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Button {
                    
                } label: {
                    Text("Select From Photos")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.primaryBlue))
                }

            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            
        }
        
    }
}

//#Preview {
//    UploadDocumentSheet()
//}
