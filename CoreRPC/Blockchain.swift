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
        let branchlen: Int
        let hash: String
        let height: Int
        let status: String
    }
    
    // Verbosity 1 block
    struct Block: Codable {
        let bits: String
        let chainwork: String
        let confirmations: Int
        let difficulty: Double
        let hash: String
        let height: Int
        let mediantime: Int
        let merkleroot: String
        let nonce: Int
        let nextblockhash: String?
        let nTx: Int
        let previousblockhash: String
        let size: Int
        let strippedsize: Int
        let time: Int
        let tx: [String]
        let version: Int
        let versionHex: String
    }
    
    // verbosity 2 block
    struct VerboseBlock: Codable {
        let bits: String
        let chainwork: String
        let confirmations: Int
        let difficulty: Double
        let hash: String
        let height: Int
        let mediantime: Int
        let merkleroot: String
        let nonce: Int
        let nextblockhash: String?
        let nTx: Int
        let previousblockhash: String
        let size: Int
        let strippedsize: Int
        let time: Int
        let tx: [Transaction]
        let version: Int
        let versionHex: String
    }
    
    struct BlockchainInfo: Codable {
        let automatic_pruning: Bool
        let bip9_softforks: [String: BIP9SoftFork]
        let blocks: Int
        let bestblockhash: String
        let chain: String
        let chainwork: String
        let difficulty: Double
        let headers: Int
        let initialblockdownload: Bool
        let mediantime: Int
        let pruned: Bool
        let pruneheight: Int
        let size_on_disk: Int
        let softforks: [SoftFork]
        let verificationprogress: Double
        let warnings: String
    }
}
