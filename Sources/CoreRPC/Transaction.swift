import Foundation
import PromiseKit

public extension CoreRPC {

    public struct FundedRawTransaction: Decodable {
        public let hex: String
        public let fee: Double
        public let changepos: Int
    }

    func fundRawTransaction(hex: String) -> Promise<FundedRawTransaction> {
        return call(method: .fundrawtransaction, params: [hex])
    }

    public struct SignedRawTransaction: Decodable {

        public struct SigningError: Decodable {
            public let txid: String
            public let vout: Int
            public let scriptSig: String
            public let sequence: Int
            public let error: String
        }

        public let complete: Bool
        public let errors: [SigningError]?
        public let hex: String
    }

    func signRawTransactionWithWallet(hex: String) -> Promise<SignedRawTransaction> {
        return call(method: .signrawtransactionwithwallet, params: [hex])
    }

    func sendrawtransaction(hex: String) -> Promise<String> {
        return call(method: .sendrawtransaction, params: [hex])
    }
    
    public struct Transaction: Codable {
        public let hash: String
        public let hex: String
        public let locktime: Int
        public let size: Int
        public let txid: String
        public let version: Int
        public let vin: [vIn]
        public let vout: [vOut]
        public let vsize: Int
        public let weight: Int
        
        public struct vIn: Codable {
            public let coinbase: String?
            public let scriptSig: scriptSig?
            public let sequence: Int
            public let txid: String?
            public let txinwitness: [String]?
            public let vout: Int?
        }
        
        public struct vOut: Codable {
            public let n: Int
            public let scriptPubKey: scriptPubKey
            public let value: Double
        }
        
        public struct scriptSig: Codable {
            public let asm: String
            public let hex: String
        }
        
        public struct scriptPubKey: Codable {
            public let addresses: [String]?
            public let asm: String
            public let hex: String
            public let reqSigs: Int?
            public let type: String // TODO: scriptPubKeyTypes
        }
        
        public func isCoinbaseTx() -> Bool {
            return vin.contains(where: {$0.coinbase != nil})
        }
    }
}
