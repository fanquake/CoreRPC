//
//  Softfork.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
 
    public struct SoftFork: Codable {
        public let id: String
        public let version: Int
        public let reject: [String: Bool]
    }
    
    public struct BIP9SoftFork: Codable {
        public let since: Int
        public let startTime: Int
        public let status: String
        public let timeout: Int
    }
}
