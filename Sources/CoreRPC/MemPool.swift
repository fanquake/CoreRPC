import Foundation
import PromiseKit

public extension CoreRPC {

    struct MemPoolEntry: Codable {

        struct Fees: Codable {
            let ancestor: Double
            let base: Double
            let descendant: Double
            let modified: Double
        }

        let ancestorcount: Int
        let ancestorfees: Int
        let ancestorsize: Int
        // TODO: let bip125-replaceable: Bool
        let depends: [String]
        let descendantcount: Int
        let descendantfees: Int
        let descendantsize: Int
        let fee: Double
        let fees: Fees
        let height: Int
        let modifiedfee: Double
        let spentby: [String]
        let time: Int
        let vsize: Int
        let weight: Int
        let wtxid: String
    }

    func getMempoolEntry(txid: String) -> Promise<MemPoolEntry> {
        return call(method: .getmempoolentry, params: [txid])
    }

    func memPoolInfo() -> Promise<MemPoolInfo> {
        return call(method: .getmempoolinfo, params: Empty())
    }

    struct MemPoolInfo: Codable {
        public let bytes: Int
        public let maxmempool: Int
        public let mempoolminfee: Double
        public let minrelaytxfee: Double
        public let size: Int
        public let usage: Int
    }

    func getRawMempool() -> Promise<[String]> {
        return call(method: .getrawmempool, params: Empty())
    }
}
