import Foundation
import PromiseKit

public extension CoreRPC {

    enum BlockStat: String, Codable {
        case avgfee
        case avgfeerate
        case avgtxsize
        case blockhash
        case feerate_percentiles
        case height
        case ins
        case maxfee
        case maxfeerate
        case maxtxsize
        case medianfee
        case mediantime
        case mediantxsize
        case minfee
        case minfeerate
        case mintxsize
        case outs
        case subsidy
        case swtotal_size
        case swtotal_weight
        case swtxs
        case time
        case total_out
        case total_size
        case total_weight
        case totalfee
        case txs
        case utxo_increase
        case utxo_size_inc
    }

    struct BlockStats: Codable {
        public let avgfee: Int?
        public let avgfeerate: Int?
        public let avgtxsize: Int?
        public let blockhash: String?
        public let feerate_percentiles: [Int]?
        public let height: Int?
        public let ins: Int?
        public let maxfee: Int?
        public let maxfeerate: Int?
        public let maxtxsize: Int?
        public let medianfee: Int?
        public let mediantime: Int?
        public let mediantxsize: Int?
        public let minfee: Int?
        public let minfeerate: Int?
        public let mintxsize: Int?
        public let outs: Int?
        public let subsidy: Int?
        public let swtotal_size: Int?
        public let swtotal_weight: Int?
        public let swtxs: Int?
        public let time: Int?
        public let total_out: Int?
        public let total_size: Int?
        public let total_weight: Int?
        public let totalfee: Int?
        public let txs: Int?
        public let utxo_increase: Int?
        public let utxo_size_inc: Int?
    }

    func getBlockStats(height: Int, stats: [BlockStat]?) -> Promise<BlockStats> {

        struct BlockStatParams: Encodable {
            let hash_or_height: Int
            let stats: [BlockStat]?
        }

        let params = BlockStatParams(hash_or_height: height, stats: stats)

        return call(method: .getblockstats, params: params)
    }

    struct ChainStats: Codable {
        let time: Int
        let txcount: Int
        let txrate: Decimal?
        let window_final_block_hash: String
        let window_final_block_height: Int
        let window_block_count: Int
        let window_interval: Int?
        let window_tx_count: Int?
    }

    func getChainTxStats(blocks: Int?, blockHash: String?) -> Promise<ChainStats> {

        struct ChainStatParams: Codable {
            let blockhash: String?
            let nblocks: Int?
        }

        let params = ChainStatParams(blockhash: blockHash, nblocks: blocks)

        return call(method: .getchaintxstats, params: params)
    }

}
