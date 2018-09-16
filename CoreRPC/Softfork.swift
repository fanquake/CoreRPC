//
//  Softfork.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
 
    public struct SoftFork: Codable {
        let id: String
        let version: Int
        let reject: [String: Bool]
    }
    
    public struct BIP9SoftFork: Codable {
        let since: Int
        let startTime: Int
        let status: String
        let timeout: Int
    }
}
