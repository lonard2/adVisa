//
//  DataPolicySheet.swift
//  adVisa
//
//  Created by hendra on 16/08/24.
//

import SwiftUI

struct DataPolicySheet: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: DataPolicyViewModel

    var body: some View {
        GeometryReader{ geometry in
            let padding:CGFloat = 32
            let width = geometry.size.width - (padding * 2)
            let imageHeight = geometry.size.height * 0.2
            
            let buttonHeight:CGFloat = 40
            
            
            VStack(spacing: 16) {
                Image("template")
                    .resizable()
                    .frame(width: width, height: imageHeight)
                    .padding([.horizontal, .top], padding)
                Text("Data Privacy")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Quibusdam voluptatum repudiandae vel ex unde nostrum tenetur fugiat ea recusandae consequatur. Praesentium eius, quidem atque, laboriosam non aspernatur ad, ab cumque obcaecati ea eum distinctio aliquid omnis! Consequatur dolorum ducimus et nam deleniti fuga perspiciatis perferendis quia asperiores modi possimus architecto ad quisquam enim est tenetur, facilis magni exercitationem! Dolorum, ea explicabo!")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, padding)
                HStack {
                    Toggle(isOn: $viewModel.isAgreeToPrivacy, label: {
                        Text("Lorem ipsum dolor sit amet consectetur adipisicing elit.")
                    })
                }
                .padding(.horizontal, padding)
                HStack {
                    Toggle(isOn: $viewModel.isAgreeToTerms, label: {
                        Text("Lorem ipsum dolor sit amet consectetur adipisicing elit.")
                    })
                }
                .padding(.horizontal, padding)
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("CONTINUE")
                        .foregroundStyle(.white)
                        .padding([.horizontal], padding)
                        .frame(width: width, height: buttonHeight)
                        .background(viewModel.isAgreeToTerms && viewModel.isAgreeToPrivacy ? Color.blue : Color.gray)
                        .cornerRadius(8)
                })
                .disabled(!(viewModel.isAgreeToTerms && viewModel.isAgreeToPrivacy))
                .padding(.bottom, padding/2)
            }
            
        }
    }
}

#Preview {
    DataPolicySheet(viewModel: DataPolicyViewModel())
}
