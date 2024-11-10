//
//  CacheServiceTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 10/11/24.
//


import XCTest
@testable import MindvalleyAssignment

final class CacheServiceTests: XCTestCase {
    var cacheService: CacheService!
    
    override func setUp() {
        super.setUp()
        do
        {
            cacheService = try CacheService()
        } catch {
            print("error in setting up cache service")
        }
    }
    
    override func tearDown() {
        cacheService = nil
        super.tearDown()
    }
    
    struct TestObject: Codable, Equatable {
        let id: Int
        let value: String
        
        static func == (lhs: TestObject, rhs: TestObject) -> Bool {
            return lhs.id == rhs.id &&
                   lhs.value == rhs.value
        }
    }

    
    func testSaveAndRetrieveObject() throws {
        // Given
        let testObject = TestObject(id: 1, value: "Test")
        let key = "test_key"
        
        // When
        try cacheService.save(testObject, forKey: key)
        let retrievedObject: TestObject? = try cacheService.retrieve(forKey: key)
        
        // Then
        XCTAssertEqual(retrievedObject, testObject)
    }

    func testRetrieveNonexistentKey() throws {
        // Given
        let key = "nonexistent_key"
        
        // When
        let retrievedObject: TestObject? = try cacheService.retrieve(forKey: key)
        
        // Then
        XCTAssertNil(retrievedObject)
    }

}
