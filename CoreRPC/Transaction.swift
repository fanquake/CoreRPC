//
//  Transaction.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
 
    public struct Transaction: Codable {
        public let hash: String
        public let hex: String
        public let locktime: Int
        public let size: Int
        public let txid: String
        public let version: Int
        public let vin: [vIn]
        public let vout: [vOut]
        public let vsize: Int
        public let weight: Int
        
        public struct vIn: Codable {
            public let coinbase: String?
            public let scriptSig: scriptSig?
            public let sequence: Int
            public let txid: String?
            public let txinwitness: [String]?
            public let vout: Int?
        }
        
        public struct vOut: Codable {
            public let n: Int
            public let scriptPubKey: scriptPubKey
            public let value: Double
        }
        
        public struct scriptSig: Codable {
            public let asm: String
            public let hex: String
        }
        
        public struct scriptPubKey: Codable {
            public let addresses: [String]?
            public let asm: String
            public let hex: String
            public let reqSigs: Int?
            public let type: String // TODO: scriptPubKeyTypes
        }
        
        func isCoinbaseTx() -> Bool {
            return vin.contains(where: {$0.coinbase != nil})
        }
    }
}
