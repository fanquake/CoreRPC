import Foundation
import PromiseKit

public extension CoreRPC {
    
    func getBlockchainInfo() -> Promise<BlockchainInfo> {
        return call(method: .getblockchaininfo, params: Empty())
    }
    
    func getBlockCount() -> Promise<Int> {
        return call(method: .getblockcount, params: Empty())
    }
    
    func getBlockHash(block: Int) -> Promise<String> {
        return call(method: .getblockhash, params: [block])
    }
    
    // verbosity = 0
    // Returns a hex encoded string
    func getSerializedBlock(hash: String) -> Promise<String> {
        return call(method: .getblock, params: GetBlockParam(hash: hash, verbosity: 0))
    }
    
    // verbosity = 1
    func getBlock(hash: String) -> Promise<Block> {
        return call(method: .getblock, params: GetBlockParam(hash: hash, verbosity: 1))
    }
    
    // verbosity = 2
    func getVerboseBlock(hash: String) -> Promise<VerboseBlock> {
        return call(method: .getblock, params: GetBlockParam(hash: hash, verbosity: 2))
    }
    
    // TODO: Set?
    func getChainTips() -> Promise<[ChainTip]> {
        return call(method: .getchaintips, params: Empty())
    }
    
    func getDifficulty() -> Promise<Double> {
        return call(method: .getdifficulty, params: Empty())
    }
    
    struct GetBlockParam: Encodable {
        let hash : String
        let verbosity: Int
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.unkeyedContainer()
            try container.encode(hash)
            try container.encode(verbosity)
        }
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

