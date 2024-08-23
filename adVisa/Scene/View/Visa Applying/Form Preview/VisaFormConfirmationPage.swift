//
//  VisaFormConfirmationPage.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import SwiftUI
import PDFKit

struct VisaFormConfirmationPage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pdfDocument: PDFDocument?
    
    @StateObject private var pdfPreviewViewModel: PdfPreviewVisaViewModel = PdfPreviewVisaViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack{
                    Text("Visa Application Form")
                        .foregroundStyle(Color(.primaryWhite))
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color(.primaryBlue))
                
                VStack {
                    if let pdfDocument = pdfDocument {
                        PDFPreviewView(pdfDocument: pdfDocument)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Confirm")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryBlue))
                            .background(Color.primaryWhite)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    NavigationLink {
                        EditVisaFormPage()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Edit Form")
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(.primaryWhite))
                    }
                    
                }
                .padding(12)
                .background(Color(.primaryBlue))
            }
        }
        .task {
            print("start")
            await fetchData()
            print("fetch")

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                if pdfPreviewViewModel.crimeRemarkData != nil {
                    // Ensure that the UI updates on the main thread
                    DispatchQueue.main.async {
                        loadAndFillPDF()
                    }
                } else {
                    print("Data fetching failed or returned nil.")
                }
            }
            // Ensure data is fetched before proceeding
            
            print("end")
        }
    }
    
    func fillPDFFormFields(pdfDocument: PDFDocument) -> PDFDocument? {
        // Loop through each page in the document
        var indexPassport = 0
        var indexMarital = 0
        var indexGenderClient = 0
        var indexGuarantorGender = 0
        var indexInviterGender = 0
        var indexCrime = 0 // no1
        var indexPrison = 0 //no2
        var indexDeported = 0 //no3
        var indexDrug = 0 // no4
        var indexProstitution = 0 //no5
        var indexCrimeTrafficPerson = 0 // no6
        for i in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: i) else { continue }
            
 
            for annotation in page.annotations {
                if let fieldName = annotation.fieldName {
                    print(fieldName)
                    switch fieldName {
                    case "topmostSubform[0].Page1[0].#area[0].T59[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.dateOfExpiry.formatted()  // Date of expiry
                    case "topmostSubform[0].Page1[0].#area[0].T57[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.issuingAuthority // issuing authority
                    case "topmostSubform[0].Page1[0].#area[1].#area[2].RB3[0]":
                        if indexPassport == 2 {
                            annotation.buttonWidgetState = .onState
                            indexPassport += 1
                            break
                        }
                        indexPassport += 1

                    case "topmostSubform[0].Page1[0].T49[0]":  // Passport number
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.passportID  // Set the "Given Name" field
                    case "topmostSubform[0].Page1[0].T37[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.identityCardData?.identityId // passport id
                    case "topmostSubform[0].Page1[0].T7[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.givenName //given and middle names
                    case "topmostSubform[0].Page1[0].T50[0]":  // Replace with correct field name for
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.nationality  // Set the "Middle Name" field
                    case "topmostSubform[0].Page1[0].T2[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.surname // Surname
                    case "topmostSubform[0].Page1[0].emp_adr[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.employerData?.employerAddress // Address
                    case "topmostSubform[0].Page1[0].#area[3].emp_tel[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.employerData?.employerTelephoneNum // Telepon
                    case "topmostSubform[0].Page1[0].#area[3].emp_name[0]":
                        annotation.widgetStringValue = "" // Name of employer
                    case "topmostSubform[0].Page1[0].#area[4].T14[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.dateOfBirth.formatted() // date of birth
                    case "topmostSubform[0].Page1[0].#area[4].T16[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.state ?? "" // place of birth
                    case "topmostSubform[0].Page1[0].#area[5].#area[6].#area[7].RB1[0]":
                        if indexGenderClient == 0  && pdfPreviewViewModel.passportData?.gender == .male { // Male
                            annotation.buttonWidgetState = .onState
                            indexGenderClient += 1
                            break
                        } else if indexGenderClient == 1 && pdfPreviewViewModel.passportData?.gender == .female { // Female
                            annotation.buttonWidgetState = .onState
                            indexGenderClient += 1
                            break
                        }
                        indexGenderClient += 1
                        // gender client female
                    case "topmostSubform[0].Page1[0].#area[8].RB2[0]":
                        if indexMarital == 0 && pdfPreviewViewModel.identityCardData?.maritalStatus == .single { // single
                            annotation.buttonWidgetState = .onState
                            indexMarital += 1
                            break
                        } else if indexMarital == 1 && pdfPreviewViewModel.identityCardData?.maritalStatus == .married { //married
                            annotation.buttonWidgetState = .onState
                            indexMarital += 1
                            break
                        } else if indexMarital == 2 && pdfPreviewViewModel.identityCardData?.maritalStatus == .divorced { // divorced
                            annotation.buttonWidgetState = .onState
                            indexMarital += 1
                            break
                        } else if indexMarital == 3  && pdfPreviewViewModel.identityCardData?.maritalStatus == .widowed { // widowed
                            annotation.buttonWidgetState = .onState
                            indexMarital += 1
                            break
                        }
                        indexMarital += 1

                    case "topmostSubform[0].Page1[0].T34[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.miscData?.formerNationality //other nationalities
                    case "topmostSubform[0].Page1[0].#area[9].T53[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.dateOfIssue.formatted() // date of issue
                    case "topmostSubform[0].Page1[0].#area[9].T57[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.passportData?.placeOfIssue // place of issue
                    case "topmostSubform[0].Page1[0].T62[0]":
                        annotation.widgetStringValue = "" // caertificate of eligibility
                    case "topmostSubform[0].Page1[0].T64[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.travelHistoryData?.travelDuration // dates and duration of previous stays in japan
                    case "topmostSubform[0].Page1[0].T66[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.miscData?.dateOfArrival?.formatted(.dateTime.year().month().day()) //date of arrivals
                    case "topmostSubform[0].Page1[0].#area[10].T68[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.miscData?.portOfEntry //port of entry into japan
                    case "topmostSubform[0].Page1[0].#area[10].T68[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.miscData?.shipAirlineName // name ship or airline
                    case "topmostSubform[0].Page1[0].T68[2]":
                        annotation.widgetStringValue = pdfPreviewViewModel.miscData?.visitPurpose // Purpose of visit to japan
                    case "topmostSubform[0].Page1[0].#area[11].T97[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.domicileData?.currentTelephoneNum // ocurrent place
                    case "topmostSubform[0].Page1[0].#area[11].T3[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.domicileData?.currentPhoneNum // address stay place
                    case "topmostSubform[0].Page1[0].T5[0]":
                        annotation.widgetStringValue = "Chess" // telephone stay place
                    case "topmostSubform[0].Page1[0].T0[1]":
                        annotation.widgetStringValue = "Current address" // current resident address
                    case "topmostSubform[0].Page1[0].T16[1]":
                        annotation.widgetStringValue = "Vaaa" //other names
                    case "topmostSubform[0].Page1[0].emp_adr[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.domicileData?.currentPhoneNum // current mobile phone number
                    case "topmostSubform[0].Page1[0].#area[12].emp_tel[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.accomodationData?.telephoneNum // current profession and position
                    case "topmostSubform[0].Page1[0].#area[12].emp_name[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.accomodationData?.name // name places stay
                    case "topmostSubform[0].Page1[0].T3[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.domicileData?.currentEmail // current resident email
                    case "topmostSubform[0].Page1[0].T68[3]":
                        annotation.widgetStringValue = pdfPreviewViewModel.miscData?.durationStay // length stay in japan
                    case "topmostSubform[0].Page2[0].guarantor_adr[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorAddress // guarantor address
                    case "topmostSubform[0].Page2[0].#area[0].guarantor_name[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorName // guarantor name
                    case "topmostSubform[0].Page2[0].#area[0].guarantor_tel[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorTelephoneNum // guarantor telpon
                    case "topmostSubform[0].Page2[0].#area[1].T14[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterDoB.formatted() // inviter date of birth
                    case "topmostSubform[0].Page2[0].T25[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterRelationship // relationship to applicant //inviter in japan
                    case "topmostSubform[0].Page2[0].T23[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterAddress //inviter in japan
                    case "topmostSubform[0].Page2[0].#area[2].T19[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterName //inviter in japan
                    case "topmostSubform[0].Page2[0].#area[2].T10[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterTelephoneNum //inviter in japan
                    case "topmostSubform[0].Page2[0].#area[3].T14[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorDoB.formatted() // guarantor dob
                    case "topmostSubform[0].Page2[0].T25[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorRelationship // guarantor relationship to applicant
                    case "topmostSubform[0].Page2[0].T28[0]":
                        annotation.widgetStringValue = "LL" //notes or remark
                    case "topmostSubform[0].Page2[0].T150[0]":
                        annotation.widgetStringValue = "MM" // date of application
                    case "topmostSubform[0].Page2[0].T5[0]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorPosition //guarantor reference position
                    case "topmostSubform[0].Page2[0].T5[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.guarantorData?.guarantorNationality//guarantor nationality and imigration status
                    case "topmostSubform[0].Page2[0].T5[2]":
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterNationality //inviter nationality
                    case "topmostSubform[0].Page2[0].T28[1]":
                        annotation.widgetStringValue = pdfPreviewViewModel.crimeRemarkData?.relevantDetails //if answer yes above explain
                    case "topmostSubform[0].Page2[0].T16[2]":
                        annotation.widgetStringValue = "" // if applicant is minor
                    case "topmostSubform[0].Page2[0].#area[4].RB5[0]": //no.2 dots no
                        if indexPrison == 0 && pdfPreviewViewModel.crimeRemarkData?.haveImprisonedOneYear == true {
                            annotation.buttonWidgetState = .onState
                            indexPrison += 1
                            break
                        } else if indexPrison == 1 && pdfPreviewViewModel.crimeRemarkData?.haveImprisonedOneYear == false {
                            annotation.buttonWidgetState = .onState
                            indexPrison += 1
                        }
                        indexPrison += 1
                    case "topmostSubform[0].Page2[0].#area[5].RB5[1]": // no.3 dots no
                        if indexDeported == 0 && pdfPreviewViewModel.crimeRemarkData?.haveDeported == true {
                            annotation.buttonWidgetState = .onState
                            indexDeported += 1
                            break
                        } else if indexDeported == 1 && pdfPreviewViewModel.crimeRemarkData?.haveDeported == false {
                            annotation.buttonWidgetState = .onState
                            indexDeported += 1
                        }
                        indexDeported += 1
                    case "topmostSubform[0].Page2[0].#area[6].RB5[2]": // no.6 dots no
                        if indexCrimeTrafficPerson == 0 && pdfPreviewViewModel.crimeRemarkData?.haveTraffickingOffence == true {
                            annotation.buttonWidgetState = .onState
                            indexCrimeTrafficPerson += 1
                            break
                        } else if indexCrimeTrafficPerson == 1 && pdfPreviewViewModel.crimeRemarkData?.haveTraffickingOffence == false {
                            annotation.buttonWidgetState = .onState
                            indexCrimeTrafficPerson += 1
                        }
                        indexCrimeTrafficPerson += 1
                    case "topmostSubform[0].Page2[0].#area[7].#area[8].RB5[3]": // no.1 dots no
                        if indexCrime == 0 && pdfPreviewViewModel.crimeRemarkData?.haveCrimeConvicted == true {
                            annotation.buttonWidgetState = .onState
                            indexCrime += 1
                            break
                        } else if indexCrime == 1 && pdfPreviewViewModel.crimeRemarkData?.haveCrimeConvicted == false {
                            annotation.buttonWidgetState = .onState
                            indexCrime += 1
                        }
                        indexCrime += 1
                    case "topmostSubform[0].Page2[0].#area[9].RB5[4]": // no.5 dots no
                        if indexProstitution == 0 && pdfPreviewViewModel.crimeRemarkData?.haveIllictOffence == true {
                            annotation.buttonWidgetState = .onState
                            indexProstitution += 1
                            break
                        } else if indexProstitution == 1 && pdfPreviewViewModel.crimeRemarkData?.haveIllictOffence == false {
                            annotation.buttonWidgetState = .onState
                            indexProstitution += 1
                        }
                        indexProstitution += 1
                    case "topmostSubform[0].Page2[0].RB5[5]": // no.4 dots no
                        if indexDrug == 0 && pdfPreviewViewModel.crimeRemarkData?.haveDrugOffence == true {
                            annotation.buttonWidgetState = .onState
                            indexDrug += 1
                            break
                        } else if indexDrug == 1 && pdfPreviewViewModel.crimeRemarkData?.haveDrugOffence == false {
                            annotation.buttonWidgetState = .onState
                            indexDrug += 1
                        }
                        indexDrug += 1
                    case "topmostSubform[0].Page2[0].T5[3]": // inviter profession and occupation
                        annotation.widgetStringValue = pdfPreviewViewModel.inviterData?.inviterPosition
                    case "topmostSubform[0].Page2[0].RB1[0]": // guarantor gender female
                        if indexGuarantorGender == 0  && pdfPreviewViewModel.guarantorData?.guarantorGender == .male  { // Male
                            annotation.buttonWidgetState = .onState
                            indexGuarantorGender += 1
                            break
                        } else if indexGuarantorGender == 1  && pdfPreviewViewModel.guarantorData?.guarantorGender == .female  { // Male
                            annotation.buttonWidgetState = .onState
                            indexGuarantorGender += 1
                            break
                        }
                        indexGuarantorGender += 1
                    case "topmostSubform[0].Page2[0].RB1[1]": // inviter gender female
                        if indexInviterGender == 0  && pdfPreviewViewModel.guarantorData?.guarantorGender == .male  { // Male
                            annotation.buttonWidgetState = .onState
                            indexInviterGender += 1
                            break
                        } else if indexInviterGender == 1  && pdfPreviewViewModel.guarantorData?.guarantorGender == .female  { // Male
                            annotation.buttonWidgetState = .onState
                            indexInviterGender += 1
                            break
                        }
                        indexInviterGender += 1

                    // Add more cases here for other fields
                    default: break
                    }
                }
            }
        }
        
        return pdfDocument
    }

    private func loadAndFillPDF() {
        // Load the PDF document (assuming it's bundled with the app)
        if let url = Bundle.main.url(forResource: "visa", withExtension: "pdf"),
           let document = PDFDocument(url: url) {
            // Fill the PDF form fields with the data from the ViewModel
            if let filledDocument = fillPDFFormFields(pdfDocument: document) {
                // Update the state property to refresh the PDFPreviewView
                pdfDocument = filledDocument
            }
        }
    }
    
    private func fetchData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await pdfPreviewViewModel.fetchPassportData() }
            group.addTask { await pdfPreviewViewModel.fetchIdentityCardData() }
            group.addTask { await pdfPreviewViewModel.fetchGuarantorData() }
            group.addTask { await pdfPreviewViewModel.fetchInviterData() }
            group.addTask { await pdfPreviewViewModel.fetchCrimeRemarkData() }
            group.addTask { await pdfPreviewViewModel.fetchTravelHistoryData() }
            group.addTask { await pdfPreviewViewModel.fetchMiscData() }
            group.addTask { await pdfPreviewViewModel.fetchDomicileData() }
            group.addTask { await pdfPreviewViewModel.fetchEmployerData() }
            group.addTask { await pdfPreviewViewModel.fetchAccomodationData() }
        }
    }
}

#Preview {
    VisaFormConfirmationPage()
}
