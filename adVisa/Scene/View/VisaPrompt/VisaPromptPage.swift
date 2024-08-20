//
//  VisaPromptPage.swift
//  adVisa
//
//  Created by Dixon Willow on 19/08/24.
//

import SwiftUI

struct VisaPromptPage: View {
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var passportType: String = "Regular Passport"
    @State private var travelPurpose: String = "Holiday"
    @State private var visitedPlaces: Bool = false
    @State private var isStudent: Bool = false
    
    @State private var nextQuestion: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack(alignment: .bottom) {
                Image("japan_image")
                
                Image("visa_header")
            }
            
            VStack(alignment: .leading, spacing: 16) {
                
                if !nextQuestion {
                    Text("Japan Visa")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("How long do you want to go?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        HStack() {
                            DatePicker("", selection: $startDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                .onChange(of: startDate, {
                                    if endDate < startDate {
                                        endDate = startDate
                                    }
                            })
                            
                            Text(" - ")
                            
                            DatePicker("", selection: $endDate, in: startDate..., displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                .foregroundStyle(Color(.primaryBlue))
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Which Passport do you own?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Picker(selection: $passportType) {
                            VStack {
                                Image("Passport")
                                Text("Regular Passport")
                            }.tag("Regular Passport")
                            
                            VStack {
                                Image("e_passport")
                                Text("E-Passport")
                            }.tag("E-Passport")
                            
                        } label: {
                            Text("Passport Type")
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What is your purpose of visiting Japan?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Picker(selection: $travelPurpose) {
                            Text("Holiday").tag("Holiday")
                            Text("Work").tag("Work")
                            
                        } label: {
                            Text("Travel Purpose")
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        nextQuestion = true
                        
                    } label: {
                        Text("Continue")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryWhite))
                            .background(Color.primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                } else {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Have your ever go to Fukushima/ Miyagi/ Iwate/ Okinawa?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Picker(selection: $visitedPlaces) {
                            Text("Yes").tag(true)
                            Text("No").tag(false)
                            
                        } label: {
                            Text("visitedPlace")
                        }
                        .pickerStyle(.palette)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Are you a student?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Picker(selection: $isStudent) {
                            Text("Yes").tag(true)
                            Text("No").tag(false)
                            
                        } label: {
                            Text("isStudent")
                        }
                        .pickerStyle(.palette)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        nextQuestion = false
                        
                    } label: {
                        Text("Continue")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryWhite))
                            .background(Color.primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                }
                
                
            }
            .padding(.vertical, 44)
            .padding(.horizontal, 28)
            
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    VisaPromptPage()
}
