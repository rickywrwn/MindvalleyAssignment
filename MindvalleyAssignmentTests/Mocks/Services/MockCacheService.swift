//
//  MockCacheService.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockCacheService: CacheServiceProtocol {
    var savedObjects: [String: Any] = [:]
    var shouldThrowError = false
    
    func save<T: Encodable>(_ object: T, forKey key: String) throws {
        if shouldThrowError {
            throw CacheError.failedToGetCacheDirectory
        }
        savedObjects[key] = object
    }
    
    func retrieve<T: Decodable>(forKey key: String) throws -> T? {
        if shouldThrowError {
            throw CacheError.failedToGetCacheDirectory
        }
        return savedObjects[key] as? T
    }
    
    func removeObject(forKey key: String) {
        savedObjects.removeValue(forKey: key)
    }
    
    func clear() {
        savedObjects.removeAll()
    }
}
