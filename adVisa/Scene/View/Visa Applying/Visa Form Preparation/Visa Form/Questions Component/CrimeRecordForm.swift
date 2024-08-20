//
//  CrimeRecordForm.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import SwiftUI

struct CrimeRecordForm: View {
    @ObservedObject var viewModel: VisaFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack(alignment: .leading, spacing: 12) {
                Text("""
                     Tick the box if you met the criteria below.
                     Have you ever:
                     """)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Toggle(isOn: $viewModel.convictedCrimeAnyCountry) {
                    Text("Been convicted of a crime of offence in any country?")
                        .font(.system(size: 15))
                }
                .toggleStyle(CheckboxToggleStyle())
                .font(.system(size: 24))
                
                Toggle(isOn: $viewModel.sentencedOneYearOrMore) {
                    Text("Been sentenced to imprisonment for 1 year or more in any country? (tick the circle even if the sentence was suspended)")
                        .font(.system(size: 15))
                }
                .toggleStyle(CheckboxToggleStyle())
                .font(.system(size: 24))
                
                Toggle(isOn: $viewModel.deportedFromJapan) {
                    Text("been deported or removed from Japan or any country for overstaying your visa or violating any law or regulation?")
                        .font(.system(size: 15))
                }
                .toggleStyle(CheckboxToggleStyle())
                .font(.system(size: 24))
                
                Toggle(isOn: $viewModel.drugOffense) {
                    Text("Been convicted and sentenced for a drug offence in any country in violation of law concerning narcotics, marijuana, opium, stimulants or psychotropic substances? (tick the circle even if the sentence was suspended)")
                        .font(.system(size: 15))
                }
                .toggleStyle(CheckboxToggleStyle())
                .font(.system(size: 24))
                
                Toggle(isOn: $viewModel.engagedInProstitution) {
                    Text("Engaged in prostitution, or in the intermediation or solicitation of a prostitute for other persons, or in the provision of a place for prostitution, or any other activity directly connected to protitution?")
                        .font(.system(size: 15))
                }
                .toggleStyle(CheckboxToggleStyle())
                .font(.system(size: 24))
                
                Toggle(isOn: $viewModel.commitTrafficking) {
                    Text("Committed trafficking in persons or incited or aided another to commit such an offence?")
                        .font(.system(size: 15))
                }
                .toggleStyle(CheckboxToggleStyle())
                .font(.system(size: 24))
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        
        Spacer()
        
        if viewModel.convictedCrimeAnyCountry || viewModel.sentencedOneYearOrMore || viewModel.deportedFromJapan || viewModel.drugOffense || viewModel.engagedInProstitution || viewModel.commitTrafficking {
            
            Button {
                viewModel.nextForm()
            } label: {
                Text("Continue")
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 15))
                    .foregroundStyle(Color(.primaryWhite))
                    .background(Color(.primaryBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        } else {
            NavigationLink {
                Text("Test")
            } label: {
                Text("Continue")
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 15))
                    .foregroundStyle(Color(.primaryWhite))
                    .background(Color(.primaryBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    CrimeRecordForm(viewModel: VisaFormViewModel())
}
