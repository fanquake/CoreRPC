import Foundation
import PromiseKit

public extension CoreRPC {

    struct PSBT: Codable {

        enum Role: String, Codable {
            case creator
            case combiner
            case extractor
            case finalizer
            case signer
            case updater
        }

        struct Missing: Codable {
            let pubkeys: [String]?
            let signatures: [String]?
            let redeemscript: String?
            let witnessscript: String?
        }

        struct Input: Codable {
            let has_utxo: Bool
            let is_final: Bool
            let missing: Missing?
            let next: Role?
        }

        let estimated_feerate: Decimal?
        let estimated_vsize: Int?
        let fee: Decimal?
        let inputs: [Input]
        let next: Role
    }

    func analyzePSBT(psbt: String) -> Promise<PSBT> {
        return call(method: .analyzepsbt, params: [psbt])
    }

}
