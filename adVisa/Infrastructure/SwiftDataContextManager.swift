//
//  SwiftDataContextManager.swift
//  adVisa
//
//  Created by hendra on 14/08/24.
//

import Foundation
import SwiftData

public class SwiftDataContextManager {
    public static var shared = SwiftDataContextManager()
    var passportContainer: ModelContainer?
    var identityCardContainer: ModelContainer?
    var planeTicketContainer: ModelContainer?
    var domicileContainer: ModelContainer?
    var travelHistoryContainer: ModelContainer?
    var employerContainer: ModelContainer?
    var occupationContainer: ModelContainer?
    var guarantorContainer: ModelContainer?
    var inviterContainer: ModelContainer?
    var miscContainer: ModelContainer?
    var crimeRemarkContainer: ModelContainer?
    
    var documentContainer: ModelContainer?
    var itineraryContainer: ModelContainer?
    
    var context: ModelContext?

    init() {
        initializePassportContainer()
        initializeIdentityCardContainer()
        initializePlaneTicketContainer()
        initializeDomicileContainer()
        initializeTravelHistoryContainer()
        initializeEmployerContainer()
        initializeOccupationContainer()
        initializeGuarantorContainer()
        initializeInviterContainer()
        initializeMiscContainer()
        initializeCrimeRemarkContainer()
        
        initializeDocument()
        initializeItinerary()
    }
}
