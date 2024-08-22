//
//  DataPolicySheet.swift
//  adVisa
//
//  Created by hendra on 16/08/24.
//

import SwiftUI

struct DataPolicySheet: View {

    @ObservedObject var viewModel: DataPolicyViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 24) {
                Text("Data Privacy")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Image("data_privacy_intro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 174)
                
                Group {
                    Text("To proceed, we need you to ")
                    
                    +
                    
                    Text("upload some personal data. ")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    +
                    
                    Text("Your privacy and security are our top priorities, and all of your information will be ")
                    
                    +
                    
                    Text("stored locally on your device, meaning it remains fully under your control. ")
                        .fontWeight(.bold)
                    
                    +
                    
                    Text("Our developers and third parties ")
                    
                    +
                    
                    Text("will not have access to your data")
                        .fontWeight(.bold)
                    
                    +
                    
                    Text(", ensuring your sensitive information stays protected throughout your use of the app. ")
                        
                }
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 24) {
                HStack(spacing: 16) {
                    Toggle(isOn: $viewModel.isAgreeToPrivacy, label: {
                        Text("I consent to providing my data for AdVisa to assist with my visa forms.")
                    })
                    .font(.system(size: 15))
                }
                
                HStack(spacing: 16) {
                    Toggle(isOn: $viewModel.isAgreeToTerms, label: {
                        Text("I do not consent to AdVisa accessing my data remotely or using it outside the app.")
                    })
                    .font(.system(size: 15))
                }
            }
            
            Spacer()
            
            Button{
                viewModel.showSheet = false
            } label: {
                Text("Continue")
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 15))
                    .foregroundStyle(Color(.primaryWhite))
                    .background(viewModel.isAgreeToTerms && viewModel.isAgreeToPrivacy ? Color.primaryBlue : Color.defaultGray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(!(viewModel.isAgreeToTerms && viewModel.isAgreeToPrivacy))
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
        
    }
}

#Preview {
    DataPolicySheet(viewModel: DataPolicyViewModel())
}
