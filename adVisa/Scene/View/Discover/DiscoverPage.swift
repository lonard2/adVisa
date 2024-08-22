//
//  DiscoverPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct DiscoverPage: View {
    
    @Binding var selectedBar : Int
    
    let countries = [
        TopDestination(countryName: "Japan", countryImage: "japan_image", rank: "2nd"),
    ]
    
    @State private var searchText = ""
    @State private var hasDocument = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0){
                    ZStack{
                        Image("discover_header")
                            .resizable()
                            .scaledToFit()
                        Text("Discover what you need to travel.")
                            .foregroundStyle(Color(.white))
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .offset(y: -48)
                    }
                    
                    VStack(spacing: 24) {
                        
                        TextField("\(Image(systemName: "magnifyingglass")) Search Country", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(7)
                            .background(Color(.tertiarySystemFill))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Popular Destination")
                                .font(.system(size:25))
                                .fontWeight(.semibold)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(countries) { country in
                                        NavigationLink {
                                            if country.countryName == "Japan" {
                                                VisaPromptPage()
                                            } else {
                                                Text(country.countryName)
                                            }
                                        } label: {
                                            DestinationCard(countryName: country.countryName, countryImage: country.countryImage, rank: country.rank)
                                                .padding(.vertical, 2)
                                        }
                                    }
                                }
                            }
                        }
                        
                        if !hasDocument {
                            PersonalDocumentGuideCard(selectedBar: $selectedBar)
                        } else {
                            EmptyView()
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                    .background(Color(.primaryWhite))
                }
            }
            .background(Color(.primaryBlue))
        }
    }
}

//#Preview {
//    DiscoverPage()
//}
