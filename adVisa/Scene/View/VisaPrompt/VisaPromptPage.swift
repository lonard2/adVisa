//
//  VisaPromptPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct VisaPromptPage: View {
    
    @ObservedObject var viewModel = VisaPromptViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                
                ZStack(alignment: .bottom) {
                    Image("japan_image")
                        .resizable()
                        .scaledToFit()
                    
                    Image("visa_header")
                        .resizable()
                        .scaledToFit()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    if !viewModel.nextQuestion {
                        GeneralInformationForm(viewModel: viewModel)
                    } else {
                        PersonalInformationForm(viewModel: viewModel)
                    }
                    
                    
                }
                .padding(.vertical, 44)
                .padding(.horizontal, 28)
                
                
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    VisaPromptPage()
}
