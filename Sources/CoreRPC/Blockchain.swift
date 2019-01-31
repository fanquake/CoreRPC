import Foundation
import PromiseKit

public extension CoreRPC {

    func getBestBlockHash() -> Promise<String> {
        return call(method: .getbestblockhash, params: Empty())
    }
    
    func getBlockchainInfo() -> Promise<BlockchainInfo> {
        return call(method: .getblockchaininfo, params: Empty())
    }
    
    func getBlockCount() -> Promise<Int> {
        return call(method: .getblockcount, params: Empty())
    }
    
    func getBlockHash(block: Int) -> Promise<String> {
        return call(method: .getblockhash, params: [block])
    }

    struct BlockHeader: Decodable {
        let bits: String
        let chainwork: String
        let confirmations: Int
        let difficulty: Double
        let hash: String
        let height: Int
        let mediantime: Int
        let merkleroot: String
        let nextblockhash: String?
        let nonce: Int
        let nTx: Int
        let time: Int
        let previousblockhash: String?
        let version: Int
        let versionHex: String
    }

    func getBlockHeader(hash: String) -> Promise<BlockHeader> {
        return call(method: .getblockheader, params: [hash])
    }
    
    // verbosity = 0
    // Returns a hex encoded string
    func getSerializedBlock(hash: String) -> Promise<String> {
        return call(method: .getblock, params: GetBlockParam(blockhash: hash, verbosity: 0))
    }
    
    // verbosity = 1
    func getBlock(hash: String) -> Promise<Block> {
        return call(method: .getblock, params: GetBlockParam(blockhash: hash, verbosity: 1))
    }
    
    // verbosity = 2
    func getVerboseBlock(hash: String) -> Promise<VerboseBlock> {
        return call(method: .getblock, params: GetBlockParam(blockhash: hash, verbosity: 2))
    }
    
    // TODO: Set?
    func getChainTips() -> Promise<[ChainTip]> {
        return call(method: .getchaintips, params: Empty())
    }
    
    func getDifficulty() -> Promise<Double> {
        return call(method: .getdifficulty, params: Empty())
    }
    
    struct GetBlockParam: Encodable {
        let blockhash : String
        let verbosity: Int
    }
    
    struct ChainTip: Decodable {

        public enum Status: String, Decodable {
            case active // This is the tip of the active main chain, which is certainly valid
            case headersOnly = "headers-only" // Not all blocks for this branch are available, but the headers are valid
            case invalid // This branch contains at least one invalid block
            case validFork = "valid-fork" // This branch is not part of the active chain, but is fully validated
            case validHeaders = "valid-headers" // All blocks are available for this branch, but they were never fully validated
        }

        public let branchlen: Int
        public let hash: String
        public let height: Int
        public let status: Status
    }
    
    // Verbosity 1 block
    struct Block: Decodable {
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
        public let previousblockhash: String?
        public let size: Int
        public let strippedsize: Int
        public let time: Int
        public let tx: [String]
        public let version: Int
        public let versionHex: String
        public let weight: Int
    }
    
    // verbosity 2 block
    struct VerboseBlock: Decodable {
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
        public let previousblockhash: String?
        public let size: Int
        public let strippedsize: Int
        public let time: Int
        public let tx: [Transaction]
        public let version: Int
        public let versionHex: String
        public let weight: Int
    }
    
    struct BlockchainInfo: Decodable {
        public let automatic_pruning: Bool?
        public let bip9_softforks: [String: BIP9SoftFork]
        public let blocks: Int
        public let bestblockhash: String
        public let chain: NetworkName
        public let chainwork: String
        public let difficulty: Double
        public let headers: Int
        public let initialblockdownload: Bool
        public let mediantime: Int
        public let pruned: Bool
        public let pruneheight: Int?
        public let size_on_disk: Int
        public let softforks: [SoftFork]
        public let verificationprogress: Double
        public let warnings: String
    }

    public enum NetworkName: String, Decodable {
        case main
        case test
        case regtest
    }
}

