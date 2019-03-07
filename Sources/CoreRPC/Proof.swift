import Foundation
import PromiseKit

public extension CoreRPC {

    func getTxOutProof(txids: [String], blockHash: String?) -> Promise<String> {

        struct TxOutProofParams: Codable {
            let blockhash: String?
            let txids: [String]
        }

        let params = TxOutProofParams(blockhash: blockHash, txids: txids)

        return call(method: .gettxoutproof, params: params)
    }

    func verifyTxOutProof(_ proof: String) -> Promise<[String]> {
        return call(method: .verifytxoutproof, params: [proof])
    }

}
