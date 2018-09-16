//
//  Transaction.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
 
    public struct Transaction: Codable {
        let hash: String
        let hex: String
        let locktime: Int
        let size: Int
        let txid: String
        let version: Int
        let vin: [vIn]
        let vout: [vOut]
        let vsize: Int
        let weight: Int
        
        struct vIn: Codable {
            let coinbase: String?
            let scriptSig: scriptSig?
            let sequence: Int
            let txid: String?
            let txinwitness: [String]?
            let vout: Int?
        }
        
        struct vOut: Codable {
            let n: Int
            let scriptPubKey: scriptPubKey
            let value: Double
        }
        
        struct scriptSig: Codable {
            let asm: String
            let hex: String
        }
        
        struct scriptPubKey: Codable {
            let addresses: [String]?
            let asm: String
            let hex: String
            let reqSigs: Int?
            let type: String // TODO: scriptPubKeyTypes
        }
        
        func isCoinbaseTx() -> Bool {
            return vin.contains(where: {$0.coinbase != nil})
        }
    }
}
