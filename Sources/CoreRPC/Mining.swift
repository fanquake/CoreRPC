import Foundation
import PromiseKit

public extension CoreRPC {

    func getNetworkHashPerSecond(nblocks: Int?, height: Int?) -> Promise<Double> {

        struct NetworkHashPerSecond: Encodable {
            let height: Int?
            let nblocks: Int?
        }

        let params = NetworkHashPerSecond(height: height, nblocks: nblocks)

        return call(method: .getnetworkhashps, params: params)
    }

    func generatetoaddress(blocks: Int, address: String, maxtries: Int?) -> Promise<[String]> {

        struct generateParams: Encodable {
            let nblocks: Int
            let address: String
            let maxtries: Int?
        }

        let params = generateParams(nblocks: blocks, address: address, maxtries: maxtries)

        return call(method: .generatetoaddress, params: params)
    }
    
    func getMiningInfo() -> Promise<MiningInfo> {
        return call(method: .getmininginfo, params: Empty())
    }
    
    struct MiningInfo: Decodable {
        public let blocks: Int
        public let chain: NetworkName
        public let currentblocktx: Int
        public let currentblockweight: Int
        public let difficulty: Double
        public let networkhashps: Double
        public let pooledtx: Int
        public let warnings: String
    }
    
}
