//
//  UploadDocumentSheet.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct UploadDocumentSheet: View {
    
    @State var documentName: String
    @State var documentImageName: String
    @State var documentExplanation: String
    
    var body: some View {
        
        VStack(spacing: 3) {
            
            VStack(spacing: 24) {
                Text(documentName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Image(documentImageName)
                
                Text(documentExplanation)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            
            Spacer()
            
            VStack(spacing: 20) {
                Button {
                    
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

#Preview {
    UploadDocumentSheet(documentName: "Passport (Bio Page)", documentImageName: "passport_bio_guide", documentExplanation: "It’s the 2nd page of your Passport. It should be looked like the picture above. Use a solid background to take the photo.")
}
