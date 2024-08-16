//
//  PassportDataRepositoryTests.swift
//  adVisaTests
//
//  Created by hendra on 15/08/24.
//

import XCTest
import Combine
@testable import adVisa
import SwiftData

final class PassportDataRepositoryTests: XCTestCase {
    // Setup
    private var cancellables: Set<AnyCancellable> = []
    var repository: PassportRepository!
    
    override func setUp() {
        super.setUp()
        
        let contextManager = SwiftDataContextManager.shared
        contextManager.initializePassportContainer()
        repository = PassportRepository()
    }
    
    override func tearDown() {
        cancellables = []
        repository = nil
        super.tearDown()
    }
    
    // Given (Arrange)
    
    
    // When (Act)
    func testSaveAndFetchByIdSuccess() {
        // Given
        let example = PassportData(
            id: UUID().uuidString,
            surname: "Doe",
            givenName: "John",
            dateOfBirth: Date(timeIntervalSince1970: 315532800), // 1980-01-01
            city: "New York",
            state: "NY",
            country: "USA",
            gender: .male,
            maritalStatus: .single,
            nationality: "American",
            passportType: .ordinary,
            passportID: "123456789",
            placeOfIssue: "New York",
            dateOfIssue: Date(timeIntervalSince1970: 1546300800), // 2019-01-01
            issuingAuthority: "U.S. Department of State",
            dateOfExpiry: Date(timeIntervalSince1970: 1893456000) // 2030-01-01
        )
        
        // When
        let saveExpectation = XCTestExpectation(description: "Save passport data")
        let fetchExpectation = XCTestExpectation(description: "Fetch passport data by ID")
        
        repository.save(param: example)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Save failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                XCTAssertTrue(success, "Expected save to succeed")
                saveExpectation.fulfill()
                
                // Now fetch the saved data by ID
                self.repository.fetchById(id: example.id)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            XCTFail("Fetch failed with error: \(error)")
                        case .finished:
                            break
                        }
                    }, receiveValue: { fetchedData in
                        XCTAssertNotNil(fetchedData, "Expected to fetch saved data")
                        XCTAssertEqual(fetchedData?.id, example.id, "Fetched data ID should match the saved data ID")
                        XCTAssertEqual(fetchedData?.surname, example.surname, "Fetched data surname should match the saved data surname")
                        fetchExpectation.fulfill()
                    })
                    .store(in: &self.cancellables)
            })
            .store(in: &cancellables)
        
        wait(for: [saveExpectation, fetchExpectation], timeout: 5.0)
    }
}
