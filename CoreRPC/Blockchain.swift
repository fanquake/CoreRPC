//
//  Blockchain.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    
    func getBlockchainInfo(completion: @escaping (RPCResult<BlockchainInfo>) -> Void) {
        call(method: .getblockchaininfo, params: nil) { completion($0) }
    }
    
    func getBlockCount(completion: @escaping (RPCResult<Int>) -> Void) {
        call(method: .getblockcount, params: nil) { completion($0) }
    }
    
    func getBlockHash(block: Int, completion: @escaping (RPCResult<String>) -> Void) {
        call(method: .getblockhash, params: [block]) { completion($0) }
    }
    
    // verbosity = 0
    // Returns a hex encoded string
    func getSerializedBlock(hash: String, completion: @escaping (RPCResult<String>) -> Void) {
        call(method: .getblock, params: [hash, 0]) { completion($0) }
    }
    
    // verbosity = 1
    func getBlock(hash: String, completion: @escaping (RPCResult<Block>) -> Void) {
        call(method: .getblock, params: [hash, 1]) { completion($0) }
    }
    
    // verbosity = 2
    func getVerboseBlock(hash: String, completion: @escaping (RPCResult<VerboseBlock>) -> Void) {
        call(method: .getblock, params: [hash, 2]) { completion($0) }
    }
    
    // TODO: Set?
    func getChainTips(completion: @escaping (RPCResult<[ChainTip]>) -> Void) {
        call(method: .getchaintips, params: nil) { completion($0) }
    }
    
    func getDifficulty(completion: @escaping (RPCResult<Double>) -> Void) {
        call(method: .getdifficulty, params: nil) { completion($0) }
    }
    
    struct ChainTip: Codable {
        public let branchlen: Int
        public let hash: String
        public let height: Int
        public let status: String
    }
    
    // Verbosity 1 block
    struct Block: Codable {
        public let bits: String
        public let chainwork: String
        public let confirmations: Int
        public let difficulty: Double
        public let hash: String
        public let height: Int
        public let mediantime: Int
        public let merkleroot: String
        public let nonce: Int
        public let nextblockhash: String?
        public let nTx: Int
        public let previousblockhash: String
        public let size: Int
        public let strippedsize: Int
        public let time: Int
        public let tx: [String]
        public let version: Int
        public let versionHex: String
    }
    
    // verbosity 2 block
    struct VerboseBlock: Codable {
        public let bits: String
        public let chainwork: String
        public let confirmations: Int
        public let difficulty: Double
        public let hash: String
        public let height: Int
        public let mediantime: Int
        public let merkleroot: String
        public let nonce: Int
        public let nextblockhash: String?
        public let nTx: Int
        public let previousblockhash: String
        public let size: Int
        public let strippedsize: Int
        public let time: Int
        public let tx: [Transaction]
        public let version: Int
        public let versionHex: String
    }
    
    struct BlockchainInfo: Codable {
        public let automatic_pruning: Bool
        public let bip9_softforks: [String: BIP9SoftFork]
        public let blocks: Int
        public let bestblockhash: String
        public let chain: String
        public let chainwork: String
        public let difficulty: Double
        public let headers: Int
        public let initialblockdownload: Bool
        public let mediantime: Int
        public let pruned: Bool
        public let pruneheight: Int
        public let size_on_disk: Int
        public let softforks: [SoftFork]
        public let verificationprogress: Double
        public let warnings: String
    }
}
